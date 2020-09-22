syntax match Dssl2Comment "\v\#.*$"

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

" I was lazy and just copied this from https://github.com/keith/swift.vim/blob/master/syntax/swift.vim
" TODO: Check if it works
syntax match Dssl2Number "\v<\d+>"
syntax match Dssl2Number "\v<(\d+_+)+\d+(\.\d+(_+\d+)*)?>"
syntax match Dssl2Number "\v<\d+\.\d+>"
syntax match Dssl2Number "\v<\d*\.?\d+([Ee]-?)?\d+>"
syntax match Dssl2Number "\v<0x[[:xdigit:]_]+([Pp]-?)?\x+>"
syntax match Dssl2Number "\v<0b[01_]+>"
syntax match Dssl2Number "\v<0o[0-7_]+>"

syntax keyword Dssl2Bools
    \ True
    \ False
    \ None

syntax keyword Dssl2Keywords
    \ def
    \ if
    \ elif
    \ else
    \ pass
    \ let
    \ import
    \ lambda
    \ assert
    \ break
    \ continue
    \ let
    \ return
    \ class
    \ struct
    \ interface
    \ test
    \ time
    \ while

highlight default link Dssl2Comment Comment

highlight default link Dssl2Bools Boolean
highlight default link Dssl2Keywords Keyword
highlight default link Dssl2Operator Operator
highlight default link Dssl2Number Number
