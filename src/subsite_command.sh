SCRIPTARGS='BEGIN { RS=">"; FS=" "; ORS="\n"; n = split(args, temp, " "); for (x in temp) { pos[temp[x]]=1 } } NR>1 {printf ">%s\n", $1; curr = 0; for (i=2; i <= NF; i++) { for (j=1; j<=length($i); j++) { curr++; if (curr in pos) { printf "%s", substr($i, j, 1) } } } printf("\n") }'
SCRIPTFILE='BEGIN { while ( getline < file ) { pos[$0] = 1 } RS=">"; FS=" "; ORS="\n"; } NR>1 {printf ">%s\n", $1; curr = 0; for (i=2; i <= NF; i++) { for (j=1; j<=length($i); j++) { curr++; if (curr in pos) { printf "%s", substr($i, j, 1) } } } printf("\n") }'

if [[ -n ${args[--file]} ]]
then
    execute_command "awk -v file=\"${args[--file]}\" '$SCRIPTFILE'" "${args[--input]}" "${args[--output]}"
else
    execute_command "awk -v args=\"${other_args[*]}\" '$SCRIPTARGS'" "${args[--input]}" "${args[--output]}"
fi