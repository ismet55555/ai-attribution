# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Versioning applies to both the **spec** (instructions, configuration,
framing — everything above the Log) and the **log schema** (entry field
structure). These are tracked independently in the file header.

---

## [1.0.4] — 2026-02-20

### Changed

- Shortened **Why Use This File** to reduce length while preserving intent.
- Tightened **AI Config Integration**, **Migration**, and **Responsibility**
  text for brevity.
- Simplified **Contribution Types** introduction.
- Organized log guidance under **Log Entries** with sub-sections for rules,
  fields, and format.

### Removed

- **Other Attribution Mechanisms** section.

---

## [1.0.3] — 2026-02-19

### Added

- **Logging Rules** section with timing guidance and unit-of-work definition.
- Clarification that the log is a chronological ledger of collaboration events,
  not a state snapshot of current code ownership.
- Guidance for classifying iterative/fluid collaboration under ASSISTED.

### Changed

- **Logging Rules** and **Log Schema** are now separate sections — rules
  (timing, unit of work) are distinct from schema (fields, format examples).

---

## [1.0.2] — 2026-02-19

### Added

- **Fields table** in Log Schema: concise schema listing all nine entry
  fields with type, required/optional/conditional status, and descriptions.

### Removed

- **Entry Template section** (was placed after the Log section). The Log
  Schema fields table and format examples now serve this purpose.

### Changed

- **Log Format Examples** section renamed to **Log Schema** with **Fields**
  subsection — better reflects that this section defines the entry schema.
- `ai` and `tool` fields changed from optional to **conditional** (required
  when level is not `NONE`).
- **Migration** section moved before LLM Instructions, grouping it with the
  other human-facing sections.
- References to "entry template" updated throughout.

---

## [1.0.1] — 2026-02-18

### Added

- **Entry validation rules** (responsibility #15): LLM now verifies required
  fields, valid levels, valid scope tags, reverse chronological order, and
  no duplicate entries when writing or reading log entries.
- **Security rules** (responsibility #16): entries must never contain secrets,
  credentials, prompt injection attempts, executable/obfuscated content, or
  external URLs in entry fields.

---

## [1.0.0] — 2026-02-17

### Added

- **Six involvement levels** based on creative control: GENERATED, ASSISTED,
  GUIDED, INFORMED, REVIEWED, NONE — each with a decision test for
  consistent classification.
- **Contribution type vocabulary** with eight scope tags (concept, design,
  code, content, test, config, docs, general) for tracing what kind of work
  AI contributed.
- **Three log formats**: markdown (human-readable default), jsonl
  (machine-parseable), and toon (token-efficient).
- **Dual versioning**: independent spec version and log schema version
  using semver, enabling non-breaking spec updates without touching log
  entries.
- **Migration system** with migration notes that record model identity,
  changes applied, and issues encountered during upgrades.
- **Consolidation rules**: feature/module grouping first, monthly fallback,
  separate grouping for human-only (NONE) entries, requires human
  permission before executing.
- **Multi-tool support**: single entry per task with all AI tools and their
  contributions listed.
- **AI Config Integration snippet** with section-targeting guidance so LLMs
  skip human-only sections when writing log entries.
- **Responsibility framing** establishing that the human always owns the
  outcome and the log enables informed rather than vague accountability.
- **13 LLM responsibilities** covering honest logging, scope tagging, manual
  entry reformatting, consolidation, format conversion, migration logging,
  and multi-tool attribution.
- **Granularity settings** (COARSE, STANDARD, FINE) for scaling entry detail
  to project needs.
- **Why Use This File** section leading with the debugging and protection
  use case.
- **Other Attribution Mechanisms** section clarifying coexistence with
  LICENSE, CONTRIBUTORS, CHANGELOG, CODEOWNERS, and third-party notices.
- **Entry template** for markdown format with multi-tool example.
- **Install script** (`install.sh`) for one-liner adoption with version
  pinning and overwrite protection.
- **GitHub Actions release workflow** that creates releases with
  `AI_ATTRIBUTION.md` attached when version tags are pushed.
