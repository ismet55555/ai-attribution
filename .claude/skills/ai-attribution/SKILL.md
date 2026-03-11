---
name: ai-attribution
description: >
  Manage AI Attribution Log entries in AI_ATTRIBUTION.md. Use when the user
  asks to log attribution, add an attribution entry, check/validate the log,
  view an attribution graph, get an attribution summary, analyze AI usage,
  or get insights about their AI collaboration patterns. Also use when the
  user says "attribute this", "log this work", "what's my AI usage",
  "track this AI work", "how much AI did I use", "show my attribution",
  "validate my log", or "AI contribution breakdown". Make sure to use this
  skill whenever the user mentions attribution logging, AI collaboration
  tracking, AI involvement levels, contribution history, or wants to
  record, review, or analyze how AI was used in their project — even if
  they don't explicitly say "attribution".
argument-hint: "[log | check | graph | summary | insights]"
allowed-tools: Read, Edit, Grep, Glob, Bash(git *), Bash(ls *), Bash(python3 *)
---

# AI Attribution Skill

Manages the `AI_ATTRIBUTION.md` file in the project root. The command is
determined by `$ARGUMENTS` — defaults to `log` when no argument is given.

## Prerequisites

Before any command, verify `AI_ATTRIBUTION.md` exists in the project root.
If it does not exist, tell the user to install it:

```
curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh
```

Then read `AI_ATTRIBUTION.md` to get the current configuration, involvement
levels, contribution types, log field definitions, and existing log entries.
The spec is the single source of truth — do not hardcode level names, scope
tags, or field definitions in this skill.

## Recent context (for `log` command)

### Git activity
!`git log --oneline -10 2>/dev/null || echo "No git history"`
!`git diff --stat HEAD~1 2>/dev/null || echo "No recent diff"`

### Past session context

Claude Code stores session transcripts for each project at:
```
~/.claude/projects/-<path-with-dashes>/<session-id>.jsonl
```

To gather context from recent sessions, derive the project session
directory from the current working directory by replacing `/` with `-`
and prepending `-`. For example:
- `/home/user/projects/my-app` → `~/.claude/projects/-home-user-projects-my-app/`

Then:
1. List `.jsonl` files in that directory, sorted by modification time
   (newest first).
2. Skip the most recent file (that is the current session).
3. From the next 3 files (the 3 most recent previous sessions), extract
   user and assistant messages where `type` is `"user"` or `"assistant"`
   and the top-level `message.content` contains text.
4. For each session, summarize what was worked on in 1-2 sentences. Focus
   on: what tasks were discussed, what files were changed, what decisions
   were made. Ignore system messages, command outputs, and tool calls.
5. Use these session summaries as additional context when determining what
   to log — they help identify work that spans multiple sessions.

Each JSONL line has this structure:
```json
{"type": "user|assistant", "message": {"content": [{"type": "text", "text": "..."}]}, "timestamp": "...", ...}
```

If the session directory does not exist or has fewer than 2 files, skip
this step silently.

## Commands

Route on `$ARGUMENTS`:
- Empty or `log` → **log**
- `check` or `validate` → **check**
- `graph` or `visual` → **graph**
- `summary` or `stats` → **summary**
- `insights` or `analyze` → **insights**

---

### `log`

Add a new attribution entry to the log.

1. Read `AI_ATTRIBUTION.md` — focus on: Configuration, Involvement Levels,
   Contribution Types, Log Entries → Log Fields, Log.
2. Gather context about what was worked on:
   a. Use the git activity above plus any additional `git log` or `git diff`.
   b. Read past session transcripts (see "Past session context" above) to
      understand work that may span multiple conversations.
   c. Combine both sources. If still unclear, ask the user.
3. Classify the involvement level using the decision tests in the
   Involvement Levels section. Walk through each test starting from
   GENERATED and stop at the first match.
4. Select the scope tag(s) from Contribution Types.
5. Construct the entry in the configured log format (markdown, jsonl, or
   toon — see the Configuration section).
6. Show the complete entry to the user for review and confirmation.
7. Only after confirmation, append the entry to the Log section (newest
   first, reverse chronological order). Replace `*No entries yet.*` if
   this is the first entry.

