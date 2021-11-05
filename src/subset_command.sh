 

join_indices()
{
   local p="arr[$1]=$1"
   shift
   for i in "$@"
   do
      p="$p; arr[$i]=$i"
   done
   echo "$p"
}

init=""
if [[ -n "${other_args[*]}" ]]; then
    init=$( join_indices "${other_args[@]}")
    conditional="(NR - 1 in arr)"
else
    if [[ ${args[--start]} -eq 1 && ${args[--end]} -eq 9223372036854775807 ]]; then
        echo "
        You must indicate at least some indices you want to select.
        Either as positional arguments or specify --start and/or --end."
        exit 1
    else
        conditional="(NR - 1 >= ${args[--start]} && NR -1 <= ${args[--end]})"
    fi
fi

pre=""
if [[ -n ${args[--exclude]} ]]
then
    pre="!"
fi

SCRIPT="BEGIN { RS=\">\"; FS=\"\n\"; $init } NR>1 { if ($pre$conditional) { print \">\" \$1; for (i=2; i<NF; i++) { print \$i } } }"

execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"
