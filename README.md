# vim-dssl2

vim-dssl2 is a vim plugin for the [dssl2](https://github.com/tov/dssl2)
[racket](https://racket-lang.org/) sublanguage.

![Screenshot](https://github.com/markovejnovic/vim-dssl2/master/.github/screenshot.png)

### Features

* Simple, regex-based keyword highlighting.
* Small footprint.
* Compatibility with both `neovim` and `vim`.
* Basic `coc-snippets` and (untested) `UltiSnips` snippets

This plugin arose from the need to write a usable plugin for the language.

I love vim (you probably will too) and dssl2 doesn't have a plugin. That's how
we got here.

## Installation

Add the appropriate plugin requirements to your favorite vim package manager.

### Vundle

```vim
Plugin 'markovejnovic/vim-dssl2'
```

### NeoBundle

```vim
NeoBundle 'markovejnovic/vim-dssl2'
```

### VimPlug

```vim
Plug 'markovejnovic/vim-dssl2'
```

### Pathogen

Execute in your shell:

```bash
cd ~/.vim/bundle
git clone https://github.com/markovejnovic/vim-dssl2
```

## Usage

After installation, open a `#dssl2` file and enjoy `vim-dssl2`!

`vim-dssl2` has no configuration options and only exposes `dssl2`'s syntax to
vim.

## Contributing

Contributing is more than appreciated! Thank you!

Please take a look at
[CONTRIBUTING](https://github.com/markovejnovic/vim-dssl2/blob/master/CONTRIBUTING.md)
for more information.

## License

This work is licensed under the
[GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

Please see [LICENSE](https://github.com/markovejnovic/vim-dssl2/blob/master/LICENSE)
for more information.

## Thank You

There's a lot of people I'd like to thank for this small plugin, considering
that I'm quite new to vimscripting:
* [@keith](https://github.com/keith) for writing a fantastic
[article](https://thoughtbot.com/blog/writing-vim-syntax-plugins) on custom vim
plugins.
* [@tov](https://github.com/tov/) for both
[dssl2](https://github.com/tov/dssl2) and the insightful tips he made along the
way.
* [@brammool](https://github.com/brammool) for his fantastic
[python indentation script](https://github.com/vim/vim/blob/master/runtime/indent/python.vim).
* [@stamourv](https://github.com/stamourv) for being extremely supportive in
the process of making this plugin.
