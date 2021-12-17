

execute_command() {
    # Takes care of IO
    # $1 is the command (required)
    cmd="$1"
    # $2 is the input file (optional)
    input="$2"
    # $3 is the output file (optional)
    output="$3"
    # $4 is a piped command (optional)
    pipe="$4"
    
    
    
    if [[ -z $pipe ]]
    then
        if [[ -z $input ]]
        then
            if [[ -z $output ]]
            then
                eval "$cmd"
            else
                eval "$cmd" > "$output"
            fi
        else
            if [[ -z $output ]]
            then
                eval "$cmd" "$input"
            else
                eval "$cmd" "$input" > "$output"
            fi
        fi
    else
        if [[ -z $input ]]
        then
            if [[ -z $output ]]
            then
                eval "$cmd" "|" "$pipe"
            else
                eval "$cmd" "|" "$pipe" > "$output"
            fi
        else
            if [[ -z $output ]]
            then
                eval "$cmd" "$input" "|" "$pipe"
            else
                eval "$cmd" "$input" "|" "$pipe" > "$output"
            fi
        fi
    fi
}