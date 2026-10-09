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
```

The core describes *how you work*. The profile describes *how this stack does it*. The project's own CLAUDE.md describes *this app*. Agents get the most out of concrete instructions, so the core stays short and the profile and CLAUDE.md carry the specifics.

## Adopting it in a project

1. Keep this framework in its own git repo. It is the source of truth.
2. In the project, copy `core/` and the matching profile into `docs/agentic/`, and copy everything in `templates/` to the project root (merging with existing `docs/` if needed).
3. Fill in `CLAUDE.md`: what the app is, autonomy level, commands, red zones.
4. Brownfield project: open Claude Code and run `/onboard`. Greenfield: write the first spec and run `/feature`.
5. Every working session starts with `/start` and ends with `/wrap`.

## Keeping it alive without over-building it

- The framework grows only from real friction. If something went wrong in a project, `/wrap` asks whether a rule would have prevented it; if yes, add the rule to the framework repo and re-copy.
- Mobile, Next.js or other stacks get a profile only when a real project needs one.
- If you notice yourself improving the framework instead of shipping the product, that is the signal to stop and ship.
