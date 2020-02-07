#!/bin/bash
#
# @author: Sergey Gordin <gordin_sp@bi.group>
# Fulfills a base backup of a PostgreSQL cluster


CUR_DIR=$(dirname "$0")
if [[ ! -f ${CUR_DIR}/pg_common.sh ]]
then
    echo "pg_common.sh not found!"
    exit 1
fi

source "${CUR_DIR}/pg_common.sh"
source "$CONFIG"

if [[ -d ${BASE_BACKUP_DIR}/${LABEL} ]]
then
    echo "${BASE_BACKUP_DIR}/${LABEL} already exists and is not empty!"
    exit 2
fi

pg_basebackup \
    --pgdata=${BASE_BACKUP_DIR}/${LABEL} \
    --format=plain \
    --write-recovery-conf \
    --wal-method=stream \
    --label=${LABEL} \
    --checkpoint=fast \
    --progress \
    --verbose

if [[ $? -gt 0 ]]
then
    rm -rf ${BASE_BACKUP_DIR}/${LABEL}
    echo "pg_basebackup on ${LABEL} failed!"
    exit 3
fi

tar -czf ${BASE_BACKUP_DIR}/${LABEL}.tar.gz ${BASE_BACKUP_DIR}/${LABEL} && rm -rf ${BASE_BACKUP_DIR}/${LABEL}