#!/usr/bin/env bash

# Copyright (c) 2021-2026 community-scripts ORG
# Author: dkmajuso
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://openclaw.ai

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y \
  build-essential \
  git \
  ca-certificates \
  gnupg
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" >/etc/apt/sources.list.d/nodesource.list
$STD apt-get update
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
$STD apt-get install -y nodejs
msg_ok "Installed Node.js $(node -v)"

msg_info "Installing OpenClaw"
$STD npm install -g openclaw@latest
RELEASE=$(openclaw --version 2>/dev/null | grep -oE '[0-9]+\.[0-9.]+' | head -1)
echo "${RELEASE}" >/opt/OpenClaw_version.txt
msg_ok "Installed OpenClaw v${RELEASE}"

msg_info "Configuring OpenClaw"
mkdir -p /root/.openclaw
cat <<'CONF' >/root/.openclaw/openclaw.json
{
  "gateway": {
    "bind": "lan",
    "port": 18789,
    "controlUi": {
      "enabled": true
    }
  }
}
CONF
msg_ok "Configured OpenClaw"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/openclaw.service
[Unit]
Description=OpenClaw AI Assistant Gateway
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$(which openclaw) gateway
Environment=NODE_ENV=production
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q openclaw
msg_ok "Created Service"

motd_ssh
customize
cleanup_lxc
