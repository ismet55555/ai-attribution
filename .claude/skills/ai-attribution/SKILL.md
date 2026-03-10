---
name: ai-attribution
description: >
  Manage AI Attribution Log entries in AI_ATTRIBUTION.md. Use when the user
  asks to log attribution, check/validate the log, view an attribution graph,
  or get an attribution summary.
argument-hint: "[log | check | graph | summary]"
---

# AI Attribution Skill

This skill manages the `AI_ATTRIBUTION.md` file in the project root.
Before executing any command, read `AI_ATTRIBUTION.md` to get the current
configuration, involvement levels, contribution types, log field definitions,
and existing log entries.

## Commands

### `log` (default when no argument given)

Add a new attribution entry to the log.

1. Read `AI_ATTRIBUTION.md` — focus on: Configuration, Involvement Levels,
   Contribution Types, Log Entries → Log Fields, Log.
2. Determine what was worked on. Check recent git activity (`git log` and
   `git diff`) to infer the task, or ask the user if unclear.
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
   - Level is one of the six valid levels (GENERATED, ASSISTED, GUIDED,
     INFORMED, REVIEWED, NONE)
   - Scope tags are from the defined vocabulary (concept, design, code,
     content, test, config, docs, general)
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
     (🔴 GENERATED, 🟠 ASSISTED, 🟡 GUIDED, 🔵 INFORMED, 🟢 REVIEWED,
     ⚪ NONE)
   - Rows (vertical axis): scope tags (concept, design, code, content,
     test, config, docs, general)
   - Cell values: count of entries at that intersection
   - Only show rows that have at least one entry
5. If the log is empty, say "No entries to summarize."

## Important

- Do NOT duplicate the spec rules into this skill. Always read
  `AI_ATTRIBUTION.md` for the authoritative definitions.
- Respect the user's configured log format when creating entries.
- When an entry has two scope tags (e.g., `design, code`), count it
  under both tags in the summary.
