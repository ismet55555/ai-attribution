<div align="center">

# `AI_ATTRIBUTION.md`

**Know exactly what the AI did and what it didn't.**

[![Spec Version](https://img.shields.io/badge/spec-v1.0.2-blue?style=flat-square)](https://github.com/ismet55555/ai-attribution/releases/latest)
[![Log Schema](https://img.shields.io/badge/schema-v1.0.0-blue?style=flat-square)](https://github.com/ismet55555/ai-attribution/releases/latest)
[![License: CC-BY-4.0](https://img.shields.io/badge/license-CC--BY--4.0-green?style=flat-square)](LICENSE)
[![Markdown](https://img.shields.io/badge/format-markdown-purple?style=flat-square)](#how-it-works)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](https://github.com/ismet55555/ai-attribution/issues)

</div>

Most AI disclosure is binary: "used AI" or "didn't use AI." Reality is a
spectrum. This standard captures that spectrum. Who actually had creative
control, what the AI actually did, and what the human contributed. So you
have a precise record instead of a vague shrug.

[`AI_ATTRIBUTION.md`](AI_ATTRIBUTION.md) is a single markdown file you add
to your project. It tracks what AI tools did and what you did — for every
task, feature, or fix where AI was involved. The file includes instructions
that tell AI tools how to fill it in automatically as you work. You download
it, configure a few settings, and your AI coding tools start logging entries
on their own. No extra tooling needed.

You download it, configure a few settings, and your AI coding tools start
logging entries on their own. **No extra installations or tooling needed,
it's just a markdown file.**

## Table of Contents

- [Why](#why)
- [Quick Start](#quick-start)
- [Setup](#setup)
- [Configuration](#configuration)
- [How It Works](#how-it-works)
- [Version Upgrading / Migration](#version-upgrading--migration)
- [Versioning](#versioning)
- [Contributing](#contributing)
- [License](#license)

## Why

- **Debugging.** When a bug surfaces, you need to know whether that module
  was AI-generated, human-written, or a collaboration. This log tells you
  immediately.
- **Credit.** Creative vision, design decisions, rejecting bad AI
  suggestions, hand-tuning constants — none of that shows up in code. This
  is where that work gets documented.
- **Credibility.** A portfolio with honest, specific attribution ("AI
  scaffolded the config; I designed the architecture and wrote the core
  algorithm") beats unspoken ambiguity.
- **Accountability.** Six months from now, you won't remember which parts
  were AI-assisted. This file remembers for you.

## Quick Start

### **Option A:** One-liner install.

This downloads `AI_ATTRIBUTION.md` into your current directory at the
latest release version.

```bash
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh
```

### **Option B:** Install a specific version

```bash
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh -s -- --version v1.0.0
```

### **Option C:** Manual download

Download the latest `AI_ATTRIBUTION.md` from the
[latest release](https://github.com/ismet55555/ai-attribution/releases/latest)
and place it in your project root.

### **Option D:** Ask your AI agent

Tell your AI coding tool to install it for you:

```
Download and set up the AI Attribution Log standard in this project.
Repo: https://github.com/ismet55555/ai-attribution
```

Or if you're using Claude Code:

```bash
claude -p "Download and set up the AI Attribution Log standard (https://github.com/ismet55555/ai-attribution) in this project using the install script"
```

## Setup

After downloading the file into the root of your project, follow these
three steps:

1. **Edit the Configuration section** in `AI_ATTRIBUTION.md`. Set your
   preferred granularity (`COARSE`, `STANDARD`, or `FINE`), log format
   (`markdown`, `jsonl`, or `toon`), and consolidation threshold.

2. **Tell your AI tool about it.** Add the
   [integration snippet](AI_ATTRIBUTION.md#ai-config-integration) to your
   AI config file. Common ones:

    - **Cross-tool** — `AGENTS.md`
    - **Claude Code** — `CLAUDE.md`
    - **GitHub Copilot** — `.github/copilot-instructions.md`
    - **Cursor** — `.cursorrules`
    - **Windsurf** — `.windsurfrules`

    <details>
    <summary>Expand to view the AI instruction snippet</summary>

    ```md
    ## AI Attribution

    This project maintains an `AI_ATTRIBUTION.md` file in the project
    root. It is a living log of human and AI contributions to this
    project, with instructions for how to maintain it.

    Read this file when:
    - You are about to log a contribution (task completed, feature done, session ending)
    - The user asks about attribution or AI involvement
    - You need to check the current configuration

    Do not read this file on every task. Only access it when updating or
    referencing it.

    When writing a log entry, focus on these sections:
    - Configuration (for current settings)
    - Involvement Levels (for level selection)
    - Contribution Types (for scope tagging)
    - Log Schema → Fields (for required/optional fields)
    - Log (for placement)

    Skip these sections (they are for humans or for rare operations):
    - Why Use This File (human-facing rationale)
    - Other Attribution Mechanisms (human reference)
    - Granularity descriptions (you already have the setting from Configuration)
    - Log Schema → format examples (unless the format setting was just changed)
    - Migration (only relevant during version upgrades)
    ```

    </details>

<br/>

3. **Commit.** That's it! Your AI tools will start maintaining the log
   as you work.

## Configuration

See the [Configuration section](AI_ATTRIBUTION.md#configuration) in
`AI_ATTRIBUTION.md` for full descriptions and details.

| Configuration | Description | Options | Default |
|---------------|-------------|---------|---------|
| **Granularity** | How often entries are created | `COARSE`, `STANDARD`, `FINE` | `STANDARD` |
| **Consolidation** | When old entries get grouped into summaries | Any duration or `never` | `90 days` |
| **Log format** | How entries are written | `markdown`, `jsonl`, `toon` | `markdown` |


## How It Works

Each log entry captures:

- **Date** — when the work happened
- **What was done** — specific files, functions, concepts
- **Involvement level** — who had creative control (see below)
- **Scope** — what kind of work (`code`, `design`, `concept`, `test`, etc.)
- **Human contribution** — what the human did
- **AI contribution** — what the AI did, and which tool
- **Commits** — git references that corroborate the entry

### Involvement Levels

The core of the standard. Six levels based on **who had creative control**
over the work:

| Level | Tag | Who Led | AI's Role |
|-------|-----|---------|-----------|
| :red_circle: | `GENERATED` | Human set the goal | AI produced the work |
| :orange_circle: | `ASSISTED` | Human designed the approach | AI helped build it |
| :yellow_circle: | `GUIDED` | Human adopted AI's approach | AI suggested the direction |
| :large_blue_circle: | `INFORMED` | Human built independently | AI answered questions |
| :green_circle: | `REVIEWED` | Human owned the work | AI checked it |
| :white_circle: | `NONE` | Human owned the work | No AI involvement |

Each level includes a decision test in the spec to make classification
consistent.

### Example Log Entry

```markdown
### 2025-12-01 — Ball physics and tilt input [🟠 ASSISTED — code]

**Human:** Designed the core tilt mechanic, tuned all physics constants.

**AI (Claude):** Wrote TiltPhysics system in systems/physics.rs.

**Commits:** ["3b7c9d1..6a2e8f4"]
```

## Version Upgrading / Migration

When a new `AI_ATTRIBUTION.md` version is released, download the new
template and tell your AI tool:

> "Migrate my AI_ATTRIBUTION.md to the new version using this template."

The LLM will replace the spec sections (everything above the Log) with
the new version, preserve your log entries, and transform them if the
schema changed. Your git history preserves the pre-migration state.

## Versioning

The spec uses dual [semver](https://semver.org/):

- **Spec version** — instructions, configuration, levels, framing
- **Log schema** — entry field structure, field names, format

These are tracked independently. A spec update (rewording instructions,
adding a configuration option) doesn't require log migration. A schema
update (adding or renaming fields) does.

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Contributing

Contributions are always welcome! This is a specification — changes affect
every project that adopts the standard, so all non-trivial changes start
with an issue for discussion before a PR.

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for the full process.

## License

[CC-BY-4.0](LICENSE). You can use, adapt, and redistribute this standard
freely, with attribution.
