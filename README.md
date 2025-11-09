| 📍 NOTE                                                                                                                                                           |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RubyGems (the [GitHub org][rubygems-org], not the website) [suffered][draper-security] a [hostile takeover][ellen-takeover] in September 2025.                    |
| Ultimately [4 maintainers][simi-removed] were [hard removed][martin-removed] and a reason has been given for only 1 of those, while 2 others resigned in protest. |
| It is a [complicated story][draper-takeover] which is difficult to [parse quickly][draper-lies].                                                                  |
| I'm adding notes like this to gems because I [don't condone theft][draper-theft] of repositories or gems from their rightful owners.                              |
| If a similar theft happened with my repos/gems, I'd hope some would stand up for me.                                                                              |
| Disenfranchised former-maintainers have started [gem.coop][gem-coop].                                                                                             |
| Once available I will publish there exclusively; unless RubyCentral makes amends with the community.                                                              |
| The ["Technology for Humans: Joel Draper"][reinteractive-podcast] podcast episode by [reinteractive][reinteractive] is the most cogent summary I'm aware of.      |
| See [here][gem-naming], [here][gem-coop] and [here][martin-ann] for more info on what comes next.                                                                 |
| What I'm doing: A (WIP) proposal for [bundler/gem scopes][gem-scopes], and a (WIP) proposal for a federated [gem server][gem-server].                             |

[rubygems-org]: https://github.com/rubygems/
[draper-security]: https://joel.drapper.me/p/ruby-central-security-measures/
[draper-takeover]: https://joel.drapper.me/p/ruby-central-takeover/
[ellen-takeover]: https://pup-e.com/blog/goodbye-rubygems/
[simi-removed]: https://www.reddit.com/r/ruby/s/gOk42POCaV
[martin-removed]: https://bsky.app/profile/martinemde.com/post/3m3occezxxs2q
[draper-lies]: https://joel.drapper.me/p/ruby-central-fact-check/
[draper-theft]: https://joel.drapper.me/p/ruby-central/
[reinteractive]: https://reinteractive.com/ruby-on-rails
[gem-coop]: https://gem.coop
[gem-naming]: https://github.com/gem-coop/gem.coop/issues/12
[martin-ann]: https://martinemde.com/2025/10/05/announcing-gem-coop.html
[gem-scopes]: https://github.com/galtzo-floss/bundle-namespace
[gem-server]: https://github.com/galtzo-floss/gem-server
[reinteractive-podcast]: https://youtu.be/_H4qbtC5qzU?si=BvuBU90R2wAqD2E6

[![Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0][🖼️galtzo-i]][🖼️galtzo-discord] [![ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5][🖼️ruby-lang-i]][🖼️ruby-lang] [![yaml-converter Logo by Aboling0, CC BY-SA 4.0][🖼️yaml-converter-i]][🖼️yaml-converter]

[🖼️galtzo-i]: https://logos.galtzo.com/assets/images/galtzo-floss/avatar-192px.svg
[🖼️galtzo-discord]: https://discord.gg/3qme4XHNKN
[🖼️ruby-lang-i]: https://logos.galtzo.com/assets/images/ruby-lang/avatar-192px.svg
[🖼️ruby-lang]: https://www.ruby-lang.org/
[🖼️yaml-converter-i]: https://logos.galtzo.com/assets/images/galtzo-floss/yaml-converter/avatar-192px.svg
[🖼️yaml-converter]: https://github.com/galtzo-floss/yaml-converter

# 🍕 Yaml::Converter

