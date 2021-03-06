
SCRIPTEACH='BEGIN { RS=">"; FS="\n"; OFS="\t"; } NR>1{ linelen=0; for (i=2; i<NF; i++) { linelen=linelen+length($i) } print $1, linelen }'

SCRIPTMAX='BEGIN { RS=">"; FS="\n"; OFS="\t"; max=0; } NR>1{ linelen=0; for (i=2; i<NF; i++) { linelen=linelen+length($i) } if (linelen > max) { max=linelen } } END{ print max }'

SCRIPTMIN='BEGIN { RS=">"; FS="\n"; OFS="\t"; min=-1; } NR>1{ linelen=0; for (i=2; i<NF; i++) { linelen=linelen+length($i) } if (linelen < min || min == -1) { min=linelen } } END{ print min }'

SCRIPTMEAN='BEGIN { RS=">"; FS="\n"; OFS="\t"; total=0; count=0; } NR>1{ linelen=0; for (i=2; i<NF; i++) { total=total+length($i) } count++ } END{ print total/count }'

SCRIPTSUM='BEGIN { RS=">"; FS="\n"; OFS="\t"; } NR>1{ linelen=0; for (i=2; i<NF; i++) { linelen=linelen+length($i) } total += linelen } END {print total}'

FIELD=1
case ${args[--mode]} in
    
    each)
        SCRIPT=$SCRIPTEACH
        FIELD=2
    ;;
    min)
        SCRIPT=$SCRIPTMIN
    ;;
    max)
        SCRIPT=$SCRIPTMAX
    ;;
    mean)
        SCRIPT=$SCRIPTMEAN
    ;;
    sum)
        SCRIPT=$SCRIPTSUM
    ;;
esac

if [[ -n ${args[--readable]} ]]
then
    execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}" "numfmt --to=si --field=$FIELD --format=\"%.2f\""
else
    execute_command "awk '$SCRIPT'" "${args[--input]}" "${args[--output]}"
fi