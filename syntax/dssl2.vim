" File: dssl2.vim
" Author: Marko Vejnovic
" Description: Syntax definitions for DSSL2

" TODO: In general, this works nice, but it doesn't highlight structure names
" For example: `struct name` will not highlight `name`.

if exists("b:current_syntax")
    finish
endif

" Comments
syntax match Dssl2Comment "\v\#.*$"
" TODO Doesn't appear to work
syntax keyword Dssl2Todo contained TODO FIXME

" TODO: Missing docstring parsing.
" Dssl2 has a weird docstring form that exposes some sort of type-checking.

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

" Numbers
" I was lazy and just copied this from https://github.com/keith/swift.vim/blob/master/syntax/swift.vim
" TODO: Check if it works
syntax match Dssl2Number "\v<\d+>"
syntax match Dssl2Number "\v<(\d+_+)+\d+(\.\d+(_+\d+)*)?>"
syntax match Dssl2Number "\v<\d+\.\d+>"
syntax match Dssl2Number "\v<\d*\.?\d+([Ee]-?)?\d+>"
syntax match Dssl2Number "\v<0x[[:xdigit:]_]+([Pp]-?)?\x+>"
syntax match Dssl2Number "\v<0b[01_]+>"
syntax match Dssl2Number "\v<0o[0-7_]+>"

" Bools
" TODO: Decide if None should be here.
syntax keyword Dssl2Bools
    \ True
    \ False
    \ None

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
syntax match Dssl2Operator "\vis"
syntax match Dssl2Operator "\vnot"
syntax match Dssl2Operator "\vand"
syntax match Dssl2Operator "\sor"
syntax match Dssl2Operator "\v\~"

" Methods, Functions and Properties
" TODO: I don't know what \@<= means in vim regex and I couldn't find any
" info on it.
syntax match Dssl2Method "\.\@<=\<\D\w*\>\ze("
syntax match Dssl2Property "\.\@<=\<\D\w*\>(\@!"

" TODO: Missing method declaration

" Arguments
" TODO

syntax keyword Dssl2Keywords
    \ def
    \ let
    \ import
    \ lambda
    \ assert
    \ assert_error
    \ let
    \ time
    \ while

syntax keyword Dssl2Self self

syntax keyword Dssl2Import import
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

let b:current_syntax = "dssl2"
