SCRIPT="BEGIN { RS=\">\"; FS=\"\n\"; } NR>1 { tot = \"\"; for (i=2; i<NF; i++) { tot = tot  \$i } print \">\" \$1; while (length(tot) >= ${args[--width]}) { print substr(tot, 1, ${args[--width]}); tot = substr(tot, ${args[--width]} + 1); } print tot }"

execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"
