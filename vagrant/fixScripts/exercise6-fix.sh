#!/bin/bash
#add fix to exercise6-fix here
allfsize=0

if [[ -z "$2" ]]; then
    echo Execute the script with at least 2 arguments.
else
    if [[ "`hostname`" == "server1" ]]; then
        dest_server=server2
    else
        dest_server=server1
    fi

    dest_dir="${@: -1}"
    if [[ "${dest_dir: -1}" != "/" ]]; then
        dest_dir=${dest_dir}/
    fi

    if ssh $dest_server "[[ ! -d '$dest_dir' ]]"; then
        echo Destination directory does not exist.
    else
        for var in "${@:1:$#-1}"; do
            if [[ -f "$var" ]]; then
                scp "$var" "$dest_server:$dest_dir"
                if [[ $? == 0 ]]; then
                    fsize=$(wc -c $var | cut -d ' ' -f 1)
                    allfsize=$(echo "$allfsize + $fsize" | bc)
                fi
            fi
        done
    fi
fi

echo $allfsize
