[![License: MIT](https://img.shields.io/github/license/octivi/skills)](https://choosealicense.com/licenses/mit/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org/)

# git commits

Skill for drafting and reviewing Git commit messages using
[Conventional Commits](https://conventionalcommits.org), including commit hygiene, breaking-change
notation, and trailer conventions.

## Install

```bash
npx skills add octivi/skills --skill git-commits
```

## Example prompts

- `Write a Conventional Commit message for these staged changes.`
- `Rewrite this commit message to follow Conventional Commits and explain what was wrong.`
- `Split this work into 3 atomic commits and provide a message for each.`

## Files

- Skill definition: [`SKILL.md`](SKILL.md)
- Detailed rules: [`references/git-commit.md`](references/git-commit.md)
- License: [`LICENSE`](LICENSE)

## License

All content is provided under the terms of [The MIT License](./LICENSE).
