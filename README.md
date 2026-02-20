<div align="center">

# `AI_ATTRIBUTION.md`

**Know exactly who directed the work and what the AI did.**

[![Spec Version](https://img.shields.io/badge/spec-v1.0.4-blue?style=flat-square)](https://github.com/ismet55555/ai-attribution/releases/latest)
[![Log Schema](https://img.shields.io/badge/schema-v1.0.0-blue?style=flat-square)](https://github.com/ismet55555/ai-attribution/releases/latest)
[![License: CC-BY-4.0](https://img.shields.io/badge/license-CC--BY--4.0-green?style=flat-square)](LICENSE)
[![Markdown](https://img.shields.io/badge/format-markdown-purple?style=flat-square)](#how-it-works)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](https://github.com/ismet55555/ai-attribution/issues)

</div>

Most AI disclosure is binary: “used AI” or “didn’t use AI.” Reality isn’t binary, it’s a spectrum.

[`AI_ATTRIBUTION.md`](AI_ATTRIBUTION.md) captures that spectrum. Built from research across publishing policy, copyright guidance,
automation theory, and software provenance standards, it defines a practical way to record who exercised creative control, what
the AI actually did, and what the human contributed, so you have a precise account instead of a vague disclaimer.

It’s a single markdown file you add to your project. Configure it once, and your AI tools automatically log contributions as you work.

No extra installations. No services. No tooling. Just a file in your repo.

## Table of Contents

- [Why?](#why)
- [Features](#features)
- [Quick Start](#quick-start)
- [Setup](#setup)
- [Configuration](#configuration)
- [How It Works](#how-it-works)
- [Upgrading and Migration](#upgrading-and-migration)
- [Versioning](#versioning)
- [Background \& Positioning](#background--positioning)
- [Contributing](#contributing)
- [License](#license)

## Why?

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

## Features

- **Six-level creative control spectrum** — Precise classification beyond binary AI disclosure.
- **Decision-test based levels** — No percentages, no scoring, no ambiguity.
- **Collaboration semantics** — Captures who directed the work, not just whether AI was used.
- **Scope tagging** — Distinguishes concept, design, code, test, docs, config, etc.
- **Plain markdown file** — No tooling, no service, no vendor lock-in.
- **Configurable granularity** — `COARSE`, `STANDARD`, or `FINE` logging.
- **Multiple log formats** — `markdown`, `jsonl`, or `toon` (machine-readable).
- **Chronological ledger model** — Records evolution over time, not ownership snapshots.
- **Automatic migration** — LLM upgrades spec while preserving log history.
- **Dual versioning (spec + schema)** — Safe evolution without breaking existing logs.
- **Multi-tool support** — One entry can record multiple AI systems.
- **Git-backed integrity** — Commit references corroborate entries.
- **Adoption-first design** — Human always wins; no enforcement or AI policing.
- **Portable & license-friendly** — Single CC-BY file, works in any repo.

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
   - Log Entries → Log Fields (for required/optional fields)
   - Log (for placement)

   Skip these sections (they are for humans or for rare operations):

   - Why Use This File (human-facing rationale)
   - Granularity descriptions (you already have the setting from Configuration)
   - Log Entries → Log Format (unless the format setting was just changed)
   - Migration (only relevant during version upgrades)
   ```

    </details>

<br/>

3. **Commit.** That's it! Your AI tools will start maintaining the log
   as you work.

## Configuration

See the [Configuration section](AI_ATTRIBUTION.md#configuration) in
`AI_ATTRIBUTION.md` for full descriptions and details.

| Configuration     | Description                                 | Options                      | Default    |
| ----------------- | ------------------------------------------- | ---------------------------- | ---------- |
| **Granularity**   | How often entries are created               | `COARSE`, `STANDARD`, `FINE` | `STANDARD` |
| **Consolidation** | When old entries get grouped into summaries | Any duration or `never`      | `90 days`  |
| **Log format**    | How entries are written                     | `markdown`, `jsonl`, `toon`  | `markdown` |

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

| Level               | Tag         | Who Led                     | AI's Role                  |
| ------------------- | ----------- | --------------------------- | -------------------------- |
| :red_circle:        | `GENERATED` | Human set the goal          | AI produced the work       |
| :orange_circle:     | `ASSISTED`  | Human designed the approach | AI helped build it         |
| :yellow_circle:     | `GUIDED`    | Human adopted AI's approach | AI suggested the direction |
| :large_blue_circle: | `INFORMED`  | Human built independently   | AI answered questions      |
| :green_circle:      | `REVIEWED`  | Human owned the work        | AI checked it              |
| :white_circle:      | `NONE`      | Human owned the work        | No AI involvement          |

Each level includes a decision test in the spec to make classification
consistent.

### Example Log Entry

```markdown
### 2025-12-01 — Ball physics and tilt input [🟠 ASSISTED — code]

**Human:** Designed the core tilt mechanic, tuned all physics constants.

**AI (Claude):** Wrote TiltPhysics system in systems/physics.rs.

**Commits:** ["3b7c9d1..6a2e8f4"]
```

## Upgrading and Migration

When a new `AI_ATTRIBUTION.md` version is released, download the new
template and tell your AI tool:

```txt
Migrate my AI_ATTRIBUTION.md to the latest release version from https://github.com/ismet55555/ai-attribution
```

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

## Background & Positioning

AI transparency systems already exist — but they solve different problems.

Most current standards focus on one of the following:

- **Disclosure** — Was AI used?
- **Authorship & ownership** — Who legally owns the work?
- **Provenance integrity** — Has this artifact been tampered with?
- **Supply chain transparency** — What models, datasets, and dependencies were involved?
- **Build reproducibility** — How was this artifact produced?

There are also structured **AI Attribution Statement** frameworks, such as the  
**IBM AI Attribution Toolkit**, which generate human-readable statements describing:

- The proportion of AI contribution  
- The type of AI involvement  
- Whether AI initiated or responded  
- The level of human review  

These tools are designed to produce clear, one-time attribution statements for artifacts like documents, articles, or creative works.

**AI_ATTRIBUTION.md operates in a different layer: collaboration semantics.**

It answers a narrower — but operationally critical — question:

> During this task, who exercised creative control and what role did AI actually play?

### The Transparency Stack

AI transparency mechanisms can be understood as layered systems, each answering a different question:

1. **Risk & Governance Frameworks**  
   *What is the regulatory or societal risk?*  
   Examples: EU AI Act, NIST AI RMF

2. **Cryptographic Provenance**  
   *Can the history of this artifact be verified and tamper-evident?*  
   Examples: C2PA / Content Credentials

3. **Supply Chain & AI-BOM**  
   *What models, datasets, and dependencies were involved?*  
   Examples: CycloneDX ML-BOM, SPDX 3.x, OWASP AIBOM

4. **Build Provenance**  
   *How was this artifact produced and by which systems?*  
   Examples: SLSA, in-toto

5. **Attribution Statements**  
   *How should AI involvement in this artifact be described?*  
   Example: IBM AI Attribution Toolkit

6. **Collaboration Semantics**  
   *Who exercised creative control during the work?*  
   → **AI_ATTRIBUTION.md**

Most deployed systems address layers 1–5.  
This standard focuses on layer 6.

### How This Standard Compares

| System Type | Core Question | Creative Control Captured? | Temporal Tracking? | Machine-Readable? |
|-------------|--------------|----------------------------|--------------------|-------------------|
| Binary Disclosure Policies | "Was AI used?" | Minimal | No | No |
| Copyright Guidance | "Who owns this?" | Artifact-level | No | No |
| IBM AI Attribution Toolkit | "How should AI involvement be described?" | Partially | No | Limited |
| C2PA | "Can this history be verified?" | No | Yes (asset-level) | Yes |
| CycloneDX / SPDX (AI-BOM) | "What components were used?" | No | No | Yes |
| SLSA / in-toto | "How was this built?" | No | Yes (build-level) | Yes |
| **AI_ATTRIBUTION.md** | "Who directed the work?" | **Yes (task-level)** | **Yes (chronological)** | **Yes** |

### Why This Layer Matters

Binary disclosure collapses nuance.  
Attribution statements describe artifacts but do not track workflow evolution.  
Provenance systems avoid authorship judgment.  
AI-BOM standards inventory components.  
Build provenance records pipelines.

None of these systems capture:

- Whether AI suggested the architecture or merely formatted code
- Whether the human designed the algorithm or adopted the AI’s
- Whether AI was advisory, generative, or purely review-based
- How creative control shifted during development over time

That is the gap this standard fills.

It is intentionally:

- **Voluntary** rather than enforced
- **Repo-native** rather than compliance-driven
- **Semantic** rather than cryptographic
- **Chronological** rather than state-based

### Non-Goals

This standard does **not**:

- Provide legal protection
- Verify honesty
- Replace C2PA or SBOM/AIBOM standards
- Replace attribution statements like the IBM AI Attribution Toolkit
- Perform AI detection
- Serve as regulatory compliance
- Evaluate system risk

It defines collaboration semantics only.

### Key References

- IBM Research — *AI Attribution Toolkit*  
  https://research.ibm.com/blog/AI-attribution-toolkit

- AI Attribution Statements (project site)  
  https://aiattribution.github.io/

- U.S. Copyright Office — *Copyright and Artificial Intelligence*  
  https://www.copyright.gov/ai/

- Coalition for Content Provenance and Authenticity (C2PA)  
  https://c2pa.org/specifications/

- CycloneDX ML-BOM  
  https://cyclonedx.org/

- SPDX 3.x Specification  
  https://spdx.github.io/spdx-spec/

- SLSA Provenance Specification  
  https://slsa.dev/spec/

- in-toto Attestation Framework  
  https://in-toto.io/

> **AI_ATTRIBUTION.md complements these systems by standardizing the collaboration layer they leave undefined.**

---

## Contributing

Contributions are always welcome! This is a relatively young project and
could use extra attention and thought around it.

This is a specification — changes affect
every project that adopts the standard, so all non-trivial changes start
with an issue for discussion before a PR.

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for the full process.

## License

[CC-BY-4.0](LICENSE). You can use, adapt, and redistribute this standard
freely, with attribution.
