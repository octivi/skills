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

## Install skill

Use one of the skill names listed above:

```bash
npx skills add octivi/skills --skill <skill_name>
```

## Agent working rules for this repo

- Keep skills simple unless automation is explicitly required
- Prefer precise, user-facing output quality rules in `SKILL.md`
- Keep examples synchronized with canonical templates in `references/`
- Preserve Conventional Commits semantics when proposing commit messages
