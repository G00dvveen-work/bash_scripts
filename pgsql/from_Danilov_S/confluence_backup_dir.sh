#!/bin/bash
 
TIME=`date +%d-%m-%Y`
FILENAME=backup-confluence-$TIME.tar.gz
SRCDIR1=/var/atlassian/jira
SRCDIR2=/opt/jira/
DESDIR=/backup/confluence/
 
tar -cpzf $DESDIR/$FILENAME $SRCDIR1 $SRCDIR2
find $DESDIR/backup-* -mtime +7 -delete
