autocmd BufNewFile,BufRead *.rkt
    \ if match(getline(1), '#lang dssl2') >= 0
          setfiletype dssl2
      endif

