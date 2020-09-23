function CheckIfDssl()
    if match(getline(1), "#lang\s\+dssl2")
        set filetype=dssl2
    endif
endfunction

augroup Dssl2
    autocmd!
    autocmd BufNewFile,BufRead *.rkt call CheckIfDssl()
augroup END
