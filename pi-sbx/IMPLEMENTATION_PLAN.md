# MBM Pi Docker Sandbox Launcher — Implementation Plan

## Goal

Add a personal, MBM-specific Bash launcher for running pi in a persistent Docker Sandbox for each MBM worktree.

The implementation is intentionally limited to the current Apple-silicon macOS checkout layout. It is not team tooling, a generic repository launcher, or setup automation.

## Scope

### Included

- Run from any directory inside a registered MBM worktree.
- Create or reconnect to one persistent sandbox per worktree.
- Use the standalone `sbx` CLI and a local sandbox kit based on `docker/sandbox-templates:shell-docker`.
- Mount the active worktree read-write.
- Make Git work in secondary worktrees by mounting the main checkout's shared `.git` metadata read-write.
- Load canonical MBM skills and extensions from the main checkout.
- Load allowlisted personal pi configuration without exposing live host pi runtime state.
- Keep sandbox-local pi runtime state writable and persistent.
- Install the MBM development prerequisites, latest pi, and repository dependencies at sandbox creation.
- Provide a private Docker Engine through the `shell-docker` base image.
- Support GitHub API and HTTPS Git operations through Docker Sandbox credentials.
- Support mandatory SSH commit signing through the forwarded host SSH agent.
- Share one Linux MBM CLI build across all worktree sandboxes.
- Provide an explicit pi update command.

### Excluded

- Team portability.
- Generic repository support.
- Automatic installation or upgrade of `sbx`.
- Automatic `sbx` login, policy initialization, credential import, or worktree `.pi` repair.
- Authentication, authorization, secret, or session files from the live host `~/.pi/agent`.
- Clone-mode workspaces.
- Automatic kit migration for existing sandboxes.
- Automatic builds or tests at sandbox creation.
- Automated tests for the initial Bash implementation.

## Planned files

```text
pi-sbx/
├── .config/
│   └── pi-sbx/
│       └── mbm/
│           ├── spec.yaml
│           └── files/
│               └── home/
│                   └── .local/
│                       └── bin/
│                           ├── mbm
│                           └── pi-sbx-entrypoint
├── .local/
│   └── bin/
│       └── pi-sbx
├── IMPLEMENTATION_PLAN.md
└── README.md
```

The package will be exposed through the repository's existing GNU Stow workflow:

```text
~/.local/bin/pi-sbx
~/.config/pi-sbx/mbm/spec.yaml
```

Helper names and exact placement may be adjusted if `sbx kit validate` requires a different static-file layout, but they remain internal to the package.

## Fixed local layout

The launcher will target these paths only:

```text
~/git/lego/mbm-worktrees/mbm
~/git/lego/mbm-worktrees/.pi
~/dotfiles/pi/.pi/agent
~/.local/share/pi-sbx/mbm-cli
```

The expected Git topology is:

```text
~/git/lego/mbm-worktrees/mbm/.git
~/git/lego/mbm-worktrees/<secondary>/.git
```

A secondary worktree's `.git` file must resolve beneath:

```text
~/git/lego/mbm-worktrees/mbm/.git/worktrees/
```

## Public command interface

```bash
pi-sbx
pi-sbx -- <pi arguments...>
pi-sbx update
```

### `pi-sbx`

Validate prerequisites, create or reconnect to the current worktree's sandbox, and launch interactive pi.

### `pi-sbx -- <pi arguments...>`

Pass all arguments after `--` unchanged to pi.

Examples:

```bash
pi-sbx -- --model "lego-gateway-openai/GPT 5.6 Sol"
pi-sbx -- -p "Run the unit tests"
```

Arguments before `--`, other than the exact `update` subcommand, will be rejected to keep parsing unambiguous.

### `pi-sbx update`

Require an existing sandbox and run the internal update operation:

```bash
sudo npm install --global @earendil-works/pi-coding-agent@latest
```

This updates pi only. It does not update configured pi packages or personal extensions.

## Sandbox identity and lifecycle

1. Resolve the active worktree root with Git from the current directory.
2. Verify the worktree belongs to the expected MBM common Git directory.
3. Derive the sandbox name from the canonical worktree root basename:

   ```text
   pi-mbm-<normalized-worktree-directory>
   ```

4. Normalize unsupported characters to `-` and reject an empty result.
5. Query `sbx ls --json` to distinguish creation from reconnection.
6. For an existing sandbox:
   - verify its primary workspace equals the canonical active worktree root;
   - check the internal launcher/kit version marker;
   - fail on missing or mismatched state rather than attaching ambiguously.
