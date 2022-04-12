
SCRIPT='BEGIN { 
    RS=">";
    FS = " ";
} NR>1 { 
    printf ">" $1 "\n";
    for (i=NF; i >= 2; i-- ) { 
        for (j=length($i); j>=1; j--) { 
            char = toupper(substr($i,j,1))
            if (char == "A") {
                printf "T";
            } else if (char == "T" || char == "U") {
                printf "A";
            } else if (char == "C") {
                printf "G";
            } else if (char == "G") {
                printf "C";
            } else if (char == "M") {
                printf "K";
            } else if (char == "K") {
                printf "M";
            } else if (char == "R") {
                printf "Y";
            } else if (char == "Y") {
                printf "R";
            } else if (char == "B") {
                printf "V";
            } else if (char == "D") {
                printf "H";
            } else if (char == "H") {
                printf "D";
            } else if (char == "V") {
                printf "B";
            } else { 
                printf char;
            }
        } 
    }
    printf "\n";
}'

execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"