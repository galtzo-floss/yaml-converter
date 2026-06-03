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

### Changed

### Deprecated

### Removed

### Fixed

### Security

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

[Unreleased]: https://github.com/galtzo-floss/yaml-converter/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/galtzo-floss/yaml-converter/compare/v0.1.0...v0.2.0
[0.2.0t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.2.0
[0.1.0]: https://github.com/galtzo-floss/yaml-converter/compare/232ad133b6259aabb39993b476f727d91d0a5f0c...v0.1.0
[0.1.0t]: https://github.com/galtzo-floss/yaml-converter/releases/tag/v0.1.0
