
if [[ -z ${args[--prefix]} ]]
then
    printer="print \">\" \$1 \"${args[id]}\""
else
    printer="print \">\" \"${args[id]}\" \$1"
fi

SCRIPT="BEGIN { RS=\">\"; FS=\"\n\"; } NR>1 { $printer; for (i=2; i<NF; i++) { print \$i } }"
execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"