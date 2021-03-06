
if [[ -n "${args[--file]}" ]]
then
    SCRIPT="BEGIN {while (getline < \"'\"${args[--file]}\"'\") { split(\$0, fields, \">\"); renamer[fields[1]] = fields[2]; } close(\"'\"${args[--file]}\"'\"); RS=\">\"; FS=\"\n\"; } NR>1 { print \">\" renamer[\$1]; for (i=2; i<NF; i++) { print \$i } }"
elif [[ -n "${args[--regex]}" ]]
then
    if [[ -z "${args[--substitute]}" ]]
    then
        S=""
    else
        S="${args[--substitute]}"
    fi
    SCRIPT="BEGIN { RS=\">\"; FS=\"\n\"; } NR>1 { gsub(/${args[--regex]}/, \"$S\", \$1); print \">\" \$1; for (i=2; i<NF; i++) { print \$i } }"
else
    echo "You must specify file or regex to rename sequences"
    exit 1;
fi
execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"