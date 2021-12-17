

execute_command() {
    # Takes care of IO
    # $1 is the command (required)
    # $2 is the input file (optional)
    # $3 is the output file (optional)
    # $4 is a piped command (optional)
    
    if [[ -z $4 ]]
    then
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
    else
        if [[ -z $2 ]]
        then
            if [[ -z $3 ]]
            then
                eval "$1" "|" "$4"
            else
                eval "$1" "|" "$4" > "$3"
            fi
        else
            if [[ -z $3 ]]
            then
                eval "$1" "$2" "|" "$4"
            else
                eval "$1" "$2" "|" "$4" > "$3"
            fi
        fi
    fi
}