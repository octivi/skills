---
name: git-commits
description: Draft, rewrite, and review Git commit messages using Conventional Commits and commit hygiene rules. Use when the user asks to write commit messages, improve commit quality, choose commit type/scope, describe breaking changes, add trailers (for example See or Co-authored-by), split work into atomic commits, or prepare commits before opening a PR.
---

# Git Commits

Write clear, structured commit messages that explain what changed and why.

## Goal

Help readers and tools quickly understand commit intent, impact, and context.

## Canonical rules table

Use this table as the single source of truth.

| ID       | Scope              | Requirement                                                                                                                                          |
| -------- | ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FMT-1`  | Message shape      | Commit message MUST follow: `<type>[optional scope]: <subject>`, optional body, optional footer(s), with blank lines between sections.               |
| `FMT-2`  | Allowed types      | Type MUST be one of: `feat`, `fix`, `docs`, `refactor`, `chore`, `revert`.                                                                           |
| `FMT-3`  | Header length      | Header SHOULD be <= 50 chars and MUST be <= 72 chars.                                                                                                |
| `FMT-4`  | Subject style      | Subject MUST be imperative/present tense and MUST NOT end with a period.                                                                             |
| `FMT-5`  | Breaking changes   | If the commit introduces a breaking API change, header MUST use `!` and message MUST include `BREAKING CHANGE: <description>` with migration impact. |
| `FMT-6`  | Scope              | Scope is optional and SHOULD be used when it improves clarity.                                                                                       |
| `BODY-1` | Body usage         | Body is optional; when present it MUST explain motivation, context, and behavior change (not only implementation detail).                            |
| `BODY-2` | Body formatting    | Body SHOULD wrap normal prose at ~72 chars per line; long URLs and terminal snippets MAY exceed this.                                                |
| `FTR-1`  | Trailer format     | Footers/trailers SHOULD follow `Token: value` (or `Token #value`) so they remain compatible with `git interpret-trailers`.                           |
| `FTR-2`  | Tracking links     | Use `See:` trailers for tracker/docs/reference URLs; emit one URL per line.                                                                          |
| `FTR-3`  | Co-authors         | Use `Co-authored-by: Name <email>` trailers when multiple people co-authored the change.                                                             |
| `REV-1`  | Reverts            | `revert` commits SHOULD repeat reverted header and body SHOULD include `This reverts commit <hash>.`                                                 |
| `HYG-1`  | Atomicity          | Commits SHOULD be small, logical, and atomic; avoid mixing unrelated changes.                                                                        |
| `HYG-2`  | Whitespace changes | Significant whitespace-only changes SHOULD be in a separate commit.                                                                                  |
| `HYG-3`  | Tests              | If code changes require test updates, include test updates in the same commit.                                                                       |

## Semver intent by type

- `feat` -> minor version intent
- `fix` -> patch version intent
- `docs` -> patch version intent
- `refactor` -> no release bump intent
- `chore` -> no release bump intent
- `revert` -> depends on reverted change impact

## Input model

```text
<type>[optional scope]: <subject>

[optional body]

[optional footer(s)]
```

## Authoring workflow

1. Identify the smallest logical change set; recommend split commits if input is too broad.
2. Choose `type` (and optional `scope`) by user impact.
3. Draft concise imperative subject.
4. Add body only when extra context is needed; explain why and behavior delta.
5. Add footers/trailers (`See:`, `Co-authored-by:`, `BREAKING CHANGE:`) as needed.
6. Run `Quality checklist`.

## Quality checklist

- Validate all applicable `FMT-*`, `BODY-*`, `FTR-*`, `REV-*`, and `HYG-*` rules.
- Ensure final message is copy-paste ready for `git commit`.
- For detailed conventions and more examples, verify against `references/git-commit.md`.

## Prompt templates

- `Write a Conventional Commit message for these staged changes.`
- `Rewrite this commit message to follow Conventional Commits and explain why your version is better.`
- `Split this change into 2-3 atomic commits and propose a commit message for each.`

## References

- `references/git-commit.md` (local detailed guide and examples)
- https://conventionalcommits.org
- https://git-scm.com/docs/git-interpret-trailers
