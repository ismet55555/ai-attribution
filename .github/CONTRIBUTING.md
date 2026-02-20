# Contributing to AI Attribution

Thanks for your interest in improving this spec. Every contribution — from
typo fixes to new level definitions — helps make AI attribution more useful
for everyone.

## How to Contribute

### The Rule: Issue First, PR Second

All contributions start with an issue. Open a bug report or feature request
using the templates provided, describe the problem or idea, and wait for
discussion before submitting a PR. PRs without a linked, approved issue will
be closed.

Why? This is a specification, not application code. Changes to level
definitions, LLM instructions, or log schema affect every project that
adopts this standard. That means even small changes deserve discussion
before implementation. The issue is where that discussion happens.

**The process:**

1. **Open an issue** using one of the provided templates (bug report or
   feature request).
2. **Discuss** the problem and potential solutions in the issue thread.
3. **Get agreement** from a maintainer that the change is wanted and the
   approach makes sense.
4. **Submit a PR** that references the issue (e.g., `Closes #12`).
5. **Review and merge** — maintainer reviews, you iterate if needed.

For trivial fixes (typos, broken links, formatting), you can skip the issue
and submit a PR directly. Use your judgment — if you're changing the meaning
of anything, open an issue first.

### What Makes a Good Contribution

**Bug reports** — Something in the spec is ambiguous, contradictory, or
broken. The best bug reports include a concrete scenario where the spec
fails: "I tried to classify X and couldn't tell if it was GUIDED or
ASSISTED because..."

**Feature requests** — Something is missing or could work better. The best
feature requests explain what you were trying to do and why the current spec
didn't support it.

**PRs** — Should be focused on a single change. If your PR touches the level
definitions, the summary table, the LLM instructions, and the entry
template, that's fine — as long as it's all serving the same change. Don't
bundle unrelated fixes.

### What This Repo Doesn't Need Right Now

- **Tooling, scripts, parsers, or linters.** This repo is deliberately
  minimal — a spec, its docs, and a lightweight install/release pipeline.
  Additional tooling may come later in separate repos.
- **Sample logs in `AI_ATTRIBUTION.md`.** The spec ships with an empty log
  section. Sample content belongs in the README or a future examples
  directory.
- **Section reordering.** The structure of `AI_ATTRIBUTION.md` is deliberate.
  If you think it should change, open an issue to discuss first.

## AI-Assisted Contributions

Contributions that used AI assistance are welcome. This project is literally
about transparent AI attribution — we'd be hypocrites to ban AI-assisted
work. What we care about is that a human understands, owns, and can defend
every change they submit.

**Welcome:**
- You used an LLM to draft new wording, reviewed it, revised it, and
  submitted it as your own work.
- You used an LLM to analyze the spec for inconsistencies and then wrote
  up the findings as an issue.
- You pair-programmed with an AI tool to explore how a proposed change
  would affect downstream adopters.

**Not welcome:**
- Fully autonomous AI-generated PRs submitted by bots or agents without
  meaningful human oversight. These will be closed without review.
- PRs where the submitter cannot explain or defend the changes they're
  proposing.
- AI agents engaging in reputation farming, mass-submitting PRs across
  repositories.

If you used AI assistance, we'd appreciate a note in your PR description
saying which tool you used and how. This is optional but encouraged — it's
good practice and it's what this project advocates.

## Versioning and Releases

The spec uses dual semver: **Spec version** and **Log schema version**.
Your PR should indicate which version(s) need bumping. If you're not sure,
say so in the PR — reviewers will help figure it out. See `CLAUDE.md` for
detailed versioning rules.

Releases are handled by maintainers after merging. The process is:

1. Merge the PR to `main`
2. Create an annotated git tag matching the new spec version (e.g.,
   `git tag -a v1.1.0 -m "AI Attribution Log v1.1.0"`)
3. Push the tag (`git push origin v1.1.0`)

A GitHub Actions workflow automatically creates a GitHub Release with
`AI_ATTRIBUTION.md` attached as a downloadable asset. The workflow extracts
the matching version's changelog section and includes it in the release
notes alongside install instructions. The install script picks up the
latest release automatically — no manual updates needed.

As a contributor, you don't need to worry about releases. Just make sure
your PR includes the appropriate version bump and changelog entry.

## Internal Consistency

This is the most common source of review feedback. If you change anything
that's referenced in multiple places (a level name, a scope tag, a field
name), grep the entire file and update every reference. The places that
typically need updating:

- Level definitions
- Summary table
- Configuration section
- LLM instructions (all numbered responsibilities)
- Log Schema → Fields
- Log Schema → format examples

## Code of Conduct

Be respectful. Disagree on ideas, not on people. If a maintainer closes
your issue or PR, it's about the spec — not about you.
