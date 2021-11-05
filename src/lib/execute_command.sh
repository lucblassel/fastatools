 

execute_command() {
# Takes care of IO
# $1 is the command (required)
# $2 is the input file (optional)
# $3 is the output file (optional)

    if [[ -z $2 ]]
    then
        if [[ -z $3 ]]
        then
            eval "$1"
        else
            eval "$1" > "$3"
        fi
    else
        if [[ -z $3 ]]
        then
            eval "$1" "$2"
        else
            eval "$1" "$2" > "$3"
        fi
    fi
}