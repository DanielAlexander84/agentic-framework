# Agentic Development Framework

A solo, low-code-reading way of building Rails/React products with coding agents, from hobby project to small business.

The premise: you read as little code as possible, so trust has to come from somewhere else. It comes from four places:

1. **Specs you write in plain language**, with acceptance criteria you can check without reading code.
2. **Gates the agent cannot talk its way past**: tests, linters, security scans and CI, with failures that explain themselves.
3. **Monitoring that tells you about production** before a user does.
4. **Red zones**: a short list of areas where you do read the diff, every time.

## Structure

```
core/                       stack-agnostic, never project-specific
  workflow.md               the loop every piece of work goes through
  autonomy-levels.md        Hobby / Launch / Business, and what each requires
  quality-gates.md          what must pass, and how failures must be reported
  observability.md          the four signals every app must emit
  brownfield-onboarding.md  how to bring an existing repo under the framework
profiles/
  rails-react.md            concrete tools, commands and red zones for Rails + React
templates/                  copied into each project, then filled in
  CLAUDE.md
  docs/STATUS.md
  docs/DECISIONS.md
  docs/critical-paths.md
  docs/specs/_template.md
  .claude/commands/         start, onboard, feature, wrap
install.sh                  installs or updates the framework in a project
```

The core describes *how you work*. The profile describes *how this stack does it*. The project's own CLAUDE.md describes *this app*. Agents get the most out of concrete instructions, so the core stays short and the profile and CLAUDE.md carry the specifics.

## Adopting it in a project

This repo is the source of truth and is never copied into a project as a folder. Claude Code only finds `CLAUDE.md` and slash commands at the project root, and every path in the framework points to `docs/`, so the files have to land in specific places. `install.sh` puts them there.

### Prepare the project first

1. Clean git state, ideally on a fresh branch (`agentic-setup`).
2. Branch protection on `main` so nothing merges without green CI (CI itself comes later, during onboarding).
3. Secrets out of reach: `config/master.key`, `.env*` and credentials gitignored and never pasted into any AI tool.
4. Any planning notes you want the agent to see (e.g. groundwork from another model) saved under `docs/agentic/`, marked as unverified at the top.

### Install

```bash
./install.sh /path/to/project            # profile defaults to rails-react
./install.sh /path/to/project rails-react
```

Resulting layout in the project:

```
CLAUDE.md                   project-owned: fill in every [bracket]
.claude/commands/           framework-owned: start, onboard, feature, wrap
docs/
  STATUS.md                 project-owned
  DECISIONS.md              project-owned
  critical-paths.md         project-owned
  specs/_template.md        project-owned
  agentic/                  framework-owned: core files and the profile, flat (no subfolders)
```

**Ownership rule:** framework-owned files are overwritten on every install, so re-running the script after changing the framework updates the project. Never edit them in the project; change them here and re-run. Project-owned files are created once and never touched again.

### Then

1. Fill in `CLAUDE.md`: what the app is, autonomy level, commands, red zones, and anything that differs from the profile (test framework, hosting).
2. Brownfield project: open Claude Code and run `/onboard`. Greenfield: write the first spec and run `/feature`.
3. Every working session starts with `/start` and ends with `/wrap`.

## Keeping it alive without over-building it

- The framework grows only from real friction. If something went wrong in a project, `/wrap` asks whether a rule would have prevented it; if yes, add the rule to the framework repo and re-run `install.sh`.
- Mobile, Next.js or other stacks get a profile only when a real project needs one.
- If you notice yourself improving the framework instead of shipping the product, that is the signal to stop and ship.