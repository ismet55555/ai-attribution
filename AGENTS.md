# AGENTS.md

AI agent instructions for the `ai-attribution` repository.

## What This Repo Is

This repository defines and maintains the **AI Attribution Log** — an open
standard for transparently tracking human-AI collaboration in projects. The
primary deliverable is `AI_ATTRIBUTION.md`, a versioned spec that people
download and add to their own projects.

This is a **specification repository**, not a software project. There is no
application code or build system. The work here is writing, editing, and
refining a markdown document and its supporting files. The repo does include
consistency tests that validate the spec's internal correctness (see
Testing below).

## Repository Structure

```
AI_ATTRIBUTION.md   — The spec (distributable artifact — do NOT add log entries)
README.md           — Project overview and adoption guide
CHANGELOG.md        — Version history (Keep a Changelog format)
LICENSE             — CC-BY-4.0
AGENTS.md           — This file (cross-tool AI agent instructions)
CLAUDE.md           — Claude Code config (imports AGENTS.md)
install.sh          — One-liner install script for adopters
.github/
  CONTRIBUTING.md         — Contribution guidelines and policies
  ISSUE_TEMPLATE/
    bug_report.yml        — Bug report form template
    feature_request.yml   — Feature request form template
    config.yml            — Disables blank issues, links to Discussions
  pull_request_template.md — PR template
  workflows/
    release.yml           — GitHub Actions workflow (creates releases on version tags)
```

## Critical Rule: Do Not Write to AI_ATTRIBUTION.md's Log Section

`AI_ATTRIBUTION.md` is the **distributable template**. It ships with an
empty log section (`*No entries yet.*`) and must stay that way. Never add
attribution entries, sample data, or any other content to the Log section
of this file. When adopters download it, they get a clean slate.

When editing `AI_ATTRIBUTION.md`, you are editing the **spec itself** — the
instructions, levels, configuration, and templates that other people's LLMs
will follow. Treat every word as part of a published standard.

## Working on This Repo

### The nature of the work

All contributions to this repo are **writing and specification design**.
When making changes:

- Edits to `AI_ATTRIBUTION.md` are edits to the spec. Every word matters.
  Changes to level definitions, LLM instructions, or log schema affect how
  every adopter's attribution works. Be precise and consider downstream
  effects.
- The spec uses plain markdown with no preprocessing. What you see in the
  file is what adopters copy into their projects.
- Internal consistency is critical. If you change a level name, it must be
  updated in: the level definitions, the summary table, the configuration
  section, the LLM instructions (all references), the field reference, and
  the log schema. Grep before committing.

### Versioning rules

The spec uses dual semver versioning: `Spec version` and `Log schema`.

- **Spec version** covers everything above the Log section: instructions,
  configuration options, level definitions, framing, contribution types.
- **Log schema** covers the entry field structure: what fields exist, their
  names, and their format.

When to bump which:
- Rewording instructions, adding a responsibility, changing the "Why" section
  → bump spec **patch** (e.g., `1.0.0` → `1.0.1`)
- Adding a new configuration option, adding a new level, adding a new scope
  tag → bump spec **minor** (e.g., `1.0.0` → `1.1.0`)
- Renaming a level, removing a feature, restructuring sections in a breaking
  way → bump spec **major** (e.g., `1.0.0` → `2.0.0`)
- Adding an optional field to log entries → bump log schema **minor**
- Renaming or removing a log field, changing field semantics → bump log
  schema **major**
- Log schema patch bumps are for format clarifications that don't change
  field structure

When bumping versions, update all three locations:
1. The header line (`Spec version: X.X.X · Log schema: X.X.X`)
2. The Current Version heading in the Migration section
3. The CHANGELOG.md

### Releasing

Releases are automated via GitHub Actions. The workflow is triggered by
pushing a version tag. To cut a release:

1. Ensure all changes are committed and pushed to `main`.
2. Create an annotated tag: `git tag -a vX.X.X -m "AI Attribution Log vX.X.X"`
3. Push the tag: `git push origin vX.X.X`

