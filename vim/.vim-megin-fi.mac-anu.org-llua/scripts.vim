if did_filetype()   " filetype already set..
    finish      " ..don't do these checks
endif
if getline(1) =~ '^#!.*\<mine\>'
    setfiletype mine
elseif getline(1) =~? '\<drawing\>'
    setfiletype drawing
endif