7. For a new sandbox:
   - validate the kit;
   - create it with the full workspace mount list and explicit name;
   - let kit installation finish before pi starts.
8. Never remove or recreate a sandbox automatically.

If the kit version changes, report explicit recovery commands:

```bash
sbx rm pi-mbm-<worktree>
pi-sbx
```

Removing a sandbox intentionally discards its sandbox-local sessions, packages, caches, Docker images, containers, and volumes.

## Host launcher preflight

Run preflight before every launch. Fail with a concise reason and exact remediation where possible.

### Platform and executable checks

- macOS only.
- Apple silicon only (`arm64`).
- `bash`, `git`, `ssh-add`, and `sbx` available.
- `sbx` version parses and is at least `0.35.0`.
- `sbx` is usable and signed in.
- Network policy has been initialized; do not initialize or replace it.
- The effective user-selected policy is expected to provide the Balanced development baseline.

### Repository checks

- Current directory is inside a Git worktree.
- Canonical worktree root is under `~/git/lego/mbm-worktrees`.
- `git rev-parse --git-common-dir` resolves to `~/git/lego/mbm-worktrees/mbm/.git`.
- Main checkout, shared `.git`, canonical `agents`, and parent `.pi` exist.
- The active worktree contains `.pi/settings.json` pointing to the parent-scoped resources.
- Parent `.pi` links resolve into the canonical main-checkout `agents` tree.

The launcher validates these facts but does not repair them.

### Personal pi configuration checks

Require `~/dotfiles/pi/.pi/agent` and all allowlisted entries used by the kit.

Refuse to launch if the source contains known runtime-state entries, including at least:

```text
auth.json
sessions/
run-history.jsonl
pi-debug.log
trust.json
npm/
git/
bin/
```

Extend this denylist for other authentication, session, history, log, and cache names found while implementing. Do not mount the live host `~/.pi/agent` under any circumstance.

### Credential checks

- `LEGO_AI_MODEL_GATEWAY_AUTH_TOKEN` is set on the host.
- A Docker Sandbox `github` secret is present.
- `SSH_AUTH_SOCK` is set.
- The forwarded host agent contains the required work signing key:

  ```text
  SHA256:dLFjku94LM9gD2KYBtMqQbnMTepubBgCVGd+KBU/+Jg
  ```

Extract and retain the matching public key for sandbox Git configuration. Do not select the first loaded SSH key.

### Generated state checks

Create only launcher-owned host state:

```text
~/.local/share/pi-sbx/mbm-cli
```

The shared CLI cache must be writable.

## Workspace mounts

All paths appear inside the sandbox at their absolute host paths.

### Every worktree

1. Active worktree, read-write and primary:

   ```text
   <active-worktree>
   ```

2. Parent pi configuration, read-only:

   ```text
   ~/git/lego/mbm-worktrees/.pi:ro
   ```

3. Personal static pi source, read-write:

   ```text
   ~/dotfiles/pi/.pi/agent
   ```

4. Shared Linux MBM CLI cache, read-write:

   ```text
   ~/.local/share/pi-sbx/mbm-cli
   ```

### Secondary worktrees only

5. Shared Git metadata, read-write:

   ```text
   ~/git/lego/mbm-worktrees/mbm/.git
   ```

6. Canonical MBM agents, read-only:

   ```text
   ~/git/lego/mbm-worktrees/mbm/agents:ro
   ```

The main worktree already contains `.git` and `agents` under its read-write primary workspace, so it does not receive duplicate mounts.

## Accepted mount risks

- Pi can create, modify, and delete files in the active host worktree.
- For secondary worktrees, pi can modify shared Git objects, refs, logs, configuration, hooks, and worktree metadata used by every host worktree.
- Concurrent host and sandbox Git operations can contend on shared lock files.
- Personal static pi configuration is writable through allowlisted symlinks, including `settings.json`.
- The shared MBM CLI cache is writable from every sandbox.

These are intentional tradeoffs. Other main-checkout source files are not mounted into secondary sandboxes.

## Kit specification

Create a `schemaVersion: "1"`, `kind: sandbox` kit with:

```yaml
sandbox:
  image: docker/sandbox-templates:shell-docker
  aiFilename: AGENTS.md
  entrypoint:
    run: [pi-sbx-entrypoint]
```

The exact `name`, `displayName`, and description should clearly mark the kit as personal MBM pi tooling.

### Network and LEGO gateway credential

Declare only the kit-specific LEGO gateway service:

