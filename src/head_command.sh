 
SCRIPT=" BEGIN { RS=\">\"; FS=\"\n\"; ORS=\"\" } NR>1{ if (FNR - 1 <= ${args[--number]}) { print \">\" \$0 } }"
execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"
