<!--
Common Changelog template for this skill.
Rules snapshot:
- Releases ordered newest-first
- Groups in strict order: Changed, Added, Removed, Fixed
- Do not emit empty groups
- Use user-facing, imperative bullets
- Mark incompatible changes with **Breaking:**
- Include references and authors in parentheses
-->

# Changelog

## [VERSION] - YYYY-MM-DD

_Optional one-line notice, for example migration instructions._

### Changed

- **Breaking:** Remove v1 auth endpoint; migrate clients to `/v2/auth`
  ([#123](https://github.com/OWNER/REPO/pull/123))
  ([`abcdef1`](https://github.com/OWNER/REPO/commit/abcdef1)) (RFC-77) (Bob)
- Bump `math-utils` to 4.5.6 ([#456](https://github.com/OWNER/REPO/issues/456)) (JIRA-123)
  ([`d23ba8f`](https://github.com/OWNER/REPO/commit/d23ba8f)) (Bob, Alice)

### Added

- Add `--json` output mode for CLI ([#124](https://github.com/OWNER/REPO/pull/124))
  ([`bcdefa2`](https://github.com/OWNER/REPO/commit/bcdefa2)) (Bob)

### Removed

- Remove deprecated `--token` fallback ([#125](https://github.com/OWNER/REPO/pull/125))
  ([`cdefab3`](https://github.com/OWNER/REPO/commit/cdefab3)) (Bob)

### Fixed

- Return `400` for invalid `date` query ([#126](https://github.com/OWNER/REPO/pull/126))
  ([`defabc4`](https://github.com/OWNER/REPO/commit/defabc4)) (Bob)

[VERSION]: https://github.com/OWNER/REPO/releases/tag/VERSION
