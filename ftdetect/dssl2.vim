au! BufNewFile,BufRead *.rkt call s:CheckIfDssl()

function! s:CheckIfDssl()
    " Optimally, this function should check if `vim-racket` is already doing
    " the handling of which sublanguage is being used, however, I could not
    " find if `vim-racket` exposes a g:VimRacket_exists variable (or something
    " similar), so, in this implementation, we're competing with it. That's
    " not an issue, since the result should be the same. It is a bit slower,
    " though. TODO: Fix
    
    " This expression was based on vim-racket/ftdetect/racket.vim
    " https://github.com/wlangstroth/vim-racket/blob/master/ftdetect/racket.vim
    let l:dssl_lang_regexp = '^#lang\s\+\(dssl2\)'

    let l:matches = matchlist(getline(1), l:dssl_lang_regexp)

    if !empty(l:matches)
        set filetype=dssl2
    endif
endfunction