```yaml
credentials:
  sources:
    lego-model-gateway:
      env:
        - LEGO_AI_MODEL_GATEWAY_AUTH_TOKEN

environment:
  proxyManaged:
    - LEGO_AI_MODEL_GATEWAY_AUTH_TOKEN

network:
  allowedDomains:
    - api.genai.thelegogroup.com
  serviceDomains:
    api.genai.thelegogroup.com: lego-model-gateway
  serviceAuth:
    lego-model-gateway:
      headerName: Authorization
      valueFormat: "Bearer %s"
```

The real gateway token remains host-side. Pi receives a proxy-managed placeholder, and the host proxy overwrites the outbound authorization header.

Do not initially support `LEGO_MPS_AUTH_TOKEN`.

### Kit agent context

Keep `agentContext` brief and sandbox-specific. State that:

- execution is inside a Docker Sandbox;
- the active worktree and selected extra workspaces are host mounts;
- Docker uses the sandbox-private daemon;
- `sudo` is passwordless and affects only the sandbox VM;
- shared Git metadata and the MBM CLI cache affect host-visible shared state.

Do not duplicate MBM's repository guidance or `AGENTS.md` content.

## Kit installation phases

Kit install commands run once when a worktree sandbox is created. Use explicit descriptions and fail on errors.

### 1. Install system prerequisites

The current `shell-docker` image already includes Git, `gh`, Docker CLI/Compose/Buildx, OpenSSH, `jq`, `rg`, `make`, Node/npm, Python, Go, and Java.

Install or ensure only what is missing:

- .NET SDK 10;
- Node.js 24 if the image's Node major is not 24;
- `fd-find`;
- `fzf`.

Use Ubuntu-compatible package repositories. Download scripts to a temporary file before executing them so failed downloads cannot be masked by a pipeline.

After installation, verify:

```text
dotnet --version       -> major 10
node --version         -> major 24
npm --version          -> succeeds
docker version         -> client succeeds and private daemon becomes reachable
gh --version           -> succeeds
fd or fdfind           -> succeeds
fzf --version          -> succeeds
```

### 2. Install pnpm and pi

- Enable Corepack.
- Activate repository-declared `pnpm@11.11.0`.
- Install latest pi globally using the image's existing agent-writable npm prefix:

  ```bash
  npm install --global @earendil-works/pi-coding-agent@latest
  ```

The base image already sets:

```text
NPM_CONFIG_PREFIX=/usr/local/share/npm-global
```

and owns that directory as the `agent` user. Avoid adding another npm-prefix mechanism.

Verify `pnpm --version` and `pi --version`.

### 3. Configure writable sandbox-local pi state

Create:

```text
/home/agent/.pi/agent
```

Link only the approved static personal resources from the mounted dotfiles source.

Initial allowlist:

- `settings.json`;
- `keybindings.json`;
- `APPEND_SYSTEM.md`;
- `pi-permissions.jsonc`;
- `prompts/`;
- non-MBM personal skills not already supplied through parent `.pi`;
- selected Linux-compatible personal extensions;
- permission-system extension configuration.

Do not link or copy authentication, sessions, trust state, logs, history, package caches, downloaded package repositories, or tool caches.

Avoid duplicate MBM skill registration. Parent-scoped `.pi` remains the source for MBM project skills and the `say` extension. Canonical source files remain under the main checkout's `agents` directory.

### 4. Configure Git and signing

Configure sandbox-local global Git settings:

```text
user.name=Mathias Soeholm
user.email=mathias.soholm@lego.com
commit.gpgsign=true
gpg.format=ssh
user.signingkey=key::<matching forwarded work public key>
url.https://github.com/.insteadOf=git@github.com:
```

The HTTPS rewrite leaves the shared repository's `origin` unchanged while routing sandbox fetch/push through Docker's GitHub credential facilities.

Verify the configured signing key matches the required fingerprint. Creation must fail when the key is unavailable.

### 5. Restore repository dependencies

Run from `${WORKDIR}` as the agent user:

```bash
dotnet tool restore
dotnet restore mbm.sln
pnpm --dir src/MBM.App install --frozen-lockfile
```

This restores pinned CSharpier and other .NET tools, NuGet dependencies, and frontend dependencies. It intentionally writes ignored build/dependency artifacts into the mounted worktree and uses sandbox-local package caches.

Do not automatically run `dotnet build`, `dotnet test`, frontend checks, or the analyzer.

### 6. Initialize the shared Linux MBM CLI

If the shared cache lacks a usable Linux `mbm` binary, publish from the active worktree using the atomic publication helper described below.

