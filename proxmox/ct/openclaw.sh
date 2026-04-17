#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2026 community-scripts ORG
# Author: dkmajuso
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://openclaw.ai

APP="OpenClaw"
var_tags="${var_tags:-ai;agent;assistant}"
var_cpu="${var_cpu:-2}"
var_ram="${var_ram:-4096}"
var_disk="${var_disk:-8}"
var_os="${var_os:-debian}"
var_version="${var_version:-13}"
var_unprivileged="${var_unprivileged:-1}"

header_info "$APP"
variables
color
catch_errors

function update_script() {
  header_info
  check_container_storage
  check_container_resources

  if ! command -v openclaw &>/dev/null; then
    msg_error "No ${APP} Installation Found!"
    exit
  fi

  CURRENT=$(cat /opt/OpenClaw_version.txt 2>/dev/null || echo "0.0.0")
  LATEST=$(npm view openclaw version 2>/dev/null)

  if [[ -z "${LATEST}" ]]; then
    msg_error "Failed to fetch latest version from npm"
    exit
  fi

  if [[ "${CURRENT}" != "${LATEST}" ]]; then
    msg_info "Stopping Service"
    systemctl stop openclaw
    msg_ok "Stopped Service"

    msg_info "Updating OpenClaw to v${LATEST}"
    $STD npm install -g openclaw@latest
    echo "${LATEST}" >/opt/OpenClaw_version.txt
    msg_ok "Updated OpenClaw to v${LATEST}"

    msg_info "Starting Service"
    systemctl start openclaw
    msg_ok "Started Service"
    msg_ok "Updated successfully!"
  else
    msg_ok "No update required. OpenClaw is already at v${CURRENT}"
  fi
  exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Complete setup by running:${CL}"
echo -e "${TAB}${BGN}openclaw onboard${CL}"
echo -e "${INFO}${YW} Then start the service:${CL}"
echo -e "${TAB}${BGN}systemctl start openclaw${CL}"
echo -e "${INFO}${YW} Access the Web UI at:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}:18789${CL}"