[![Version][👽versioni]][👽version] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: MIT][📄license-img]][📄license-ref] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![Open Source Helpers][👽oss-helpi]][👽oss-help] [![CodeCov Test Coverage][🏀codecovi]][🏀codecov] [![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls] [![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov] [![QLTY Maintainability][🏀qlty-mnti]][🏀qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Supported][🚎6-s-wfi]][🚎6-s-wf] [![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf] [![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf] [![CI Ancient][🚎1-an-wfi]][🚎1-an-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Apache SkyWalking Eyes License Compatibility Check][🚎15-🪪-wfi]][🚎15-🪪-wf]

`if ci_badges.map(&:color).detect { it != "green"}` ☝️ [let me know][🖼️galtzo-discord], as I may have missed the [discord notification][🖼️galtzo-discord].

---

`if ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate at ko-fi.com][🖇kofi-img]][🖇kofi]

## 🌻 Synopsis

Transform annotated YAML blueprints into human-friendly documentation. This gem:

- Fences raw YAML content
- Injects a validation status line with date (deterministic via current_date option)
- Extracts inline `#note:` annotations into readable blockquotes (or PDF note sections)
- Truncates overly long YAML lines (configurable)
- Emits Markdown, HTML, PDF (native Prawn), DOCX/PDF/other via pandoc

Ideal for design documents stored as YAML, making them consumable in multiple formats.

## ⚙️ Configuration

Pass options via API, CLI flags, or ENV variables.

Core Options:

- max_line_length (Integer, default 70)
- truncate (Boolean, default true)
- margin_notes (:auto | :inline | :ignore)
- validate (Boolean, default true)
- use_pandoc (Boolean, default false)
- pandoc_args (Array<String> default ["-N", "--toc"])
- current_date (Date, default Date.today) for deterministic validation line
- pdf_page_size (e.g., LETTER)
- pdf_two_column_notes (Boolean)

ENV overrides (examples):

```bash
export YAML_CONVERTER_MAX_LINE_LEN=120
export YAML_CONVERTER_TRUNCATE=false
export YAML_CONVERTER_VALIDATE=false
```

Overwrite Warning:
If the output file exists an informational warning is printed: "Overwriting existing file".
Suppress by setting `KETTLE_TEST_SILENT=true` (used in CI/tests).

Deterministic Dates:
Inject `current_date:` in `options` or stub time for tests; the state machine uses this value.

### Supported Formats (Phase 1)

- Markdown (.md)
- HTML (.html) via kramdown
- PDF (.pdf) native (Prawn) or via pandoc when `use_pandoc: true`
- DOCX (.docx) via pandoc (auto-detects pandoc path)
- Other pandoc-supported formats (set output extension + `--use-pandoc`)

### Notes Handling

Inline `#note:` at end of a YAML line:

```yaml
key: value #note: important detail
```

Will produce a blockquote note just after the YAML fenced block.

### ENV Configuration

Override defaults using ENV (before process start):

```bash
export YAML_CONVERTER_MAX_LINE_LEN=120
export YAML_CONVERTER_TRUNCATE=false
export YAML_CONVERTER_VALIDATE=false
```

### Validation Status Line

Any comment line that begins with `# YAML validation:` will be replaced with a status and date:

```
YAML validation:*OK* on dd/mm/YYYY
```

### Footer

A production footer is always appended:

```
----
Produced by yaml-converter
```

### Future Enhancements

See `IMPLEMENTATION_PLAN.md` for upcoming phases (native PDF, streaming, plugin renderers).

## 🔧 Basic Usage

### Library API

Minimal conversion to Markdown:

```ruby
require "yaml/converter"
markdown = Yaml::Converter.to_markdown(File.read("spec/fixtures/example.yaml"))
puts markdown
```

Convert directly to a file (extension decides behavior):

```ruby
Yaml::Converter.convert(
  input_path: "spec/fixtures/example.yaml",
  output_path: "doc/example.html",
  options: {validate: true},
)
```

Deterministic date for tests (inject current_date):

```ruby
Yaml::Converter.to_markdown(yaml_str, options: {current_date: Date.new(2025, 11, 8)})
```

Native PDF vs pandoc PDF:

```ruby
# Native PDF using Prawn
Yaml::Converter.convert(
  input_path: "blueprint.yaml",
  output_path: "blueprint.pdf",
  options: {use_pandoc: false, pdf_two_column_notes: true},
)

# PDF via pandoc (requires pandoc in PATH)
Yaml::Converter.convert(
  input_path: "blueprint.yaml",
  output_path: "blueprint.pdf",
  options: {use_pandoc: true, pandoc_args: ["-N", "--toc"]},
)
```

DOCX via pandoc:

```ruby
Yaml::Converter.convert(
  input_path: "blueprint.yaml",
  output_path: "blueprint.docx",
  options: {},
)
```

### CLI

Install gem (development checkout already has exe script):

```bash
bundle exec ruby exe/yaml-convert input.yaml output.md
bundle exec ruby exe/yaml-convert input.yaml output.html
bundle exec ruby exe/yaml-convert input.yaml output.pdf --use-pandoc
```

If pandoc is not installed, the command will exit with code 5 and a helpful message.

DOCX example (CLI):

```bash
bundle exec ruby exe/yaml-convert blueprint.yaml output.docx --use-pandoc
```

Batch mode with glob:

```bash
bundle exec ruby exe/yaml-convert --glob 'docs/**/*.yaml' --out-ext md --out-dir out/
```

## 🦷 FLOSS Funding

While galtzo-floss tools are free software and will always be, the project would benefit immensely from some funding.
Raising a monthly budget of... "dollars" would make the project more sustainable.

We welcome both individual and corporate sponsors! We also offer a
wide array of funding channels to account for your preferences
(although currently [Open Collective][🖇osc] is our preferred funding platform).

**If you're working in a company that's making significant use of galtzo-floss tools we'd
appreciate it if you suggest to your company to become a galtzo-floss sponsor.**

You can support the development of galtzo-floss tools via
[GitHub Sponsors][🖇sponsor],
[Liberapay][⛳liberapay],
[PayPal][🖇paypal],
[Open Collective][🖇osc]
and [Tidelift][🏙️entsup-tidelift].

| 📍 NOTE                                                                                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| If doing a sponsorship in the form of donation is problematic for your company <br/> from an accounting standpoint, we'd recommend the use of Tidelift, <br/> where you can get a support-like subscription instead. |

### Open Collective for Individuals

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/galtzo-floss#backer)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-INDIVIDUALS:START -->
No backers yet. Be the first!
<!-- OPENCOLLECTIVE-INDIVIDUALS:END -->

### Open Collective for Organizations

Become a sponsor and get your logo on our README on GitHub with a link to your site. [[Become a sponsor](https://opencollective.com/galtzo-floss#sponsor)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-ORGANIZATIONS:START -->
No sponsors yet. Be the first!
<!-- OPENCOLLECTIVE-ORGANIZATIONS:END -->

[kettle-readme-backers]: https://github.com/galtzo-floss/yaml-converter/blob/main/exe/kettle-readme-backers

### Another way to support open-source

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small.  Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions.  I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [reek](REEK), [issues][🤝gh-issues], or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

[![Coverage Graph][🏀codecov-g]][🏀codecov]

[![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls]

[![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov]

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/galtzo-floss/yaml-converter/-/graphs/main][🚎contributors-gl]

<details>
    <summary>⭐️ Star History</summary>

<a href="https://star-history.com/#galtzo-floss/yaml-converter&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=galtzo-floss/yaml-converter&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=galtzo-floss/yaml-converter&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=galtzo-floss/yaml-converter&type=Date" />
 </picture>
</a>

</details>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

> dropping support for a platform is both obviously and objectively a breaking change <br/>
>—Jordan Harband ([@ljharb](https://github.com/ljharb), maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

I understand that policy doesn't work universally ("exceptions to every rule!"),
but it is the policy here.
As such, in many cases it is good to specify a dependency on this library using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("yaml-converter", "~> 1.0")
```

<details markdown="1">
<summary>📌 Is "Platform Support" part of the public API? More details inside.</summary>

SemVer should, IMO, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API, and for that reason the bike shedding is endless.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

</details>

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<ul>
    <li>
        Copyright (c) 2023, 2025 Peter H. Boling, of
        <a href="https://discord.gg/3qme4XHNKN">
            Galtzo.com
            <picture>
              <img src="https://logos.galtzo.com/assets/images/galtzo-floss/avatar-128px-blank.svg" alt="Galtzo.com Logo (Wordless) by Aboling0, CC BY-SA 4.0" width="24">
            </picture>
        </a>, and yaml-converter contributors.
    </li>
</ul>

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March, and encountering difficulty finding a new one,
I began spending most of my time building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help 👇️ Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks!" ☝️ Join the Discord or 👇️ send money.

[![Sponsor galtzo-floss/yaml-converter on Open Source Collective][🖇osc-all-bottom-img]][🖇osc] 💌 [![Sponsor me on GitHub Sponsors][🖇sponsor-bottom-img]][🖇sponsor] 💌 [![Sponsor me on Liberapay][⛳liberapay-bottom-img]][⛳liberapay] 💌 [![Donate on PayPal][🖇paypal-bottom-img]][🖇paypal]

### Please give the project a star ⭐ ♥.

Thanks for RTFM. ☺️

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay&color=a51611&style=flat
[⛳liberapay-bottom-img]: https://img.shields.io/liberapay/goal/pboling.svg?style=for-the-badge&logo=liberapay&color=a51611
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇osc-all-img]: https://img.shields.io/opencollective/all/galtzo-floss
[🖇osc-sponsors-img]: https://img.shields.io/opencollective/sponsors/galtzo-floss
[🖇osc-backers-img]: https://img.shields.io/opencollective/backers/galtzo-floss
[🖇osc-backers]: https://opencollective.com/galtzo-floss#backer
[🖇osc-backers-i]: https://opencollective.com/galtzo-floss/backers/badge.svg?style=flat
[🖇osc-sponsors]: https://opencollective.com/galtzo-floss#sponsor
[🖇osc-sponsors-i]: https://opencollective.com/galtzo-floss/sponsors/badge.svg?style=flat
[🖇osc-all-bottom-img]: https://img.shields.io/opencollective/all/galtzo-floss?style=for-the-badge
[🖇osc-sponsors-bottom-img]: https://img.shields.io/opencollective/sponsors/galtzo-floss?style=for-the-badge
[🖇osc-backers-bottom-img]: https://img.shields.io/opencollective/backers/galtzo-floss?style=for-the-badge
[🖇osc]: https://opencollective.com/galtzo-floss
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor-bottom-img]: https://img.shields.io/badge/Sponsor_Me!-pboling-blue?style=for-the-badge&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-a51611.svg?style=flat
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-%E2%9C%93-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-a51611.svg?style=flat
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-%E2%9C%93-a51611.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇paypal-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=flat&logo=paypal
[🖇paypal-bottom-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=for-the-badge&logo=paypal&color=0A0A0A
[🖇paypal]: https://www.paypal.com/paypalme/peterboling
[🖇floss-funding.dev]: https://floss-funding.dev
[🖇floss-funding-gem]: https://github.com/galtzo-floss/floss_funding
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img-ftb]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge&logo=discord
[✉️ruby-friends-img]: https://img.shields.io/badge/daily.dev-%F0%9F%92%8E_Ruby_Friends-0A0A0A?style=for-the-badge&logo=dailydotdev&logoColor=white
[✉️ruby-friends]: https://app.daily.dev/squads/rubyfriends

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/galtzo-floss/yaml-converter
[⛳️namespace-img]: https://img.shields.io/badge/namespace-Yaml::Converter-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://bestgems.org/gems/yaml-converter
[⛳️name-img]: https://img.shields.io/badge/name-yaml--converter-3C2D2D.svg?style=square&logo=rubygems&logoColor=red
[⛳️tag-img]: https://img.shields.io/github/tag/galtzo-floss/yaml-converter.svg
[⛳️tag]: http://github.com/galtzo-floss/yaml-converter/releases
[🚂maint-blog]: http://www.railsbling.com/tags/yaml-converter
[🚂maint-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂maint-contact]: http://www.railsbling.com/contact
[🚂maint-contact-img]: https://img.shields.io/badge/Contact-Maintainer-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://wellfound.com/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https://ruby.social&style=flat&logo=mastodon&label=Ruby%20@galtzo
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription/pkg/rubygems-yaml-converter?utm_source=rubygems-yaml-converter&utm_medium=referral&utm_campaign=readme
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/galtzo-floss/yaml-converter/
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/galtzo-floss/yaml-converter
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/galtzo-floss/yaml-converter
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜gl-wiki]: https://gitlab.com/galtzo-floss/yaml-converter/-/wikis/home
[📜gh-wiki]: https://github.com/galtzo-floss/yaml-converter/wiki
[📜gl-wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=gitlab&logoColor=white
[📜gh-wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=github&logoColor=white
[👽dl-rank]: https://bestgems.org/gems/yaml-converter
[👽dl-ranki]: https://img.shields.io/gem/rd/yaml-converter.svg
[👽oss-help]: https://www.codetriage.com/galtzo-floss/yaml-converter
[👽oss-helpi]: https://www.codetriage.com/galtzo-floss/yaml-converter/badges/users.svg
[👽version]: https://bestgems.org/gems/yaml-converter
[👽versioni]: https://img.shields.io/gem/v/yaml-converter.svg
[🏀qlty-mnt]: https://qlty.sh/gh/galtzo-floss/projects/yaml-converter
[🏀qlty-mnti]: https://qlty.sh/gh/galtzo-floss/projects/yaml-converter/maintainability.svg
[🏀qlty-cov]: https://qlty.sh/gh/galtzo-floss/projects/yaml-converter/metrics/code?sort=coverageRating
[🏀qlty-covi]: https://qlty.sh/gh/galtzo-floss/projects/yaml-converter/coverage.svg
[🏀codecov]: https://codecov.io/gh/galtzo-floss/yaml-converter
[🏀codecovi]: https://codecov.io/gh/galtzo-floss/yaml-converter/graph/badge.svg
[🏀coveralls]: https://coveralls.io/github/galtzo-floss/yaml-converter?branch=main
[🏀coveralls-img]: https://coveralls.io/repos/github/galtzo-floss/yaml-converter/badge.svg?branch=main
[🖐codeQL]: https://github.com/galtzo-floss/yaml-converter/security/code-scanning
[🖐codeQL-img]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/codeql-analysis.yml/badge.svg
[🚎1-an-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/unsupported.yml/badge.svg
[🚎8-ho-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/hoary.yml/badge.svg
[🚎9-t-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/dep-heads.yml
[🚎12-crh-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/dep-heads.yml/badge.svg
[🚎13-🔒️-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/locked_deps.yml
[🚎13-🔒️-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/locked_deps.yml/badge.svg
[🚎14-🔓️-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/unlocked_deps.yml
[🚎14-🔓️-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/unlocked_deps.yml/badge.svg
[🚎15-🪪-wf]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/license-eye.yml
[🚎15-🪪-wfi]: https://github.com/galtzo-floss/yaml-converter/actions/workflows/license-eye.yml/badge.svg
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.1i]: https://img.shields.io/badge/JRuby-9.1_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/galtzo-floss/yaml-converter/issues
[🤝gh-pulls]: https://github.com/galtzo-floss/yaml-converter/pulls
[🤝gl-issues]: https://gitlab.com/galtzo-floss/yaml-converter/-/issues
[🤝gl-pulls]: https://gitlab.com/galtzo-floss/yaml-converter/-/merge_requests
[🤝cb-issues]: https://codeberg.org/galtzo-floss/yaml-converter/issues
[🤝cb-pulls]: https://codeberg.org/galtzo-floss/yaml-converter/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: CONTRIBUTING.md
[🏀codecov-g]: https://codecov.io/gh/galtzo-floss/yaml-converter/graphs/tree.svg
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/galtzo-floss/yaml-converter/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=galtzo-floss/yaml-converter
[🚎contributors-gl]: https://gitlab.com/galtzo-floss/yaml-converter/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]: https://gitmoji.dev
[📌gitmoji-img]: https://img.shields.io/badge/gitmoji_commits-%20%F0%9F%98%9C%20%F0%9F%98%8D-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-4.278-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄license-compat]: https://dev.to/galtzo/how-to-check-license-compatibility-41h0
[📄license-compat-img]: https://img.shields.io/badge/Apache_Compatible:_Category_A-%E2%9C%93-259D6C.svg?style=flat&logo=Apache
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/yaml-converter
[🚎yard-head]: https://yaml-converter.galtzo.com
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[💎SHA_checksums]: https://gitlab.com/galtzo-floss/yaml-converter/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_&_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎appraisal2]: https://github.com/appraisal-rb/appraisal2
[💎appraisal2-img]: https://img.shields.io/badge/appraised_by-appraisal2-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/
