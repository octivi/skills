<!--
GitHub recognizes `CONTRIBUTING.md` and can surface it in the UI.
See: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/setting-guidelines-for-repository-contributors
-->

# Contributing

This repository uses `main` as the trunk and follows
[Trunk Based Development](https://trunkbaseddevelopment.com/). We contribute via short-lived feature
branches and pull requests.

## Development environment

If the project includes a `.devcontainer/` directory, you can use a
[Development Container (dev container)](https://containers.dev/) (for example via
[Visual Studio Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)) to
get a ready-to-use development environment without installing toolchains on your host.

## Trunk Based Development and workflow

This repository uses trunk-based workflow with `main` as trunk, integrated through short-lived
feature branches and pull requests.

### Quick rules

- Never commit directly to `main`.
- Keep feature branches short-lived and focused on one change.
- Rebase feature branches on top of `main` regularly.
- Use `--force-with-lease` after history rewrite (rebase/squash).
- Open PRs to `main`, keep CI green, and address review feedback.
- Delete feature branches after merge.

### Canonical source

- [`git-trunk-based-workflow/SKILL.md`](git-trunk-based-workflow/SKILL.md)
- [`git-trunk-based-workflow/references/git-workflow.md`](git-trunk-based-workflow/references/git-workflow.md)

## Git aliases

Consider installing Git aliases from [gitalias/gitalias](https://github.com/gitalias/gitalias). It
adds a curated set of helpful shortcuts that can speed up day-to-day work.

## Git Commits

Use [Conventional Commits](https://conventionalcommits.org) to keep history readable and automation
friendly.

### Quick rules

- Keep commits atomic and focused on one logical change.
- Include related test updates in the same commit when behavior changes.
- Write imperative subjects and keep the header concise (`<= 72` chars, no trailing period).
- Mark breaking changes with `!` in header and a `BREAKING CHANGE:` footer.
- Use trailers such as `See:` and `Co-authored-by:` when context or authorship requires it.

### Canonical source

- [`git-commits/SKILL.md`](git-commits/SKILL.md)
- [`git-commits/references/git-commit.md`](git-commits/references/git-commit.md)
