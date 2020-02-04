#!/bin/bash
#
# @author:
# Sourced in pg_*.sh scripts


while [[ $# &gt; 0 ]]
do
    key="$1"

    case $key in
        -c|--config)
            CONFIG="$2"
            shift
            ;;
        *)
            echo "Usage: `basename $0` --config|-c [config_file]"
            exit 1
            ;;
    esac
    shift
done

# /Input parameters
if [[ -z "$CONFIG" ]]
then
    echo "Config file is not set! See the script usage below."
    $0 *
    exit 2
fi

if [[ ! -f "$CONFIG" ]]
then
    echo "$CONFIG not found!"
    exit 3
fi