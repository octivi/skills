## Git Trunk Based Workflow Reference

Detailed reference for Trunk Based Development (TBD) and branch/PR flow in this repository.

## Trunk Based Development

[Trunk Based Development](https://trunkbaseddevelopment.com/) is a development approach where
everyone integrates work frequently into a single shared branch (the trunk). In this repository, the
trunk is `main`.

### How it works (basics)

- Work in small, frequent changes.
- Open pull requests targeting `main`.
- Let CI and code review validate changes.
- Merge to `main` and keep `main` releasable.

### Feature branches

Feature branches are short-lived branches used for validation and review:

- Feature branch exists to propose a change to `main`.
- Feature branch is not a long-lived integration branch.
- Releases are created from `main`.
- Delete feature branch after merge.

#### Naming convention

- Bug fix branch: `fix/XXXX-something` (`XXXX` is issue number).
- Feature branch: `feat/XXXX-something` (`XXXX` is issue number).
- Without issue: `fix/something` or `feat/something`.

### Pros

- `main` stays close to release-ready.
- Fewer long-running merge conflicts.
- Simpler release model.

### Cons

- Requires discipline and small PRs.
- Often needs feature flags to keep `main` releasable.
- Rebase-heavy flows can confuse newcomers.

## Git workflow

### Rules of thumb

- Never commit directly to `main`.
- Keep feature branches short-lived and focused.
- Rebase branch on `main` regularly.
- If history was rewritten, push with `--force-with-lease`.

### 1. Create a feature branch

```bash
git switch main
git pull --ff-only
git switch -c ${feature-branch?}
```

### 2. Work and push frequently

```bash
git add -p
git commit
git push
```

First push with upstream:

```bash
git push -u origin HEAD
```

### 3. Integrate updates from `main` often

```bash
git switch main
git pull --ff-only
git switch ${feature-branch?}
git rebase main
```

If branch intentionally contains merge commits that must be preserved:

```bash
git switch ${feature-branch?}
git rebase --rebase-merges main
```

### 4. Clean history before opening PR (optional, recommended)

```bash
git switch ${feature-branch?}
git rebase -i main
```

If preserving merge commits while interactively rebasing:

```bash
git switch ${feature-branch?}
git rebase -i --rebase-merges main
```

After rewrite:

```bash
git switch ${feature-branch?}
git push --force-with-lease
```

### 5. Open a pull request

- Open PR from feature branch to `main`.
- Ensure CI is green.
- Address code review feedback.

### 6. Merge pull request

Prefer repository standard merge path (typically GitHub UI).  
If local merge is required:

```bash
git switch main
git pull --ff-only
git merge --no-ff --edit --message '' ${feature-branch?}
git push
```

### 7. Clean up after merge

```bash
git switch main
git pull --ff-only
git branch -d ${feature-branch?}
git push origin --delete ${feature-branch?}
git remote update --prune
```
