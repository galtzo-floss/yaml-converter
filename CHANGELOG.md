# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

- Documentation linting now has its generated `yard-lint` dependency and severity config available in the local bundle.

- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.

- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- The `yaml-convert` executable startup header is now shown only when
  `--verbose` is passed; `-v` and `--version` still print just the executable
  version and exit.

- The `yaml-convert` executable supports `-v` / `--version` for version-only
  output.

- kettle-jem-template-20260716-001 - Shim gemspec manifests now include
  `LICENSE.md` instead of nonexistent `LICENSE.txt`.
- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.
- kettle-jem-template-20260720-001 - Generated READMEs can now render
  template-managed corporate sponsor logos from project or family config.
- kettle-jem-template-20260720-002 - Generated development Gemfiles now use the
  released `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260720-003 - Generated StructuredMerge Git diff driver
  config now uses the installed `smorg-rb` Ruby driver name.
- kettle-jem-template-20260720-004 - Generated multi-engine workflow files now
  omit JRuby and TruffleRuby jobs when project config declares MRI-only engines.
- kettle-jem-template-20260720-005 - Generated README Support & Community rows
  now include a RubyForum help badge.
- kettle-jem-template-20260725-001 - Generated JRuby and TruffleRuby workflow
  files now run when pull request head branches start with `feature/release`,
  so release CI monitoring does not report intentionally skipped engine
  workflows as failures.

- kettle-jem-template-20260725-002 - Generated gemspec templates now include
  `anonymous_loader` as a development dependency, and version specs use it to
  execute generated `version.rb` files for coverage without redefining package
  constants. Managed version specs are removed when `version_gem` is disabled
  or incompatible with the project's runtime Ruby floor.

- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.

### Deprecated

### Removed

### Fixed

- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.

- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.

- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.

- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.

### Security

## [0.2.3] - 2026-07-02

- TAG: [v0.2.3][0.2.3t]
- COVERAGE: 92.69% -- 444/479 lines in 10 files
- BRANCH COVERAGE: 67.63% -- 117/173 branches in 10 files
- 63.77% documented

### Fixed

- Package configured license files in gem release file lists.

## [0.2.2] - 2026-06-22

- TAG: [v0.2.2][0.2.2t]
- COVERAGE: 92.69% -- 444/479 lines in 10 files
- BRANCH COVERAGE: 67.63% -- 117/173 branches in 10 files
- 63.77% documented

### Added

- Added support for JRuby 10.1 and TruffleRuby 34.0.

### Changed

- Retemplated project metadata and CI/development automation with `kettle-jem` v7.0.0.

### Fixed

- Updated generated footer links to point at the migrated `kettle-dev`
  GitHub organization.

## [0.2.1] - 2026-06-15

- TAG: [v0.2.1][0.2.1t]
- COVERAGE: 92.69% -- 444/479 lines in 10 files
- BRANCH COVERAGE: 68.42% -- 117/171 branches in 10 files
- 63.77% documented

### Fixed

- Fixed generated OpenCollective funding links so README, FUNDING, and
  generated docs point at `galtzo-floss` instead of an empty slug.

## [0.2.0] - 2026-06-03

- TAG: [v0.2.0][0.2.0t]
- COVERAGE: 92.51% -- 432/467 lines in 10 files
- BRANCH COVERAGE: 68.42% -- 117/171 branches in 10 files
- 65.82% documented

### Added

- Added the current `kettle-jem` template harness, including StructuredMerge
  config, local setup scripts, generated CI workflows, and Ruby 4.0.5 `mise`
  tooling.

### Changed

- (BREAKING) Switched native PDF rendering from Prawn to HexaPDF.
- Rebuilt the README with the current `kettle-jem` layout while preserving the
  project synopsis and alternatives.
- Updated generated development, test, documentation, and style dependencies
  through the current template stack.
- Updated README alternatives to mention the Python `yaml2rst` and `yaml2doc`
  tools.

### Removed

- Removed obsolete generated binstubs and legacy Ruby 2.x/3.1 modular Gemfiles.

## [0.1.0] - 2025-11-09

- TAG: [v0.1.0][0.1.0t]
- COVERAGE: 92.43% -- 391/423 lines in 10 files
- BRANCH COVERAGE: 68.18% -- 105/154 branches in 10 files
- 76.67% documented

### Added

- Initial release

### Security

[Unreleased]: https://github.com/galtzo-floss/yaml-converter/compare/v0.2.3...HEAD
[0.2.3]: https://github.com/galtzo-floss/yaml-converter/compare/v0.2.2...v0.2.3
[0.2.3t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.2.3
[0.2.2]: https://github.com/galtzo-floss/yaml-converter/compare/v0.2.1...v0.2.2
[0.2.2t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.2.2
[0.2.1]: https://github.com/galtzo-floss/yaml-converter/compare/v0.2.0...v0.2.1
[0.2.1t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.2.1
[0.2.0]: https://github.com/galtzo-floss/yaml-converter/compare/v0.1.0...v0.2.0
[0.2.0t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.2.0
[0.1.0]: https://github.com/galtzo-floss/yaml-converter/compare/232ad133b6259aabb39993b476f727d91d0a5f0c...v0.1.0
[0.1.0t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.1.0
