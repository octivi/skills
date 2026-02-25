# AGENTS.md

This file is the AI-agent entry point for this repository.

## Repository purpose

This repository hosts AI skills in the Agent Skills format.

## Skill layout

- One skill per directory at repository root
- Each skill directory must contain `SKILL.md`
- Optional skill resources can live under `references/`, `scripts/`, and `assets/`

## Available skills

### `common-changelog`

- Path: `common-changelog/SKILL.md`
- Purpose: generate and normalize `CHANGELOG.md` entries in Common Changelog format
- Input focus: release notes, PRs, Conventional Commits, and trailers (`Category`, `Ref`, `Re`,
  `Co-Authored-By`)

### `git-commits`

- Path: `git-commits/SKILL.md`
- Purpose: draft, rewrite, and review Git commit messages in Conventional Commits format
- Input focus: commit intent, type/scope selection, breaking changes, trailers (`See`,
  `Co-authored-by`), and commit hygiene

### `git-trunk-based-workflow`

- Path: `git-trunk-based-workflow/SKILL.md`
- Purpose: guide trunk-based branch strategy, rebase flow, pull request flow, merge, and branch
  cleanup
- Input focus: short-lived feature branches, integration with `main`, safe history rewrite, and PR
  lifecycle

## Install skill

Use one of the skill names listed above:

```bash
npx skills add octivi/skills --skill <skill_name>
```

## Agent working rules for this repo

- Keep skills simple unless automation is explicitly required
- Prefer precise, user-facing output quality rules in `SKILL.md`
- Keep examples synchronized with canonical templates in `references/`
- Treat `SKILL.md` as the canonical source for operational rules and trigger behavior
- Keep extended examples and detailed references in `references/` (do not duplicate in `SKILL.md`)
- Route git workflow/process questions to `git-trunk-based-workflow`
- Route commit message wording/formatting to `git-commits`
- Preserve Conventional Commits semantics when proposing commit messages