If a usable cache already exists, leave it unchanged when creating another worktree sandbox.

### 7. Record launcher/kit version

Write an implementation version marker into sandbox-local state after all required setup succeeds. The host launcher compares this marker on future launches.

## Internal pi entrypoint

Add a small internal script installed by the kit at:

```text
/home/agent/.local/bin/pi-sbx-entrypoint
```

Supported internal operations:

### Normal launch

```bash
exec pi --approve "$@"
```

This supports both interactive and non-interactive invocations and ensures the existing ignored worktree `.pi/settings.json` can load parent-scoped skills and extensions.

### Internal version query

Return the launcher/kit version marker without opening the pi TUI. This is used by the host launcher for drift detection.

### Internal pi update

Run:

```bash
sudo npm install --global @earendil-works/pi-coding-agent@latest
```

Then print the installed pi version. Keep this command private behind the host `pi-sbx update` interface.

Use reserved `__...` names for internal operations so they cannot conflict with current public subcommands.

## Shared MBM CLI wrapper

Install a sandbox-local wrapper earlier on `PATH` than the shared cache binary:

```text
/home/agent/.local/bin/mbm
```

### Normal commands

For all commands except exact `build-cli`, execute:

```text
~/.local/share/pi-sbx/mbm-cli/mbm
```

Preserve arguments and exit status unchanged. Fail clearly if the cache is absent or incomplete.

### `mbm build-cli`

Publish from the current active worktree into the shared cache.

Requirements:

1. Locate and validate the current MBM repository root.
2. Acquire an inter-process lock in launcher-owned shared state.
3. Create a temporary sibling publish directory on the same filesystem.
4. Run:

   ```bash
   dotnet publish \
     --configuration Release \
     --output <temporary-directory> \
     src/MBM.Cli
   ```

5. Verify the temporary output contains a runnable Linux `mbm` executable and its required companion files.
6. Replace the previous cache only after successful publication and verification.
7. Preserve the previous cache when publication fails.
8. Release the lock and clean temporary state on every exit path.

Use an atomic directory-swap strategy supported by the mounted filesystem. If fully atomic replacement is not practical through the filesystem passthrough, minimize the replacement window and document the limitation rather than claiming stronger guarantees.

The last successful `mbm build-cli` from any sandbox worktree wins for all sandboxes, matching the current host workflow.

## Existing personal extension changes

Update these imports in the dotfiles repository:

```text
pi/.pi/agent/extensions/fuzzy-at-files.ts
pi/.pi/agent/extensions/train-working-indicator.ts
```

Replace legacy package scopes:

```text
@mariozechner/pi-coding-agent -> @earendil-works/pi-coding-agent
@mariozechner/pi-tui          -> @earendil-works/pi-tui
```

Expose these personal extensions in the sandbox:

- `difficulty.ts`;
- `fuzzy-at-files.ts`;
- `train-working-indicator.ts`;
- permission-system extension and configuration.

Expose canonical MBM `lego-model-gateway.ts` through the existing parent `.pi` configuration rather than duplicating it into personal sandbox state.

Exclude:

- `notify.ts`;
- `pi-caffeinate.ts`.

Do not migrate excluded extension imports solely for this launcher.

## Existing sandbox validation

Use `sbx ls --json` as the machine-readable source for existence and identity. Use `sbx inspect` if needed to validate workspace, kit, or injected-secret details unavailable in the list output.

For an existing named sandbox:

- primary workspace must match the current canonical worktree root;
- expected custom agent/kit must be present;
- version marker must match;
- required current-launch host preconditions must still hold, including gateway token and signing key;
- no create-time options or `--kit` argument may be passed during reconnection.

Reconnect with:

```bash
sbx run --name <sandbox-name> [-- <internal args>]
```

Use the exact argument ordering supported by the installed `sbx` release and confirm it during manual smoke testing.

## Error handling and shell quality

- Use Bash with `set -euo pipefail`.
- Quote every path and forwarded argument.
- Resolve canonical paths before comparing them.
- Avoid parsing human-readable `sbx` tables when JSON exists.
- Avoid `eval`.
- Keep commands vertical and readable.
- Use temporary files/directories with cleanup traps.
- Never print secret values.
- Make errors identify the failed prerequisite, affected sandbox, and manual remediation.
- Preserve `sbx`, pi, npm, Git, and build command exit statuses.

## Documentation

Create `pi-sbx/README.md` covering:

