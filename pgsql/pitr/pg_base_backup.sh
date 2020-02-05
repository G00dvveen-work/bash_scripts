#!/bin/bash
#
# @author: 
# Fulfills a base backup of a PostgreSQL cluster


CUR_DIR=$(dirname "$0")
if [[ ! -f ${CUR_DIR}/pg_common.sh ]]
then
    echo "pg_common.sh not found!"
    exit 1
fi

source "${CUR_DIR}/pg_common.sh"
source "$CONFIG"

if [[ -d ${CR_BASE_BACKUP_DIR}/${CR_LABEL} ]]
then
    echo "${CR_BASE_BACKUP_DIR}/${CR_LABEL} already exists and is not empty!"
    exit 2
fi

pg_basebackup \
    --pgdata=${CR_BASE_BACKUP_DIR}/${CR_LABEL} \
    --format=plain \
    --write-recovery-conf \
    --wal-method=stream \
    --label=${CR_LABEL} \
    --checkpoint=fast \
    --progress \
    --verbose

if [[ $? -gt 0 ]]
then
    rm -rf ${CR_BASE_BACKUP_DIR}/${CR_LABEL}
    echo "pg_basebackup on ${CR_LABEL} failed!"
    exit 3
fi

tar -czf ${CR_BASE_BACKUP_DIR}/${CR_LABEL}.tar.gz ${CR_BASE_BACKUP_DIR}/${CR_LABEL} && rm -rf ${CR_BASE_BACKUP_DIR}/${CR_LABEL}