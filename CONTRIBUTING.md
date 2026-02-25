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

## Trunk Based Development

[Trunk Based Development (TBD)](https://trunkbaseddevelopment.com/) is a development approach where
everyone integrates work frequently into a single shared branch (the _trunk_). In this repository,
the trunk is `main`.

### How it works (basics)

- Work in small, frequent changes
- Open a pull request targeting `main`
- CI validates the change (automated tests, linters, etc.)
- Code review validates the change (human feedback)
- Merge into `main` and let CI validate again
- `main` should always be in a releasable state (often supported by feature flags)

### Feature branches

We still use feature branches, but only as short-lived branches for validation and review:

- A feature branch exists to propose a change to `main` (usually as a PR)
- Feature branches are **not** used as long-lived integration branches
- Releases are created from the trunk (`main`) only
- Delete the feature branch after it is merged

#### Naming convention

When creating a feature branch:

- If it's a bug fix branch, name it `fix/XXXX-something` where `XXXX` is the number of the issue
- If it's a feature branch, create an enhancement issue to announce your intentions, and name it
  `feat/XXXX-something` where `XXXX` is the issue number
- If there is no corresponding issue, skip `XXXX-` and use `fix/something` or `feat/something`

### Pros

- `main` stays close to being release-ready
- Less "branch hell" and fewer painful long-running merges
- Simple release rules (release from trunk)

### Cons

- Requires discipline: smaller PRs and frequent integration
- Often requires feature flags / toggles to keep `main` releasable
- Rewriting history on feature branches (rebases) can be confusing for newcomers

## Git aliases

Consider installing Git aliases from [gitalias/gitalias](https://github.com/gitalias/gitalias). It
adds a curated set of helpful shortcuts that can speed up day-to-day work.

## Git workflow

### Rules of thumb

- Never commit directly to `main`
- Keep feature branches short-lived and focused
- A feature branch is your personal workspace, so don't be afraid to push often
- Rebase your branch on top of `main` to keep integration smooth
- If you rewrite history on your feature branch (rebase / squash), use `--force-with-lease` when
  pushing (this is one of the few cases where force-pushing is acceptable)

### 1. Create a feature branch

```bash
git switch main
git pull --ff-only
git switch -c ${feature-branch?}
```

### 2. Work (repeat)

Commit and push regularly to your feature branch.

```bash
git add -p
git commit
git push
```

For the first push, set upstream:

```bash
git push -u origin HEAD
```

### 3. Integrate updates from `main` (repeat often)

With `rerere` enabled, recurring conflicts are usually easier to resolve.

```bash
git switch main
git pull --ff-only
git switch ${feature-branch?}
git rebase main
```

If your feature branch intentionally contains merge commits that carry important integration context
(for example, you merged another working branch into yours, such as `git merge teammate/feature-x`,
or you're using "stacked branches" to combine work from multiple people or sub-features) and you
want to preserve that structure, use `--rebase-merges`:

```bash
git switch ${feature-branch?}
git rebase --rebase-merges main
```

### 4. Clean up history before opening a PR (optional, recommended)

Use interactive rebase to squash/fixup/reword commits as needed:

```bash
git switch ${feature-branch?}
git rebase -i main
```

If your feature branch intentionally contains merge commits that carry important integration context
(for example, you merged another working branch into yours, such as `git merge teammate/feature-x`,
or you're using "stacked branches" to combine work from multiple people or sub-features) and you
want to preserve that structure, use `--rebase-merges`:

```bash
git switch ${feature-branch?}
git rebase -i --rebase-merges main
```

After rewriting history, push safely:

```bash
git switch ${feature-branch?}
git push --force-with-lease
```

### 5. Open a Pull Request

- Open a PR from your feature branch to `main`
- Ensure CI is green
- Address review feedback

### 6. Merge a Pull Request

Merge the PR using the repository's standard method. Prefer the GitHub UI unless the project
requires local merges.

If you need to merge locally (e.g. PR merging is disabled), use a merge commit and include full
context in the merge message:

```bash
git switch main
git pull --ff-only
git merge --no-ff --edit --message '' ${feature-branch?}
git push
```

### 7. Clean up

After merging, delete the feature branch (GitHub UI or CLI), remove it locally, and prune deleted
remote branches:

```bash
git switch main
git pull --ff-only
git branch -d ${feature-branch?}
git push origin --delete ${feature-branch?}
git remote update --prune
```

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
