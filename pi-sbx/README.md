# Personal MBM pi sandbox

`pi-sbx` launches pi in one persistent Docker Sandbox per MBM worktree. This is personal tooling for Mathias's Apple-silicon Mac, not a portable MBM team launcher or setup script.

## Supported layout

Only this checkout topology is accepted:

```text
~/git/lego/mbm-worktrees/mbm              # main checkout
~/git/lego/mbm-worktrees/mbm/.git         # shared Git directory
~/git/lego/mbm-worktrees/<worktree>        # secondary worktrees
~/git/lego/mbm-worktrees/.pi               # project pi links
~/dotfiles/pi/.pi/agent                     # static personal pi source
~/.local/share/pi-sbx/mbm-cli               # shared Linux CLI cache
```

Run the launcher from any directory inside the main checkout or a registered secondary worktree. The common Git directory must resolve to the path above. Each worktree must have `.pi/settings.json` referencing `../../.pi/skills` and `../../.pi/extensions`; the launcher validates but does not repair these files or links.

## Installation and prerequisites

From `~/dotfiles`, expose the package through GNU Stow:

```bash
stow pi-sbx
```

Install `sbx` version 0.35.0 or newer separately. The launcher never installs, upgrades, signs in, resets, or initializes `sbx`:

```bash
sbx version
sbx login
sbx policy init balanced
```

Initialize the Balanced policy only if no policy has been initialized. Do not reset an existing policy just to run this launcher. The current Balanced baseline also needs explicit access to the package hosts used during setup:

```bash
sbx policy allow network deb.nodesource.com
sbx policy allow network api.nuget.org
sbx policy allow network nuget.pkg.github.com
sbx policy allow network registry.npmjs.org
sbx policy allow network npm.pkg.github.com
```

Store a global GitHub secret for GitHub API requests and HTTPS Git operations:

```bash
gh auth token | sbx secret set -g github
```

Export the LEGO gateway credential in the host shell before every launch:

```bash
export LEGO_AI_MODEL_GATEWAY_AUTH_TOKEN=...
```

On first launch, the launcher stores this value as a global Docker Sandbox custom secret. The sandbox receives only a generated `LEGO_AI_MODEL_GATEWAY_AUTH_TOKEN` placeholder, and Docker's host proxy substitutes the real value for requests to `api.genai.thelegogroup.com`. The token is not copied into the sandbox. If the Keychain value rotates, remove the existing custom secret by its placeholder (`sbx secret ls` and `sbx secret rm -g --placeholder <placeholder> -f`); the next launch recreates it.

The host SSH agent must be forwarded through `SSH_AUTH_SOCK` and contain this work signing key:

```text
SHA256:dLFjku94LM9gD2KYBtMqQbnMTepubBgCVGd+KBU/+Jg
```

Register the same public key as an SSH signing key in GitHub. Creation and every reconnect fail if that exact key is unavailable.

Private package- or container-registry credentials are a separate, explicit setup concern. They are not imported by this package. MBM currently needs sandbox-local credentials for `LEGO.DBILib` from GitHub NuGet Packages and `@lego` packages from GitHub npm Packages. Configure those in the new sandbox's `/home/agent/.nuget/NuGet/NuGet.Config` and `/home/agent/.npmrc`, then rerun `/home/agent/.local/bin/pi-sbx-install`. Do not mount the host credential files or commit tokens. The package token must have GitHub Packages read access and organization authorization.

## Commands

```bash
pi-sbx                         # create/reconnect and launch interactive pi
pi-sbx -- <pi arguments...>    # pass arguments unchanged to pi
pi-sbx update                  # update pi in an existing sandbox and exit
```

Examples:

```bash
pi-sbx -- --model "lego-gateway-openai/GPT 5.6 Sol"
pi-sbx -- -p "Run the unit tests"
```

Arguments before `--` are rejected except for the exact `update` subcommand. Pi runs as `pi --approve` so the worktree's project settings can load the parent-scoped MBM skills and extensions.

## Creation and lifecycle

The sandbox name is `pi-mbm-<normalized-worktree-directory>`. Creation installs .NET 10, Node 24 when needed, `fd-find`, `fzf`, pnpm 11.11.0, latest pi, and repository dependencies. It does not build or test MBM. Setup runs once; later invocations reconnect to persistent sandbox-local sessions, packages, caches, Docker state, and pi state.

An existing sandbox is accepted only when its primary workspace, kit identity, and implementation marker match. The launcher never migrates, removes, or recreates one. After a kit-version mismatch, intentionally discard its local state and recreate it:

```bash
sbx rm pi-mbm-<worktree>
pi-sbx
```

Useful direct operations:

```bash
sbx inspect pi-mbm-<worktree>
sbx stop pi-mbm-<worktree>
sbx rm pi-mbm-<worktree>
```

Removal permanently discards that sandbox's pi sessions, packages, caches, private Docker images, containers, and volumes.

## Mounts and security implications

Every sandbox receives these host mounts:

- active worktree, read-write and primary;
- parent `~/git/lego/mbm-worktrees/.pi`, read-only;
- static `~/dotfiles/pi/.pi/agent`, read-write;
- shared `~/.local/share/pi-sbx/mbm-cli`, read-write.

Secondary worktrees also receive the main checkout's `.git` read-write and canonical `agents` read-only. Consequently pi can modify or delete active worktree files and personal allowlisted configuration. In a secondary worktree it can alter shared objects, refs, logs, hooks, configuration, and worktree metadata used by all host worktrees. Concurrent host and sandbox Git operations can contend on lock files.

The live host `~/.pi/agent` is never mounted. Sandbox pi state lives under `/home/agent/.pi/agent`; only allowlisted static files are symlinked from dotfiles. Authentication, sessions, trust state, history, logs, downloaded packages, repositories, and caches are excluded. `notify.ts` and `pi-caffeinate.ts` are not exposed.

Docker commands use the sandbox-private daemon. Passwordless `sudo` changes only the sandbox VM.

## Shared MBM CLI

All worktree sandboxes use one Linux CLI cache. The first sandbox publishes it if absent. Normal `mbm` commands execute the cached binary. Rebuild it from the current worktree with:

```bash
mbm build-cli
```

Publication uses an inter-process lock, a temporary release directory, and an atomic `current` symlink replacement. Completed old release directories remain in the cache so already-running processes retain their companion files. The last successful build wins across every sandbox; a failed publish leaves the prior `current` release intact.

## Troubleshooting

For blocked package or tool downloads, inspect network decisions first:

```bash
sbx policy log pi-mbm-<worktree>
```

Then inspect the sandbox, policy, secret, host token, and loaded signing keys:

```bash
sbx inspect pi-mbm-<worktree>
sbx policy ls pi-mbm-<worktree> --wide
sbx secret ls --service github
ssh-add -l
```

The launcher reports manual remediation for stale kit state, absent credentials, invalid worktree links, and missing signing keys. It deliberately does not repair these conditions.