- purpose and personal scope;
- exact supported host/repository layout;
- Stow installation;
- `sbx >= 0.35.0` installation prerequisite;
- `sbx login` prerequisite;
- Balanced network policy initialization;
- GitHub secret setup, for example:

  ```bash
  gh auth token | sbx secret set -g github
  ```

- LEGO gateway environment requirement;
- required SSH signing-key fingerprint and GitHub signing-key registration note;
- public launcher commands and examples;
- sandbox naming and lifecycle;
- mount and security implications;
- shared MBM CLI behavior;
- direct `sbx` inspection, stop, and removal commands;
- kit-version recreation procedure;
- `sbx policy log` as the first diagnostic for blocked downloads;
- private-registry credentials remaining an explicit, separate setup concern.

Do not include real token values, authentication files, or setup automation.

## Implementation order

1. Create the Stow package directories and README skeleton.
2. Implement the kit static entrypoint and MBM CLI wrapper.
3. Implement `spec.yaml` installation, credential, network, entrypoint, and context sections.
4. Migrate the two selected personal extension import scopes.
5. Implement host launcher path constants and argument parsing.
6. Implement platform, `sbx`, repository, configuration, credential, and signing-key preflight.
7. Implement sandbox-name derivation and JSON-based existing-sandbox lookup.
8. Implement mount-list construction for main and secondary worktrees.
9. Implement create, reconnect, argument-forwarding, update, and version-drift flows.
10. Complete README setup, security, lifecycle, and troubleshooting instructions.
11. Perform static validation.
12. Configure external prerequisites manually and run real smoke tests.

## Validation

No automated tests will be added initially.

### Static validation

```bash
bash -n ~/dotfiles/pi-sbx/.local/bin/pi-sbx
bash -n ~/dotfiles/pi-sbx/.config/pi-sbx/mbm/files/home/.local/bin/pi-sbx-entrypoint
bash -n ~/dotfiles/pi-sbx/.config/pi-sbx/mbm/files/home/.local/bin/mbm
sbx kit validate ~/dotfiles/pi-sbx/.config/pi-sbx/mbm
stow pi-sbx/ --verbose=2 --simulate
```

Run formatting or linting available for modified TypeScript extensions without introducing a new project dependency.

### Manual smoke test

After installing and configuring `sbx` prerequisites:

1. Create from a secondary worktree subdirectory:

   ```bash
   cd ~/git/lego/mbm-worktrees/ant-man/src
   pi-sbx
   ```

2. In pi or a sandbox shell, verify:
   - current directory is the active worktree;
   - pi runtime state is under sandbox-local `/home/agent/.pi/agent`;
   - expected personal and MBM skills/extensions load;
   - excluded host-specific extensions do not load;
   - `git status` works;
   - `git fetch` uses HTTPS credential handling;
   - a test commit is SSH-signed by the pinned work key;
   - `docker info` reaches the private sandbox daemon;
   - `dotnet build` can run;
   - unit tests can run;
   - `pnpm --dir src/MBM.App build` can run;
   - `mbm --agent code-analyzer --help` works;
   - `mbm --agent code-analyzer run --changed` can run.

3. Exit and reconnect with `pi-sbx`; confirm setup does not rerun.
4. Run `pi-sbx -- -p "..."`; confirm project resources load non-interactively.
5. Run `pi-sbx update`; confirm pi updates and exits without opening the TUI.
6. Run `mbm build-cli` from the sandbox; confirm the shared cache changes only after success.
7. Connect from another worktree sandbox and confirm it uses the same cached Linux CLI.
8. Inspect host changes and verify no authentication, session, history, or cache files were exposed or written into dotfiles.

### Failure-path spot checks

Manually verify clear failures for:

- invocation outside MBM;
- missing or old `sbx`;
- absent gateway token;
- missing GitHub sandbox secret;
- missing required SSH key;
- forbidden runtime file in the personal config source;
- same sandbox name with a different workspace;
- kit-version mismatch;
- failed shared CLI rebuild preserving the previous binary.

## Completion criteria

Implementation is complete when:

- the package can be stowed without conflicting with existing dotfiles;
- static validation succeeds;
- one secondary-worktree sandbox can be created and reconnected;
- pi can build and test MBM, run the MBM CLI, and run the analyzer;
- GitHub API and HTTPS Git workflows work without mounting host credentials;
- commits are signed with the pinned work SSH key;
- all worktree sandboxes share one rebuildable Linux MBM CLI cache;
- pi update works explicitly;
- sandbox-local pi runtime state persists without exposing live host pi state;
- the README records setup, risks, operation, and recovery.
