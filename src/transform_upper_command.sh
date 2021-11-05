

SCRIPT='{ if ($1 ~ /^>.*$/){ print $0 } else { print toupper($0) } }'
execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"
