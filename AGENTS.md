# AGENTS.md

This file is the AI-agent entrypoint for this repository.

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

## Install skill

```bash
npx skills add octivi/skills --skill common-changelog
```

## Agent working rules for this repo

- Keep skills simple unless automation is explicitly required
- Prefer precise, user-facing output quality rules in `SKILL.md`
- Keep examples synchronized with canonical templates in `references/`
- Preserve Conventional Commits semantics when proposing commit messages
