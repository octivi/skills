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

We use the [Conventional Commits](https://conventionalcommits.org) convention to add human- and
machine-readable meaning to commit messages.

### Goals

- Emphasize clear communication for you and your teammates
- A diff shows what changed, but the commit message explains why
- Automatically generate changelogs
- Automatically determine semantic version bumps (based on commit types)
- Trigger build and publish processes
- Allow skipping commits in `git bisect` (e.g. formatting-only changes, missing semicolons,
  comments)
  - `git bisect skip $(git rev-list --grep irrelevant <good place> HEAD)`
- Provide better information when browsing a structured commit history

### Commit hygiene

- Make commits as small, logical, atomic units
- Write commit messages that describe what changes and why
  - Empty messages or messages like "fixes bug" may be rejected during review
- If code changes cause tests to fail, update the tests in the same commit as the code change
- Keep significant whitespace-only changes in a separate commit (do not mix with non-whitespace
  changes)
- For significant changes, split work into multiple commits to make review easier
  - If your pull request contains multiple commits, tests should pass at each commit
- Squash intermediate / WIP commits before opening a pull request (see "Clean up history before
  opening a PR" in [Git workflow](#git-workflow))

### Format of the Commit Message

A commit message consists of a header, an optional body, and optional footer(s), separated by blank
lines:

```
<type>[optional scope]: <subject>

[optional body]

[optional footer(s)]
```

#### Header

Start with a short summary line (the commit header):

- The commit header is a single line that contains a succinct description of the change, including a
  type, an optional scope, and a subject
- Try to make headers distinctive enough to tell commits apart. Avoid overly generic headers
- Aim for 50 characters or fewer. Keep it under 72 characters to avoid truncation in many UIs
  - When displayed on the web, the header is often styled as a heading, and in emails, it's
    typically used as the subject
- `<type>` describes the kind of change that this commit is providing. Allowed values:
  - `feat`: add a feature; the result will be a new semver minor version of the package when it is
    next published
  - `fix`: fix a bug; the result will be a new semver patch version of the package when it is next
    published
  - `docs`: documentation-only changes; the result will be a new semver patch version of the package
    when it is next published
  - `refactor`: rewrite/restructure that neither fixes a bug nor adds a feature; the result will be
    **no change** to the version of the package when it is next published (as the commit does not
    affect the published version)
  - `chore`: other changes that do not affect the published module (e.g. changes to tests, modifying
    `.gitignore`, change CI configuration); the result will be **no change** to the version of the
    package when it is next published (as the commit does not affect the published version)
  - `revert`: revert a previous commit
    - should repeat the header of the reverted commit
    - in the body, include: `This reverts commit <hash>.`, where the hash is the SHA of the commit
      being reverted
- `<scope>` is optional and depends on the specific project
- `<subject>` is a short description of the change
- Append a ! after the type/scope if introducing a breaking API change (correlating with MAJOR in
  Semantic Versioning) and add `BREAKING CHANGE: <description>` footer
- If you're having a hard time summarizing, you might be committing too many changes at once. Try to
  split up into several commits using `git add -p`
- A properly formed subject should always be able to complete the following sentence: **If applied,
  this commit will _<your subject here>_**
  - If applied, this commit will refactor subsystem X for readability
  - If applied, this commit will update getting started documentation
  - If applied, this commit will remove deprecated methods
  - If applied, this commit will release version 1.0.0
  - If applied, this commit will merge pull request #123 from user/branch
- Use imperative, present tense: "change", not "changed" or "changes". Examples:
  - add, expand, backport, update, enable: create a capability e.g. feature, test, dependency
  - drop, remove, disable: delete a capability e.g. feature, test, dependency
  - fix, change, work around: fix an issue e.g. bug, typo, accident, misstatement
  - refactor, restructure, optimize, rearrange, normalize: refactor code, optimize
  - upgrade, bump, update: increase the version of something e.g. a dependency
- Do not end the subject with a period

#### Body

Often a header by itself is sufficient because the change is so simple that no further context is
necessary. When it's not, continue with a longer description, also known as the commit body:

- Add a blank line after the header line, then write as much as you want
- Just as in `<subject>`, use imperative, present tense: "Change", not "Changed" or "Changes" (soft
  requirement; you can relax this restriction in the body)
- Use up to 72 characters per line for typical prose (for easier wrapping)
- Use as many characters as needed for atypical text, such as URLs, terminal output formatted
  messages, etc.
- Include motivation for the change and contrasts with previous behavior
  - Describe the purpose, such as a goal, or use case, or user story, etc
  - Describe any relevant algorithms, protocols, implementation spec, etc
- Include any kind of notes, links, examples, etc. as you want
- Put the most important stuff at the top of the message (the principle of pyramid writing, similar
  to newspaper articles). The information at the top is the part that you expect most readers will
  want to know. After that, you put information of interest to fewer readers, and then fewer still
- In a commit message, you're describing a change between two states of the code. Make sure you
  clearly mark descriptions of the code to indicate the context of the statement you're making
  - _Before this change_, the code did this
  - This patch _updates the code so that_ it does that
  - _Previously_, ...
  - _Now_, ...
- Prefer fully qualified URLs to reference tickets/issues instead of a bare ticket number
  - This is because projects may use multiple tracking systems, and multiple ways of launching a URL
  - We want URL tracking to be easy to use by a wide range of systems, scripts, and teams
- Mention all breaking changes. Start the relevant paragraph with `BREAKING CHANGE: ` and include
  justification and migration notes.

#### Footer

The footer is suitable for tracking and also for
[`git interpret-trailers`](https://git-scm.com/docs/git-interpret-trailers). Each footer must
consist of a word token, followed by either a `:<space>` or `<space>#` separator, followed by a
string value.

##### Task Tracking Links

Use `See:` trailers to link to issue trackers (e.g. GitHub, Jira, ClickUp, Trello), document files
and folders (e.g. Google Drive, Microsoft OneDrive, Dropbox), UI/UX designs (e.g. Figma), reference
pages (e.g. Wikipedia, Internet RFCs, IEEE standards), and web posts (e.g. Stack Overflow, Hacker
News).

List each URL, one per line, because this is easy to parse.

Example:

```text
See: https://github.com/user/repo/issues/789
See: https://jira.com/tasks/123
See: https://en.wikipedia.org/wiki/Quicksort
```

If you want to provide link text, use Markdown links, such as:

```text
See: [Request for help with sign in](https://github.com/user/repo/issues/789)
See: [Add feature foo](https://jira.com/tasks/123)
See: [Wikipedia: Quicksort](https://en.wikipedia.org/wiki/Quicksort)
```

##### Contact Email Addresses (Optional)

Sometimes more than one person is working on a commit. Use `Co-authored-by:` trailers to link to
other authors. These are parsed automatically by some version control services (e.g. GitHub, GitLab)
and will link to the authors' accounts and show up on the authors' commit history.

List each person, one per line, because this is easy to parse. Use the person's name and the email
address:

```text
Co-authored-by: Alice Adams <alice@example.com>
Co-authored-by: Bob Brown <bob@example.com>
Co-authored-by: Carol Curtis <carol@example.com>
```

#### Commit Message Examples

Examples are copied from
[Conventional Commits Examples](https://www.conventionalcommits.org/en/v1.0.0/#examples).

Commit message with description and breaking change footer

```text
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

Commit message with ! to draw attention to breaking change

```text
feat!: send an email to the customer when a product is shipped
```

Commit message with scope and ! to draw attention to breaking change

```text
feat(api)!: send an email to the customer when a product is shipped
```

Commit message with both ! and BREAKING CHANGE footer

```text
chore!: drop support for Node 6

BREAKING CHANGE: use JavaScript features not available in Node 6.
```

Commit message with no body

```text
docs: correct spelling of CHANGELOG
```

Commit message with scope

```text
feat(lang): add Polish language
```

Commit message with multi-paragraph body and multiple footers

```text
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.

Reviewed-by: Z
Refs: #123
```

### More information about commits

- [Conventional Commits](https://conventionalcommits.org)
- [AngularJS Git Commit Message Conventions](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y)
- [Git commit message by Joel Parker Henderson](https://github.com/joelparkerhenderson/git-commit-message)
- [Git commit template by Joel Parker Henderson](https://github.com/joelparkerhenderson/git-commit-template)
- [5 Useful Tips For A Better Commit Message by Caleb Thompson at Thoughtbot](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
- [A Note About Git Commit Messages by tpope at tbaggery](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
- [How to Write a Git Commit Message by Chris Beams](https://chris.beams.io/posts/git-commit/)
- [Writing good commit messages by the Erlang OTP team](https://github.com/erlang/otp/wiki/writing-good-commit-messages)
- [On commit messages by Who-T](http://who-t.blogspot.com/2009/12/on-commit-messages.html)
- [Linus Torvalds advice on word wrap](https://github.com/torvalds/linux/pull/17#issuecomment-5661185)
- [Writing commit messages by Simon Tatham](https://www.chiark.greenend.org.uk/~sgtatham/quasiblog/commit-messages/)
- [The power of conventional commits](https://julien.ponge.org/blog/the-power-of-conventional-commits/)
