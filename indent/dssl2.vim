" Language:     Dssl2
" Author:       Marko Vejnovic <marko.vejnovic@hotmail.com
" URL:          http://github.com/markovejnovic/vim-dssl2
" Note: THIS FILE IS A MOSTLY 1-1 COPY OF python.vim's implementation

" Handles Dssl2 indentation.
" Copyright (C) 2020 Marko Vejnovic
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

" This file is completely, or in part possible thanks to the work of
" https://github.com/vim/vim/blob/master/runtime/indent/python.vim

" This file is a horrible hack (copied from python.vim)
" TODO: Cross check this file to see if there is something clearly stupid
" we're doing.

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal autoindent
setlocal nolisp

setlocal indentexpr=GetIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

" Only define the function once.
if exists("*GetIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

" Come here when loading the script the first time.

let s:maxoff = 50	" maximum number of lines to look backwards for ()

" See if the specified line is already user-dedented from the expected value.
function s:Dedented(lnum, expected)
  return indent(a:lnum) <= a:expected - shiftwidth()
endfunction

function GetIndent(lnum)
    " Handle the continuation of newline with \
    if getline(a:lnum - 1) =~ '\\$'
        " If there's a line before the previous, indent to that
        if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
            return indent(a:lnum - 1)
        endif

        return indent(a:lnum - 1) + (exists("g:dssl2i_continue")
            \ ? eval(g:dssl2i_continue)
            \ : shiftwidth())
    endif

    " If the start of the line is in a string don't change the indent.
    if has('syntax_items')
        \ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
        return -1
    endif

    " Search backwards for the previous non-empty line.
    let plnum = prevnonblank(v:lnum - 1)

    " TODO: Consider whether this is necessary. Because dssl2 has a
    " #lang dssl2 statement, it doesn't make a lot of sense to have this
    " check, but then again, maybe the user wants to write code above that
    " line which is their choice.
    if plnum == 0
        " This is the first non-empty line, use zero indent.
        return 0
    endif

    " TODO: Does this really do anything for us?
    call cursor(plnum, 1)

    " Identing inside parentheses can be very slow, regardless of the
    " searchpair() timeout, so let the user disable this feature if he doesn't
    " need it
    let disable_parentheses_indenting =
        \ get(g:, "dssl2i_disable_parentheses", 0)

    if disable_parentheses_indenting == 1
        let plindent = indent(plnum)
        let plnumstart = plnum
    else

        let searchpair_stopline = 0
        " Timeout limit
        let searchpair_timeout = get(g:, 'dssl2i_searchpair_timeout', 150)

        " If the previous line is inside parentheses, use the indent of the
        " starting line.  Trick: use the non-existing "dummy" variable to
        " break out of the loop when going too far back.
        let parlnum = searchpair('(\|{\|\[', '', ')\|}\|\]', 'nbW',
            \ "line('.') < " . (plnum - s:maxoff) . " ? dummy :"
            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
            \ searchpair_stopline, searchpair_timeout)

        if parlnum > 0
            let plindent = indent(parlnum)
            let plnumstart = parlnum
        else
            let plindent = indent(plnum)
            let plnumstart = plnum
        endif

        " When inside parenthesis: If at the first line below the parenthesis
        " add two 'shiftwidth', otherwise same as previous line.
        " i = (a
        "       + b
        "       + c)
        call cursor(a:lnum, 1)
        let p = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
            \ searchpair_stopline, searchpair_timeout)


        if p > 0
            if p == plnum
                " When the start is inside parenthesis, only indent one
                " 'shiftwidth'.
                let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
                    \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
                    \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
                    \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
                    \ searchpair_stopline, searchpair_timeout)

                if pp > 0
                    return indent(plnum) + (exists("g:pyindent_nested_paren")
                        \ ? eval(g:pyindent_nested_paren)
                        \ : shiftwidth())
                endif

                return indent(plnum) + (exists("g:pyindent_open_paren")
                    \ ? eval(g:pyindent_open_paren)
                    \ : shiftwidth())
            endif

            if plnumstart == p
                return indent(plnum)
            endif

            return plindent
        endif
    endif


    " Get the line and remove a trailing comment.
    " Use syntax highlighting attributes when possible.
    let pline = getline(plnum)
    let pline_len = strlen(pline)
    if has('syntax_items')
        " If the last character in the line is a comment, do a binary search for
        " the start of the comment.  synID() is slow, a linear search would take
        " too long on a long line.
        if synIDattr(synID(plnum, pline_len, 1), "name") =~ "\\(Comment\\|Todo\\)$"
            let min = 1
            let max = pline_len
            while min < max
                let col = (min + max) / 2
                if synIDattr(synID(plnum, col, 1), "name") =~ "\\(Comment\\|Todo\\)$"
                    let max = col
                else
                    let min = col + 1
                endif
            endwhile
            let pline = strpart(pline, 0, min - 1)
        endif
    else
        let col = 0
        while col < pline_len
            if pline[col] == '#'
                let pline = strpart(pline, 0, col)
                break
            endif
            let col = col + 1
        endwhile
    endif

    " If the previous line ended with a colon, indent this line
    if pline =~ ':\s*$'
        return plindent + shiftwidth()
    endif

    " If the previous line was a stop-execution statement...
    if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
        " See if the user has already dedented
        if s:Dedented(a:lnum, indent(plnum))
            " If so, trust the user
            return -1
        endif
        " If not, recommend one dedent
        return indent(plnum) - shiftwidth()
    endif

    " If the current line begins with a header keyword, dedent
    if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'

        " Unless the previous line was a one-liner
        if getline(plnumstart) =~ '^\s*\(for\|if\)\>'
            return plindent
        endif

        " Or the user has already dedented
        if s:Dedented(a:lnum, plindent)
            return -1
        endif

        return plindent - shiftwidth()
    endif

    " When after a () construct we probably want to go back to the start line.
    " a = (b
    "       + c)
    " here
    if parlnum > 0
        " ...unless the user has already dedented
        if s:Dedented(a:lnum, plindent)
            return -1
        else
            return plindent
        endif
    endif

    return -1

endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
