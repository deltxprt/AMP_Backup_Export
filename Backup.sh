#!/bin/bash

INSTANCES=("Instance1" "Instance2" "Instance3")

cd /home/amp/.ampdata/instances/

DATE = $(date)

for INSTANCE in "${INSTANCES[@]}"
do
    echo "Processing $INSTANCE"
    if [ -d $INSTANCE ]; then
        echo "Instance $INSTANCE directory already exists" >> /root/cronlogs/backup_$DATE.log
        echo "Starting Backup on $INSTANCE" >> /root/cronlogs/backup_$DATE.log
        rsync -av $INSTANCE/Backups /mnt/backups/$INSTANCE/ >> /root/cronlogs/backup_$DATE.log
        echo "Backup on $INSTANCE complete" >> /root/cronlogs/backup_$DATE.log
    else
        echo "Instance $INSTANCE directory does not exist" >> /root/cronlogs/backup_$DATE.log
        mkdir $INSTANCE >> /root/cronlogs/backup_$DATE.log
        echo "Starting Backup on $INSTANCE" >> /root/cronlogs/backup_$DATE.log
        rsync -av $INSTANCE/Backups /mnt/backups/$INSTANCE/ >> /root/cronlogs/backup_$DATE.log
        echo "Backup on $INSTANCE complete" >> /root/cronlogs/backup_$DATE.log
    fi
done