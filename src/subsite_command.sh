
SCRIPTFILE='BEGIN {
    i = 1;
    while ( getline < file ) {
        pos[i] = $0;
        i++;
    }
    # print pos;
    RS=">";
    FS=" ";
    ORS="";
    } NR>1 {
    printf ">%s\n", $1;
    curr = 0;
    for (p in pos) {
        recpos[p] = pos[p];
    }
    for (i=2; i <= NF; i++) {
        if (length(recpos) == 0) {
            break;
        }
        total = curr + length($i);
        c = sprintf("%010d", curr);
        t = sprintf("%010d", total);
        k=1
        for (j=1; j<=length(recpos); j++) {
            p_ = sprintf("%010d", recpos[j]);
            if (p_ > c && p_ <= t) {
                print substr($i, recpos[j] - curr, 1);
                } else {
                new[k] = recpos[j];
                k++;
            }
        }
        curr = total;
        delete recpos;
        for (k in new) {
            recpos[k] = new[k];
        }
        delete new;
    }
    printf("\n")
}'

SCRIPTARGS='BEGIN {
    RS=">";
    FS="\n";
    ORS="";
    n = split(args, pos, " ");
    } NR>1 {
    printf ">%s\n", $1;
    curr = 0;
    for (p in pos) {
        recpos[p] = pos[p];
    }
    for (i=2; i <= NF; i++) {
        if (length(recpos) == 0) {
            break;
        }
        total = curr + length($i);
        c = sprintf("%010d", curr);
        t = sprintf("%010d", total);
        k=1
        for (j=1; j<=length(recpos); j++) {
            p_ = sprintf("%010d", recpos[j]);
            if (p_ > c && p_ <= t) {
                print substr($i, recpos[j] - curr, 1);
                } else {
                new[k] = recpos[j];
                k++;
            }
        }
        curr = total;
        delete recpos;
        for (k in new) {
            recpos[k] = new[k];
        }
        delete new;
    }
    printf("\n")
}'

if [[ -n ${args[--file]} ]]
then
    execute_command "awk -v file=\"${args[--file]}\" '$SCRIPTFILE'" "${args[--input]}" "${args[--output]}"
else
    execute_command "awk -v args=\"${other_args[*]}\" '$SCRIPTARGS'" "${args[--input]}" "${args[--output]}"
fi