function CheckIfDssl()
    if match(getline(1), '#lang dssl2') >= 0
        setfiletype dssl2
    endif

autocmd BufNewFile,BufRead *.rkt CheckIfDssl()

