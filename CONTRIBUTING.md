# Contributing to vim-dssl2

First of all, thank you! If you're here, thank you for wanting to contribute! I
really appreciate it.

## General

Prior to version v0.2.0, `vim-dssl2` didn't follow any strict contributing
guidelines.

With the scope of `vim-dssl2` becoming larger, I've changed that.

We currently have guidelines for:
* Reporting an issue
* Discussing features
* Submitting a fix

### Reporting issues / feature discussions

Reporting issues should be quite simple. You should open a new
[GitHub Issue](https://github.com/markovejnovic/vim-dssl2/issues). I've prepared some
templates for your convenience. Please use them if the issue you are working on
fits them. You are, of course, not required to use them (as many issues won't
fit them).

Generally, to make a good issue, I'd appreciate if you could write (if
appropriate):
* A summary on the topic [TL;DR]
* A longer description on the topic.
* Steps to reproduce
* Screenshots
Naturally, this isn't all-encompassing. I'll take a look at all issues, but the
better issues will be easier to work on.

### Coding style

Albeit not used prior to v0.2.0, the coding style of choice is the
[Google Vimscript Style Guide
R1.1](https://google.github.io/styleguide/vimscriptguide.xml), with the notable
exception of not using __maktaba__.

Adhere to the style as much as possible. If there was a decision you made in
which you chose not to adhere to it, please note it if merging into `master`.

## Code Contributions

### TL;DR

1. Make a fork of the repository
2. Make sure that the branch you're working on is a `master` child
3. Document your code appropriately
4. Adhere to the style guide
5. Make a pull request

### General

This repository employs a rule-based contribution system. Each type of branch
and commit has certain requirements that need to be upheld at all times.

### Rules of Master

Each commit on the `master` branch must be deployable. There musn't be any bugs
which prevent loading of `vim` on `master`. In other words, the user must be
able to install the plugin and not worry about it on `master`.

**Requirement**: Deployability

### Pull Requests

Each branch looking to get merged into `master` must uphold the requirements of
`master` at the commit which is getting merged. The name of the branch must be
descriptive to what is being done (eg. `fix-indent`, `add-contract-syn`) on it.

All branches looking to get merged into `master` must have clear, intentional
choices done to them. In other words, if you are fixing indentation on a branch
don't add new snippets in it. Furthermore, for each decision (feature or bug),
the branch implementing that decision must be fresh off `master`.

**Requirement**: Intention, clarity, `master` parenthood.

### External contribution

All external contribution must be done via forks. If you'd like to contribute,
make a fork of the branch and adhere to the other requirements before making
a pull request.

## License

You agree with each pull request that your contributions will be licensed under
GPLv3.

## Other notes

### Git Host

Currently, the code is hosted on GitHub, but that may change. Do not heavily
rely on GitHub-only features.
