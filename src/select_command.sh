

function join_by {
    local IFS="$1";
    shift;
    echo "$*";
}

if [[ -n ${args[--file]} ]]
then
    joined="($(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/|/g;s/|$//' "${args[--file]}" ))"
elif [[ -n ${args[--regex]} ]]
then
    joined="${args[--regex]}"
else
    joined="($(join_by "|" ${other_args[*]} ))"
fi

if [[ ${args[--exclude]} ]]
then
    operator="!~"
else
    operator="~"
fi

SCRIPT="BEGIN { RS=\">\"; FS=\"\n\" } NR>1 { if (\$1 $operator /^$joined\$/) { print \">\"\$1; for (i=2; i<NF; i++) { print \$i } } }"

execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"