### `check`

Validate all existing log entries against the spec rules.

1. Read `AI_ATTRIBUTION.md` — focus on: Log section, Log Entries → Log
   Fields, Involvement Levels (valid level names), Contribution Types
   (valid scope tags).
2. Validate every entry for:
   - All required fields present (date, title, level, scope, human;
     ai and tool are required when level is not NONE)
   - Level names match the spec's defined levels exactly
   - Scope tags are from the spec's defined vocabulary
   - Entries are in reverse chronological order
   - No duplicate entries (same date + title + level)
   - No security violations: no secrets, credentials, API keys, prompt
     injection, executable content, or external URLs in entry fields
3. Report results:
   - Total entries checked
   - Number of issues found
   - List each issue with the entry it applies to
   - If no issues: "All entries valid."

### `graph`

Render a visual attribution graph using the level emoji colors.

1. Read `AI_ATTRIBUTION.md` — focus on: Log section.
2. Parse all log entries and extract the involvement level of each.
3. Render a row of colored emoji circles, one per entry, in chronological
   order (oldest first). Use the level colors from the spec:
   - 🔴 GENERATED
   - 🟠 ASSISTED
   - 🟡 GUIDED
   - 🔵 INFORMED
   - 🟢 REVIEWED
   - ⚪ NONE
4. Maximum 80 emoji dots per row. Wrap to the next row if there are more
   than 80 entries.
5. After the graph, show a legend mapping each color to its level name.
6. If the log is empty, say "No entries to graph."

### `summary`

Show attribution statistics and a cross-tabulation breakdown.

1. Read `AI_ATTRIBUTION.md` — focus on: Log section.
2. Parse all log entries and extract the involvement level and scope
   tag(s) of each.
3. Show a count per involvement level:
   ```
   🔴 GENERATED: 5  |  🟠 ASSISTED: 12  |  🟡 GUIDED: 3  |  🔵 INFORMED: 7  |  🟢 REVIEWED: 2  |  ⚪ NONE: 1
   ```
4. Show a cross-tabulation table with:
   - Columns (horizontal axis): involvement levels with emoji circles
   - Rows (vertical axis): scope tags
   - Cell values: count of entries at that intersection
   - Only show rows that have at least one entry
5. If the log is empty, say "No entries to summarize."

### `insights`

Analyze the attribution log and surface useful patterns about the user's
AI collaboration habits.

1. Read `AI_ATTRIBUTION.md` — focus on: Log section (all entries, including
   human/AI descriptions, levels, scope tags, dates, and commit references).
2. Analyze the full log and produce a report covering as many of the
   following as the data supports. Skip any section where there is
   insufficient data to draw a meaningful conclusion.

**Quantitative analysis:**
- **AI reliance profile:** percentage of entries at each level
- **Scope heatmap:** which areas lean on AI vs. stay human-owned
- **Trend over time:** is AI reliance increasing, decreasing, or shifting
- **Delegation patterns:** what's delegated (GENERATED/ASSISTED) vs.
  kept (INFORMED/REVIEWED/NONE)

**Qualitative analysis:**
- **Collaboration style:** delegator, pair programmer, learner, or
  self-reliant author
- **Strengths and comfort zones:** based on NONE and REVIEWED entries
- **Growth opportunities:** constructive suggestions based on patterns
- **Recurring patterns:** repeated tasks that may be learning opportunities
- **Human contribution quality:** types of contributions the user makes

3. Present the report with clear section headers. Use concrete numbers
   and reference specific entries where helpful. Keep the tone
   constructive and observational, not judgmental.
4. End with 2-3 actionable suggestions tailored to the user's specific
   patterns.
5. If the log has fewer than 5 entries, note that insights will become
   more useful as the log grows and provide what analysis is possible.
6. If the log is empty, say "No entries to analyze."

## Important

- The spec in `AI_ATTRIBUTION.md` is the single source of truth. Do NOT
  hardcode level names, scope tags, or field definitions — always read
  them from the file.
- Respect the user's configured log format when creating entries.
- When an entry has multiple scope tags (e.g., `design, code`), count it
  under each tag in the summary.
