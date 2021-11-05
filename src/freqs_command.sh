 

SCRIPTEACH='BEGIN { RS=">"; FS = " "; ORS="\n"; OFS = "\t"; } NR>1 { for (i=2; i <= NF; i++ ) { for (j=1; j<=length($i); j++) { counts[substr($i,j,1)]++; generalCount[substr($i,j,1)]++; lengths[$1]++; } } printf("%s:\n", $1); for (char in counts) { print char, counts[char], counts[char] / lengths[$1]; delete counts[char]; } printf("\n") }'

SCRIPTMEAN='BEGIN { RS=">"; FS = " "; ORS="\n"; OFS = "\t"; total=0; } NR>1{ for (i=2; i <= NF; i++ ) { for (j=1; j<=length($i); j++) { generalCount[substr($i,j,1)]++; total++; } } } END { for (char in generalCount) { print char, generalCount[char] / total } }'

if [ ${args[--mean]} ]
then
    SCRIPT=$SCRIPTMEAN
else
    SCRIPT=$SCRIPTEACH
fi

execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"