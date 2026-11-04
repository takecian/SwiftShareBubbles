# Development dependency security review (2026-11-04)

## Scope and exposure

The root Gemfile installs CocoaPods for development and release tooling. The
podspec includes only SwiftShareBubbles sources/resources, declares no pod
runtime dependencies, and does not include the Gemfile or Ruby gems. These
alerts do not establish a vulnerability in the shipped iOS framework. A
compromised development/release environment could nevertheless affect artifacts.
No Swift sources, public APIs, resources, deployment targets or podspec metadata
are changed by this update.

The original lockfile has 12 findings in ruby-advisory-db:

| Dependency | Original | Risk and applicability |
| --- | --- | --- |
| cocoapods-downloader | 1.2.2 | CVE-2022-21223 / CVE-2022-24440: command injection through Mercurial/Git download arguments. Relevant to a developer processing malicious pod source metadata. Both fixes require at least 1.6.3; the digest's 1.6.0 suggestion is insufficient for both. |
| activesupport | 4.2.11.1 | CVE-2020-8165, CVE-2023-22796, CVE-2023-28120 and CVE-2026-33169/33170/33176. Deserialization, file disclosure and denial-of-service issues in specific APIs. Presence in CocoaPods does not prove those APIs receive attacker-controlled inputs. |
| concurrent-ruby | 1.1.5 | CVE-2026-54904/54905/54906; fixed in 1.3.7. The high-severity issue is a busy loop when AtomicReference#update encounters NaN. No affected application call site was found in this Swift repository. |
| tzinfo | 1.2.5 | CVE-2022-31163: arbitrary Ruby file loading with malicious timezone identifiers and the Ruby data source. tzinfo-data is not in the original bundle; actual exposure depends on the runtime data source and inputs. Fixed in 1.2.10; 2.x is unaffected. |

## Options

| Option | Compatibility | Coverage / decision |
| --- | --- | --- |
| Merge PR #9 only | 1.2.10 satisfies ActiveSupport's `~> 1.1`; its thread_safe dependency is unchanged | Reasonable narrow patch, but leaves the other findings. Not merged separately. |
| Keep CocoaPods 1.6.1; update downloader within `< 2`, concurrent-ruby and tzinfo | Lower toolchain churn, still requires runtime validation | Cannot fix ActiveSupport: CocoaPods requires `< 5`. Temporary mitigation only. |
| CocoaPods 1.16.2 + ActiveSupport 7.2 + patched transitive gems | CocoaPods core accepts ActiveSupport `>= 5, < 8`; ActiveSupport requires Ruby >= 3.1 | Selected. Keep CocoaPods on the 1.16 patch line and prevent vulnerable ActiveSupport/concurrent-ruby resolution. |
| ActiveSupport 8 or CocoaPods 1.17 | ActiveSupport 8 is outside CocoaPods 1.16.2's constraint; 1.17 adds unrelated toolchain changes | Unnecessary for this scoped security update. |

The old fourflusher Git override pins 2.2.0, below the modern CocoaPods requirement
of 2.3.0. Let CocoaPods resolve the released gem instead. Do not suppress alerts,
delete the lockfile, or hand-edit resolved versions to bypass dependency checks.

## Maintainer commands

Use a maintained Ruby (3.3 or newer recommended; dependency minimum is 3.1),
then install the Bundler version in Gemfile.lock and run:

```sh
bundle install
bundle exec pod --version
bundle exec pod ipc spec SwiftShareBubbles.podspec
# On macOS with Xcode, validate integration and the existing Swift API build:
bundle exec pod lib lint SwiftShareBubbles.podspec --allow-warnings
xcodebuild -project SwiftShareBubbles.xcodeproj -scheme SwiftShareBubbles \
  -sdk iphonesimulator CODE_SIGNING_ALLOWED=NO build
```

Run `bundler-audit check --update` with a separately installed bundler-audit.
Commit the regenerated lockfile when deliberately updating dependencies.
The modern Xcode SDK may warn about the existing iOS 8 deployment target; changing
that target is outside this dependency-only fix.

## Sources

- [Original dependency manifest](https://github.com/takecian/SwiftShareBubbles/blob/7eb51f522f26c943c62cb73aa8cc60f85d4100c2/Gemfile.lock)
- [Dependabot PR #9](https://github.com/takecian/SwiftShareBubbles/pull/9)
- [CocoaPods core 1.16.2 constraints](https://rubygems.org/gems/cocoapods-core/versions/1.16.2/dependencies)
- [ActiveSupport advisory](https://github.com/rails/rails/security/advisories/GHSA-cg4j-q9v8-6v38)
- [concurrent-ruby advisory](https://github.com/ruby-concurrency/concurrent-ruby/security/advisories/GHSA-h8w8-99g7-qmvj)
- [TZInfo advisory](https://github.com/tzinfo/tzinfo/security/advisories/GHSA-5cm2-9h8c-rvfx)
- [Ruby advisory database](https://github.com/rubysec/ruby-advisory-db)

## Validation of this change

- Bundler 2.4.20 resolved and installed the bundle on Linux / Ruby 3.2.3.
- `bundle check` passed; `bundle exec pod --version` returned 1.16.2.
- `pod ipc spec` successfully parsed the unchanged podspec: version 1.2.0,
  Swift 5.0, iOS 8.0, and no runtime pod dependencies.
- xcodeproj 1.28.1 successfully read both existing project targets.
- bundler-audit 0.9.3 found 12 advisories before the update and none after it,
  using ruby-advisory-db commit `adeaf1283ee64aae48bb61150a773283ff285175`.
  This is a point-in-time advisory check, not a guarantee against unknown issues.
- The lockfile includes Ruby, Apple Silicon/Intel macOS and Linux platforms.
- Gemfile and podspec syntax checks and `git diff --check` passed.
- Swift sources, tests, demo, resources, podspec and Xcode project are unchanged.
- Full iOS compilation and `pod lib lint` were not run: this execution environment
  has no macOS/Xcode SDK. Run the commands above before merging/releasing.

Resolved versions: CocoaPods 1.16.2, cocoapods-downloader 2.1, ActiveSupport 7.2.4,
concurrent-ruby 1.3.8, tzinfo 2.0.6 and fourflusher 2.3.1. PR #9's security fix is
superseded by the tzinfo 2.x update; leave it open until this change is accepted.
