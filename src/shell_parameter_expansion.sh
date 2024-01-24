expand () {
    echo "${1@Q}"
    echo ${2@Q}
    echo $2
}

c=123
expand "hello \"a\"" "world \"$c\""
