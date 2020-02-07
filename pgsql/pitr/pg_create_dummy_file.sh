#!/bin/bash
#
# @author: Sergey Gordin <gordin_sp@bi.group>
# Creates a dummy file in PG_WAL directory for protection from PITA if no space left


CUR_DIR=$(dirname "$0")
if [[ ! -f ${CUR_DIR}/pg_common.sh ]]
then
    echo "pg_common.sh not found!"
    exit 1
fi

source "${CUR_DIR}/pg_common.sh"
source "$CONFIG"

dd if=/dev/zero of=$PG_XLOG_DIR/DO_NOT_MOVE_THIS_FILE bs=1MB count=300