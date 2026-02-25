[![License: MIT](https://img.shields.io/github/license/octivi/skills)](https://choosealicense.com/licenses/mit/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org/)

# common-changelog

Skill for writing and normalizing user-facing `CHANGELOG.md` entries in
[Common Changelog](https://common-changelog.org/) format.

## Install

```bash
npx skills add octivi/skills --skill common-changelog
```

## Example prompts

- `Generate a Common Changelog entry for version 1.4.0 from these commits and PRs. Keep only user-facing changes, include references, and mark breaking changes.`
- `Normalize this existing changelog fragment to Common Changelog format without losing important user-impact details.`
- `Classify these Conventional Commits into Changed/Added/Removed/Fixed and explain any skipped items.`

## Files

- Skill definition: [`SKILL.md`](SKILL.md)
- Local template: [`references/CHANGELOG.md`](references/CHANGELOG.md)
- License: [`LICENSE`](LICENSE)

## License

All content is provided under the terms of [The MIT License](./LICENSE).
