

SCRIPT='BEGIN { RS=">"; FS="\n" } NR>1{ print $1 }'
execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"