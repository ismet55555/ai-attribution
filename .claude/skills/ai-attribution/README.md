# AI Attribution Skill

A Claude Code skill for managing your project's
[AI Attribution Log](https://github.com/ismet55555/ai-attribution).

## Requirements

- `AI_ATTRIBUTION.md` in your project root
  ([install guide](https://github.com/ismet55555/ai-attribution#quick-start))

## Install

```bash
# With AI_ATTRIBUTION.md
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh -s -- --with-skill

# Skill only (already have AI_ATTRIBUTION.md)
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh -s -- --skill-only
```

Or copy manually into your project:

```
.claude/skills/ai-attribution/SKILL.md
```

## Commands

| Command | Description |
|---------|-------------|
| `/ai-attribution log` | Add a new attribution entry |
| `/ai-attribution check` | Validate all log entries |
| `/ai-attribution graph` | Visual contribution graph |
| `/ai-attribution summary` | Level and scope statistics |
| `/ai-attribution insights` | AI collaboration pattern analysis |

`/ai-attribution` with no argument defaults to `log`.

---

### `/ai-attribution log`

Infers what you worked on from recent git activity, classifies the
involvement level, and constructs an entry in your configured format.
Shows the entry for confirmation before writing.

### `/ai-attribution check`

Validates every log entry for: required fields, valid levels, valid scope
tags, chronological order, no duplicates, and no security violations.

### `/ai-attribution graph`

Renders a dot graph of your attribution history using level-colored emoji.

**Example output:**

```
🟠🟠🔴🟡🟠🔵🟠🔴🟠🟢🟠🟠🔵🟡🟠🔴🟠🟠🟢🔴🟠🟡🔵🟠🟠🔴🟠🟢🟠🟡

Legend: 🔴 GENERATED  🟠 ASSISTED  🟡 GUIDED  🔵 INFORMED  🟢 REVIEWED  ⚪ NONE
```

Each dot is one log entry, oldest first. Wraps at 80 dots per row.

### `/ai-attribution summary`

Shows per-level counts and a cross-tabulation of levels by scope.

**Example output:**

```
🔴 GENERATED: 4  |  🟠 ASSISTED: 14  |  🟡 GUIDED: 3  |  🔵 INFORMED: 3  |  🟢 REVIEWED: 3  |  ⚪ NONE: 0

          | 🔴 GEN | 🟠 AST | 🟡 GUD | 🔵 INF | 🟢 REV | ⚪ NON |
----------|--------|--------|--------|--------|--------|--------|
code      |    3   |   10   |    1   |    —   |    1   |    —   |
design    |    —   |    2   |    2   |    —   |    —   |    —   |
docs      |    1   |    1   |    —   |    1   |    2   |    —   |
config    |    —   |    1   |    —   |    —   |    —   |    —   |
test      |    —   |    —   |    —   |    2   |    —   |    —   |
```

Rows with zero entries across all levels are omitted.

### `/ai-attribution insights`

Analyzes your full attribution history and produces a report covering:

- **AI reliance profile** — distribution across involvement levels
- **Scope heatmap** — which areas lean on AI vs. stay human-owned
- **Trends over time** — how your AI usage is shifting
- **Collaboration style** — delegator, pair programmer, learner, or
  self-reliant author
- **Strengths** — what you're confident doing independently
- **Growth opportunities** — constructive suggestions based on patterns
- **Recurring patterns** — repeated tasks that may be learning
  opportunities

Ends with 2-3 actionable suggestions tailored to your specific patterns.
Requires at least 5 entries for meaningful analysis.