The workflow (`.github/workflows/release.yml`) will:
- Create a GitHub Release named "AI Attribution Log vX.X.X"
- Attach `AI_ATTRIBUTION.md` as a downloadable asset
- Include install instructions in the release body
- Automatically mark tags containing `-rc`, `-beta`, or `-alpha` as
  pre-releases

The tag version should match the spec version in `AI_ATTRIBUTION.md`.
Always tag from `main` after all version bumps and changelog updates are
committed.

The install script (`install.sh`) resolves the latest release tag
automatically, so it does not need updating when a new version is released.

### Changelog conventions

Follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.
Use the standard section headers: Added, Changed, Deprecated, Removed,
Fixed, Security. Each entry should be a concise description of what changed
and why it matters to adopters.

### Testing

The spec is a document, not software, but it has testable invariants.
Changes to `AI_ATTRIBUTION.md` must preserve internal consistency. The
tests do not enforce specific values (e.g., exactly six levels or eight
scope tags) — they verify that whatever is defined is referenced
consistently throughout the document.

**Level consistency** — Every level defined in the Level Definitions
section must appear identically in the Summary Table, all LLM Instructions
references, the Log Schema fields, and the format examples. No orphaned
references to levels that don't exist in the definitions.

**Scope tag consistency** — Every tag defined in the Contribution Types
table must match the tags referenced in LLM Instructions. No references
to undefined tags, no defined tags missing from the instructions.

**Log format example validity** — The jsonl example must be valid JSON
with field names matching the documented field reference. The toon example
must match its declared schema header. The markdown example must follow
the markdown format example structure.

**Version consistency** — The spec and log schema versions must match
across all three locations: the file header, the Current Version heading
in Migration, and the latest `CHANGELOG.md` entry.

**Field reference coverage** — The fields in the Field Reference table
must correspond to the keys in the jsonl example, the columns in the toon
schema header, and the fields shown in the markdown format example.

**Section structure** — Expected sections exist and follow the documented
order: human-facing context, configuration, migration, LLM instructions,
reference material, log.

**Log section is empty** — The Log section must contain only
`*No entries yet.*` — this is the distributable template.

**No security hazards** — The spec must not contain secrets, credentials,
API keys, tokens, or sensitive identifiers anywhere — including examples,
code blocks, comments, and HTML. No executable content (script tags, HTML
event handlers), no encoded/obfuscated blobs (base64, hex), no external
URLs in log schema examples, and no prompt injection
patterns (system/role prompts, instruction overrides, hidden directives
in HTML comments).

When a test script exists, run it before committing changes to the spec.
Until then, verify these checks manually or by grepping.

### Commit messages

Use conventional commit style for clarity:

- `spec: reword GUIDED decision test for clarity` — changes to the spec
  content
- `schema: add optional 'context' field to log entries` — changes to the
  log schema
- `docs: update README adoption instructions` — non-spec documentation
- `meta: add AGENTS.md` — repo infrastructure
- `fix: correct typo in ASSISTED level definition` — corrections

### Pull request expectations

PRs that modify the spec should:
- Explain the problem the change solves (what's ambiguous, broken, or
  missing in the current spec)
- Show how the change affects existing adopters (is it breaking? do their
  logs need migration?)
- Update the CHANGELOG with the proposed change
- Maintain internal consistency (all references to changed items updated)
- If adding or modifying levels: include the decision test and at least one
  concrete example scenario

### What not to do

- Do not add log entries to `AI_ATTRIBUTION.md`. It is a distributable
  template and must ship with an empty log.
- Do not add tooling, scripts, parsers, or automation beyond what already
  exists (`install.sh`, `.github/workflows/release.yml`) without discussion.
- Do not change the log schema format examples without also verifying they parse
  correctly in their respective formats (valid JSON for jsonl, valid CSV
  semantics for toon).
- Do not add sample logs to `AI_ATTRIBUTION.md` itself. Sample logs belong
  in the README or in a separate examples directory if one is created.
- Do not reorganize the section order of `AI_ATTRIBUTION.md` without strong
  justification. The order is deliberate: human-facing context first,
  configuration second, migration third, LLM instructions fourth, reference
  material fifth, log last.
