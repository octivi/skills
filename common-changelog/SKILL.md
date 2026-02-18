---
name: common-changelog
description: Draft and normalize user-facing CHANGELOG.md entries in Common Changelog format from release notes, pull requests, and Conventional Commits (including git trailers like Category, Ref, and Co-Authored-By).
---

# Common Changelog

Write human-facing changelog entries in Common Changelog format.

## When to use

Use this skill when asked to generate, update, or normalize `CHANGELOG.md` from commits, PRs, or release notes.

## Goal

Help readers answer: what changed and how it affects them.

## Output format

- File name: `CHANGELOG.md`
- First heading: `# Changelog`
- Releases sorted latest-first (semantic version)
- Release heading:
  - preferred: `## [1.2.3] - YYYY-MM-DD`
  - allowed: `## 1.2.3 - YYYY-MM-DD`
- Allowed groups, always in this order: `Changed`, `Added`, `Removed`, `Fixed`
- Do not emit empty groups
- If a release has no user-facing changes:
  - default: skip that release
  - if explicitly requested to track internal-only releases: add one-line maintenance notice

## Change writing rules

- Use imperative style (`Add`, `Fix`, `Remove`, `Bump`)
- Keep bullets concise (one line when possible)
- Describe user impact, not internal implementation trivia
- Prefix breaking changes with `**Breaking:**`
- Include zero or more references, commit link, and authors in parentheses

Bullet shape:

```markdown
- <summary> (<reference 1>) (<reference 2>) ... ([`<sha>`](https://github.com/OWNER/REPO/commit/<sha>)) (<authors>)
```

Example:

```markdown
- Add `--json` output mode ([#123](https://github.com/OWNER/REPO/pull/123))
  (JIRA-456) ([`a1b2c3d`](https://github.com/OWNER/REPO/commit/a1b2c3d)) (Bob)
```

## Input model

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Recognize trailers and reference keywords:

- `Category:`
- `Ref:`
- `Re:`
- `Co-Authored-By:`
- `BREAKING CHANGE:`

Also recognize GitHub issue-linking keywords:

- `close`, `closes`, `closed`
- `fix`, `fixes`, `fixed`
- `resolve`, `resolves`, `resolved`

For `Ref`, `Re`, and the keywords above:

- matching is case-insensitive
- `:` is optional (for example `Ref ABC-123` and `Ref: ABC-123` are both valid)
- treat GitHub keywords as reference signals only when an issue target is present (for example `Fixes #123`)

## Classification algorithm

Apply in this order:

1. `Category:` trailer override
2. Conventional Commit type mapping
3. Semantic fallback

### 1) Category override (highest priority)

If `Category:` maps to a group, use it:

- `change`, `changed` -> `Changed`
- `add`, `added` -> `Added`
- `remove`, `removed` -> `Removed`
- `fix`, `fixed` -> `Fixed`

Rules:

- case-insensitive matching
- if multiple `Category:` trailers exist, use the last recognized one
- ignore unknown values and continue

### 2) Conventional Commits mapping

- `feat` -> `Added`
- `fix` -> `Fixed`
- `perf` -> `Changed` only if user-facing; otherwise skip
- `refactor` -> `Changed` only if user-facing; otherwise skip
- `revert` -> `Changed` or `Fixed` based on actual user effect
- `docs`, `style`, `test`, `chore`, `ci`, `build` -> skip unless user-facing

### 3) Semantic fallback

If type is missing or unclear:

- Existing behavior changed -> `Changed`
- New capability -> `Added`
- Capability removed -> `Removed`
- Bug corrected -> `Fixed`

### Conflict examples

- `fix(api): ...` + `Category: add` -> `Added`
- `feat!:` + `Category: remove` -> `Removed` + `**Breaking:**`
- `docs:` + `Category: fixed` -> `Fixed`

## Breaking change handling

- If header has `!` or body/footer contains `BREAKING CHANGE:`, prefix with `**Breaking:**`
- Keep the entry in `Changed`/`Added`/`Removed`/`Fixed` by impact (no extra section)

## User-facing quick test

Usually include:

- API contract or output changed
- CLI flags/defaults changed
- Config shape/defaults changed
- Runtime/performance behavior users notice
- Dependency bump that fixes production bug/security issue

Usually skip:

- Internal refactor without behavior change
- CI/test/style-only updates
- Dev tooling and internal docs only
- Dependency bump for dev/test-only tooling

## References and authors

- Commit hash must be a link:
  - ``[`d23ba8f`](https://github.com/OWNER/REPO/commit/d23ba8f)``
- Multiple references per bullet are allowed
- Build references from:
  - explicit PR/issue links
  - `Ref` and `Re` trailers
  - GitHub keywords (`close*`, `fix*`, `resolve*`) with issue targets
- Normalize before deduplication:
  - treat `#123` and `https://github.com/OWNER/REPO/issues/123` as the same issue reference
  - normalize case for keyword-style references (for example `jira-123` -> `JIRA-123`)
- Reference order is deterministic:
  1. first: one high-signal repository reference (prefer PR, otherwise issue)
  2. then: remaining unique references in first-seen order
- Use commit author as primary author
- Append `Co-Authored-By:` names (extract name before `<email>`)
- Deduplicate authors in stable order
- If commit author is a bot and merger is known, prefer the human merger name

## Authoring workflow

1. Collect input: commits, PRs, issues, release notes.
2. Parse commit headers, body, and trailers.
3. Classify each change using rules above.
4. Remove non-user-facing noise and no-op pairs (change + immediate revert).
5. Rewrite into concise user-facing bullets.
6. Group by `Changed`, `Added`, `Removed`, `Fixed` in that order.
7. Run checklist.

## Anti-patterns

- Raw technical commit text with no user context
- Non-standard sections (`Security`, `Docs`, `Chore`, etc.)
- Internal-only noise in public changelog
- Missing `**Breaking:**` marker for incompatible changes

## Quality checklist

- Uses only `Changed`, `Added`, `Removed`, `Fixed` in that order
- Release heading includes ISO date `YYYY-MM-DD`
- Entries are user-impact oriented and concise
- Breaking changes use `**Breaking:**`
- References/commit links/authors are complete and consistent (including multi-reference entries)

## Prompt templates

Formal:

- `Generate a Common Changelog entry for version <VERSION> from these commits and PRs. Keep only user-facing changes, include references, and mark breaking changes.`
- `Normalize this existing changelog fragment to Common Changelog format without losing important user-impact details.`
- `Classify these Conventional Commits into Changed/Added/Removed/Fixed and explain any skipped items.`

Colloquial:

- `Generate a changelog from these commits.`
- `Write a CHANGELOG.md entry for version 1.4.0.`
- `Convert this to Common Changelog format and remove technical noise.`
- `Split these commits into changelog sections and show what you skipped.`
- `Write release notes in plain language, without developer-only noise.`

## References

- `references/CHANGELOG.md` (local formatting template)
- https://common-changelog.org/
- https://github.com/vweevers/common-changelog
- https://www.conventionalcommits.org/
- https://git-scm.com/docs/git-interpret-trailers
- https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword
