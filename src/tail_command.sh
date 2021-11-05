 
function make_script {
    LIM=$(($1-$2))
    echo "BEGIN { RS=\">\"; FS=\"\n\"; ORS=\"\" } NR>1 { if (NR > $LIM + 1) { print \">\" \$0 } }"
}


if [[ -z ${args[--input]} ]]
then
    input=$(cat)
    NRECORDS=$( echo "$input" | grep -c ">" )
    SCRIPT=$(make_script "$NRECORDS" "${args[--number]}")
    echo "$SCRIPT"

    command="echo \"$input\" | awk '$SCRIPT'"
else
    NRECORDS=$(grep -c ">" "${args[--input]}" )
    SCRIPT=$(make_script "$NRECORDS" "${args[--number]}")
    echo "$SCRIPT"
    command="awk '$SCRIPT'"
fi

execute_command "$command" "${args[--input]}" "${args[--output]}"