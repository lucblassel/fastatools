

SCRIPT='BEGIN { RS=">"; FS="\n" } NR>1{ print $1 }'
execute_command "grep '>'" "${args[--input]}" "${args[--output]}" "cut -c 2-"