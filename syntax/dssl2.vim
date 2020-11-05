" File: dssl2.vim
" Author: Marko Vejnovic
" Description: Syntax definitions for DSSL2

" vim-dssl2: A plugin for Racket/Dssl2.
" Copyright (C) 2020 Marko Vejnovic <marko.vejnovic@hotmail.com>
" 
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <https://www.gnu.org/licenses/>.

if exists("b:current_syntax")
    finish
endif

" Comments
syntax match Dssl2Comment "\v\#.*$" contains=Dssl2Todo
syntax keyword Dssl2Todo contained TODO FIXME XXX BUG NOTE

" Literals
" Strings
syntax region Dssl2String start=/"/ end=/"/ contains=Dssl2InterpolatedWrapped oneline
syntax region Dssl2String start=/'/ end=/'/ contains=Dssl2InterpolatedWrapped oneline
" TODO: Test this a bit better, since it was copied from the swift syntax
" highlight.
syntax region Dssl2InterpolatedWrapped start='\v(^)\zs\\\(\s*' end='\v\s*\)' contained containedin=Dssl2String contains=Dssl2String,Dssl2InterpolatedString oneline
" TODO: Test this a bit better, since it was copied from the swift syntax
" highlight.
syntax match Dssl2InterpolatedString "\v\w+(\(\))?" contained containedin=Dssl2InterpolatedWrapped oneline
syntax region Dssl2MultilineString start=/"""/ end=/"""/ contains=Dssl2InterpolatedWrapped

" Numbers
syntax match Dssl2Number "\v<\d+>" " Integers
syntax match Dssl2Number "\v<\d+\.\d+>" " Decimals
syntax match Dssl2Number "\v<0x[[:xdigit:]_]+([Pp]-?)?\x+>" " Hex
syntax match Dssl2Number "\v<0b[01_]+>" " Binary
syntax match Dssl2Number "\v<0o[0-7_]+>" " Octal
" Powers like 1.03e-2
syntax match Dssl2Number "\v<\d+e-?\d+>" " Powers, like 1e-12
syntax match Dssl2Number "\v<\d+\.\d+e-?\d+>" " Powers, like 1e-12
syntax match Dssl2Number "\v<\d+E-?\d+>" " Powers, like 1e-12
syntax match Dssl2Number "\v<\d+\.\d+E-?\d+>" " Powers, like 1e-12
" Special
syntax keyword Dssl2Number
    \ inf
    \ nan

" Bools
syntax keyword Dssl2Bools
    \ True
    \ False

" Operators
syntax match Dssl2Operator "\v\*\*"
syntax match Dssl2Operator "\v\*"
syntax match Dssl2Operator "\v\/"
syntax match Dssl2Operator "\v\%"
syntax match Dssl2Operator "\v\+"
syntax match Dssl2Operator "\v-"
syntax match Dssl2Operator "\v\<\<"
syntax match Dssl2Operator "\v\>\>"
syntax match Dssl2Operator "\v\&"
syntax match Dssl2Operator "\v\^"
syntax match Dssl2Operator "\v\|"
syntax match Dssl2Operator "\v\="
syntax match Dssl2Operator "\v\<"
syntax match Dssl2Operator "\v\>"
syntax match Dssl2Operator "\v\>\="
syntax match Dssl2Operator "\v\<\="
syntax match Dssl2Operator "\v\!\="
syntax match Dssl2Operator "\v\s+is\s+"
syntax match Dssl2Operator "\v\s+is\ not\s+"
syntax match Dssl2Operator "\vnot\s+"
syntax match Dssl2Operator "\v\s+and\s+"
syntax match Dssl2Operator "\s\s+or\s+"
syntax match Dssl2Operator "\v\~"

" Methods, Functions and Properties
syntax match Dssl2Method "\.\@<=\<\D\w*\>\ze("
syntax match Dssl2Property "\.\@<=\<\D\w*\>(\@!"

syntax match Dssl2FunctionDef /def.*\ze:\?/ contains=
    \ Dssl2PContract,
    \ Dssl2Param,
    \ Dssl2DefKw,
    \ Dssl2RContract,
    \ Dssl2ArrowKw
syntax match Dssl2DefKw /def\s\+/ contained
" TODO: This ? matching is a hack. See 'isk
syntax match Dssl2Param /\((\|,\s\+\)\zs\(\(\k\|?\)\+\)\ze\(:\|)\|,\)/ contained
syntax match Dssl2PContract /:\s\+\zs\S\+\ze\(,\|)\)/ contained " Param Contract
syntax match Dssl2RContract /->\s\+\zs\S\+\ze:/ contained " Return Contract

syntax keyword Dssl2Keywords
    \ let
    \ for
    \ import
    \ lambda
    \ assert
    \ assert_error
    \ None
    \ time
    \ while
    \ in
    \ λ
    \ ∉

syntax keyword Dssl2Self self

syntax keyword Dssl2Conditional
    \ if
    \ elif
    \ else

syntax keyword Dssl2Statement
    \ pass
    \ break
    \ continue
    \ return

syntax keyword Dssl2Structure
    \ struct
    \ class
    \ interface
    \ test

highlight default link Dssl2Todo Todo
highlight default link Dssl2Comment Comment

highlight default link Dssl2String String
highlight default link Dssl2MultilineString String
highlight default link Dssl2InterpolatedWrapped Delimiter
highlight default link Dssl2Bools Boolean
highlight default link Dssl2Number Number

highlight default link Dssl2Operator Operator
highlight default link Dssl2Keywords Keyword
highlight default link Dssl2Import Import
highlight default link Dssl2Conditional Conditional
highlight default link Dssl2Statement Statement
highlight default link Dssl2Structure Structure
highlight default link Dssl2Self Identifier
highlight default link Dssl2Method Function
highlight default link Dssl2Property Identifier

" Custom Highlight Groups
highlight default link Dssl2Param Function
highlight Dssl2PContract cterm=italic ctermfg=208 gui=italic guifg=#FF9700
highlight Dssl2RContract cterm=italic ctermfg=208 gui=italic guifg=#FF9700
highlight default link Dssl2DefKw Keyword

let b:current_syntax = "dssl2"
