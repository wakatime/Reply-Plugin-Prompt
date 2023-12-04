# Reply-Plugin-Prompt

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/wakatime/Reply-Plugin-Prompt/main.svg)](https://results.pre-commit.ci/latest/github/wakatime/Reply-Plugin-Prompt/main)
[![github/workflow](https://github.com/wakatime/Reply-Plugin-Prompt/actions/workflows/main.yml/badge.svg)](https://github.com/wakatime/Reply-Plugin-Prompt/actions)
[![codecov](https://codecov.io/gh/wakatime/Reply-Plugin-Prompt/branch/main/graph/badge.svg)](https://codecov.io/gh/wakatime/Reply-Plugin-Prompt)

[![github/downloads](https://shields.io/github/downloads/wakatime/Reply-Plugin-Prompt/total)](https://github.com/wakatime/Reply-Plugin-Prompt/releases)
[![github/downloads/latest](https://shields.io/github/downloads/wakatime/Reply-Plugin-Prompt/latest/total)](https://github.com/wakatime/Reply-Plugin-Prompt/releases/latest)
[![github/issues](https://shields.io/github/issues/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/discussions)
[![github/milestones](https://shields.io/github/milestones/all/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/milestones)
[![github/forks](https://shields.io/github/forks/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/network/members)
[![github/stars](https://shields.io/github/stars/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/stargazers)
[![github/watchers](https://shields.io/github/watchers/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/watchers)
[![github/contributors](https://shields.io/github/contributors/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/commits)
[![github/release-date](https://shields.io/github/release-date/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/releases/latest)

[![github/license](https://shields.io/github/license/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)
[![github/languages/top](https://shields.io/github/languages/top/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)
[![github/directory-file-count](https://shields.io/github/directory-file-count/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)
[![github/code-size](https://shields.io/github/languages/code-size/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)
[![github/repo-size](https://shields.io/github/repo-size/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)
[![github/v](https://shields.io/github/v/release/wakatime/Reply-Plugin-Prompt)](https://github.com/wakatime/Reply-Plugin-Prompt)

[![cpan/v](https://img.shields.io/cpan/v/Reply-Plugin-Prompt)](https://metacpan.org/pod/Reply::Plugin::Prompt)

[中文](https://metacpan.org/release/FREED/Reply-Plugin-Prompt-0.0.18.0/source/README-zh_CN.md)

Your perl deserves a better REPL!

According to [interactive shells about perl](https://archive.shadowcat.co.uk/blog/matt-s-trout/mstpan-17/),
[reply](https://metacpan.org/pod/Reply) may be the best REPL of perl up to now.
This project provides a reply plugin to support:

- A [powerlevel10k](https://github.com/romkatv/powerlevel10k) style prompt. It
  is an enhancement of [Reply::Plugin::FancyPrompt](https://metacpan.org/pod/Reply::Plugin::FancyPrompt).
  You can customize these sections' order:

```perl
@sections =
  ( 'wakatime', 'result', 'os', 'version', 'path', 'time' );
```

![screenshot](https://user-images.githubusercontent.com/32936898/221406537-5c9222e2-23ed-423c-9860-671b06421aef.jpg)

- A wakatime plugin to statistic how much time you write perl in REPL. Just add `'wakatime'`
  to your `@sections` to enable it.

[![wakatime](https://user-images.githubusercontent.com/32936898/226532448-84086ab6-241a-45f0-b8c1-6db8a7bb3fcf.jpg)](https://wakatime.com)

If there is a git repository, the project name can be achieved by git. Else use
the base name of current working directory.

## Install

### [CPAN](https://metacpan.org/pod/Reply::Plugin::Prompt)

```bash
cpan Reply::Plugin::Prompt
```

### [AUR](https://aur.archlinux.org/packages/perl-reply-plugin-prompt)

```bash
paru -S perl-reply-plugin-prompt
```

## Configure

[`perldoc Reply::Plugin::Prompt`](https://metacpan.org/pod/Reply::Plugin::Prompt).
