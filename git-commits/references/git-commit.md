## Git Commit Reference (Lean)

Concise operational reference for writing commit messages in
[Conventional Commits](https://conventionalcommits.org) style.

## Message shape

```text
<type>[optional scope]: <subject>

[optional body]

[optional footer(s)]
```

- Keep exactly one blank line between header/body and body/footer.
- Use imperative, present-tense subject (`add`, `fix`, `remove`, `refactor`).
- Do not end subject with a period.
- Aim for <= 50 chars; keep <= 72 chars.

## Types and release intent

- `feat`: user-facing feature; usually minor version intent
- `fix`: bug fix; usually patch version intent
- `docs`: documentation-only change; patch intent
- `refactor`: code restructuring without user-facing feature/bugfix; no bump intent
- `chore`: internal or maintenance work; no bump intent
- `revert`: rollback of a previous commit

Use scope when it improves clarity, for example: `feat(api): ...`.

## Breaking changes

- Mark header with `!`: `feat(api)!: ...`
- Add footer with migration impact:

```text
BREAKING CHANGE: <what changed and how to migrate>
```

Use both (`!` + footer) for explicitness.

## Body rules

Use body only when the header is not enough.

- Explain why the change exists.
- Explain behavioral delta (`Previously ...`, `Now ...`).
- Keep prose wrapped around 72 chars when practical.
- Prefer fully qualified URLs for external references.

## Footer and trailer rules

Use trailer format compatible with `git interpret-trailers`:

- `Token: value`
- `Token #value` (alternative form)

Common trailers:

- `See: <url>` for issue trackers, docs, specs, design links (one per line)
- `Co-authored-by: Name <email>` for additional authors (one per line)
- `BREAKING CHANGE: <description>` for incompatible changes

## Revert rules

For `revert` commits:

- Repeat or clearly reference the reverted commit header in subject.
- Include in body:

```text
This reverts commit <hash>.
```

## Commit hygiene quick rules

- Keep commits atomic and logically scoped.
- Do not mix whitespace-only changes with behavior changes.
- If code change requires test updates, include tests in the same commit.
- If change set is too broad, split into multiple commits before committing.

## Compact examples

```text
feat(lang): add Polish language
```

```text
docs: correct spelling of CHANGELOG
```

```text
fix: prevent request race condition

Track the latest request id and ignore stale responses.

See: https://github.com/org/repo/issues/123
```

```text
feat(api)!: remove v1 auth endpoint

BREAKING CHANGE: clients must migrate from /v1/auth to /v2/auth.
```

```text
revert: feat(cache): add experimental cache warmup

This reverts commit a1b2c3d4.
```

```text
chore(ci): pin Node.js version in pipeline
```

## Minimal external references

- https://conventionalcommits.org
- https://git-scm.com/docs/git-interpret-trailers
- https://www.conventionalcommits.org/en/v1.0.0/#examples
