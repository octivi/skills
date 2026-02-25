---
name: git-trunk-based-workflow
description: Plan and execute Git Trunk Based Development workflows on a repository with main as trunk. Use when the user asks for branch strategy, rebasing on main, PR flow, merge strategy, safe history rewrite, or branch cleanup. For commit message formatting and Conventional Commits wording, delegate to git-commits.
---

# Git Trunk Based Workflow

Guide contributors through a safe trunk-based Git workflow.

## Goal

Keep `main` releasable while integrating small changes frequently and predictably.

## Canonical rules table

Use this table as the single source of truth for workflow decisions.

| ID     | Scope            | Requirement                                                                                 |
| ------ | ---------------- | ------------------------------------------------------------------------------------------- |
| `WF-1` | Trunk policy     | Never commit directly to `main`; use short-lived feature branches and pull requests.        |
| `WF-2` | Branch lifecycle | Feature branches SHOULD stay focused and short-lived; delete branches after merge.          |
| `WF-3` | Integration      | Rebase feature branch on top of `main` frequently to minimize integration drift.            |
| `WF-4` | History rewrite  | If branch history was rewritten (rebase/squash), push with `--force-with-lease` only.       |
| `WF-5` | PR quality       | Open PR to `main`, keep CI green, and address review feedback before merge.                 |
| `WF-6` | Merge mode       | Prefer standard repository merge path (typically GitHub UI) unless local merge is required. |
| `WF-7` | Cleanup          | After merge, clean up local/remote branch references.                                       |
| `WF-8` | Safety           | Commands provided to users MUST be copy-paste ready and scoped to their current step.       |

## Authoring workflow

1. Confirm branch context (`main` vs feature branch) and current goal.
2. Create or switch to a short-lived feature branch from up-to-date `main`.
3. Commit and push incremental progress to the feature branch.
4. Rebase feature branch onto `main` frequently (use `--rebase-merges` only when needed).
5. Optionally clean branch history before opening PR.
6. Open and land PR to `main` with green CI and addressed feedback.
7. Clean up merged branches locally and remotely.

For full command sequences and edge-case notes, use `references/git-workflow.md`.

## Out of scope

- Commit message wording/formatting and Conventional Commits phrasing belong to `git-commits`.

## Quality checklist

- Guidance conforms to all applicable `WF-*` rules.
- Commands are copy-paste ready and ordered by execution flow.
- No recommendation conflicts with repository branch policy (`main` as trunk).
- If user asks about commit message style, explicitly route to `git-commits`.

## Prompt templates

- `Propose a trunk-based git workflow for implementing this task from branch creation to merge.`
- `Review my current git commands and rewrite them to follow a safe rebase + PR flow on main.`
- `Give me a step-by-step checklist to clean up history and merge this feature branch into main.`

## References

- `references/git-workflow.md` (canonical detailed workflow and commands)
- https://trunkbaseddevelopment.com/
