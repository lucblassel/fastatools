
if [[ -z "${args[--each]}" && -z "${args[--every]}" ]]
then
    echo "You must specify either --each or --every"
    echo ""
    fastatools_split_usage
    exit 1
fi

if [[ -n "${args[--each]}" && -n "${args[--every]}" ]]
then
    echo "You can only specify one of --each or --every"
    echo ""
    fastatools_split_usage
    exit 1
fi

SCRIPT=""
P="${args[--prefix]}"

if [[ -n "${args[--each]}" ]]
then
    SCRIPT="BEGIN{ RS=\">\"; FS=\"\n\" } NR>1 { fname=\"$P\"\$1\".fa\"; print \">\"\$1 > fname; for (i=2; i<NF; i++) { print \$i > fname; } }"
fi

if [[ -n "${args[--every]}" ]]
then
    E="${args[--every]}"
    SCRIPT="BEGIN{ RS=\">\"; FS=\"\n\"; counter=0; n_seqs=0 } NR>1 { n_seqs++; if (n_seqs == ($E + 1)) { counter++; n_seqs =1; } fname=\"$P\"counter\".fa\"; print \">\"\$1 > fname; for (i=2; i<NF; i++) { print \$i > fname; } }"
fi

execute_command "awk '$SCRIPT'" "${args[--input]}"