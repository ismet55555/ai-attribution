# AI Attribution Log

An open standard for transparently tracking human-AI collaboration in any project.

Most AI disclosure is binary: "used AI" or "didn't use AI." Reality is a spectrum. This standard captures that spectrum — who had creative control, what the AI actually did, and what the human contributed — so you have a precise record instead of a vague shrug.

## Why

- **Debugging.** When a bug surfaces, you need to know whether that module was AI-generated, human-written, or a collaboration. This log tells you immediately.
- **Credit.** Creative vision, design decisions, rejecting bad AI suggestions, hand-tuning constants — none of that shows up in code. This is where that work gets documented.
- **Credibility.** A portfolio with honest, specific attribution ("AI scaffolded the config; I designed the architecture and wrote the core algorithm") beats unspoken ambiguity.
- **Accountability.** Six months from now, you won't remember which parts were AI-assisted. This file remembers for you.

## Quick Start

**Option A: One-liner install**

```bash
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh
```

This downloads `AI_ATTRIBUTION.md` into your current directory at the latest release version.

**Option B: Install a specific version**

```bash
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh -s -- --version v1.0.0
```

**Option C: Manual download**

Download `AI_ATTRIBUTION.md` from the [latest release](https://github.com/ismet55555/ai-attribution/releases/latest) and place it in your project root.

## Setup

After downloading, three steps:

1. **Edit the Configuration section** in `AI_ATTRIBUTION.md`. Set your preferred granularity (`COARSE`, `STANDARD`, or `FINE`), log format (`markdown`, `jsonl`, or `toon`), and consolidation threshold.

2. **Tell your AI tool about it.** If your project has an AI config file (`CLAUDE.md`, `copilot-instructions.md`, `.cursorrules`, etc.), add the integration snippet from the "AI Config Integration" section of the spec. This ensures your AI tool reads the file only when needed and skips sections it doesn't need.

3. **Commit.** That's it. Your AI tools will start maintaining the log as you work.

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

The core of the standard. Six levels based on **who had creative control** over the work:

| Level | Tag | Who Led | AI's Role |
|-------|-----|---------|-----------|
| :red_circle: | `GENERATED` | Human set the goal | AI produced the work |
| :orange_circle: | `ASSISTED` | Human designed the approach | AI helped build it |
| :yellow_circle: | `GUIDED` | Human adopted AI's approach | AI suggested the direction |
| :large_blue_circle: | `INFORMED` | Human built independently | AI answered questions |
| :green_circle: | `REVIEWED` | Human owned the work | AI checked it |
| :white_circle: | `NONE` | Human owned the work | No AI involvement |

Each level includes a decision test in the spec to make classification consistent.

### Example Entry

```markdown
### 2025-12-01 — Ball physics and tilt input [🟠 ASSISTED — code]

**Human:** Designed the core tilt mechanic, tuned all physics constants.

**AI (Claude):** Wrote TiltPhysics system in systems/physics.rs.

**Commits:** ["3b7c9d1..6a2e8f4"]
```

## Upgrading

When a new version is released, download the new template and tell your AI tool:

> "Migrate my AI_ATTRIBUTION.md to the new version using this template."

The LLM will replace the spec sections (everything above the Log) with the new version, preserve your log entries, and transform them if the schema changed. Your git history preserves the pre-migration state.

## Versioning

The spec uses dual [semver](https://semver.org/):

- **Spec version** — instructions, configuration, levels, framing
- **Log schema** — entry field structure, field names, format

These are tracked independently. A spec update (rewording instructions, adding a configuration option) doesn't require log migration. A schema update (adding or renaming fields) does.

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Contributing

Contributions are welcome. This is a specification — changes affect every project that adopts the standard, so all non-trivial changes start with an issue for discussion before a PR.

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for the full process.

## License

[CC-BY-4.0](LICENSE). You can use, adapt, and redistribute this standard freely, with attribution.
