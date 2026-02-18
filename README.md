# Octivi Skills

Repository of installable AI skills.

## Available skills

### `common-changelog`

Helps an AI agent write and normalize `CHANGELOG.md` entries using the
[Common Changelog](https://common-changelog.org/) format.

- Skill path: `common-changelog/SKILL.md`
- Local template: `common-changelog/references/CHANGELOG.md`

## Installation

Install `common-changelog` from this repository:

```bash
npx skills add octivi/skills --skill common-changelog
```

## Example prompts

- `Generate a changelog from these commits.`
- `Write a CHANGELOG.md entry for version 1.4.0.`
- `Convert this to Common Changelog format and remove technical noise.`
- `Split these commits into changelog sections and show what you skipped.`
- `Generate a Common Changelog entry for version 1.4.0 from these commits.`

## For AI agents

- Agent entrypoint: `AGENTS.md`
- `CLAUDE.md` is a symlink to `AGENTS.md` for tool compatibility
