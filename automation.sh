#!/bin/bash

create_ec2_snapshot() {
    if [ -z $1 ]; then
             echo "Error: No VOLUME ID provided."
        echo "Usage: FETCH VOLUME ID <volume-id>"
        exit 1
         fi
    aws ec2 create-snapshot --volume-id "$1" --description "Snapshot for volume $1"
    
    if [ $? -ne 0 ]; then
        echo "Failed to create EC2 snapshot for DB instance $1."
        exit 1
    else 
        echo "EC2 snapshot created successfully for VOLUME ID $1. Snapshot ID: $snapshot_identifier"
    fi
}

create_rds_snapshot() {
    if [ -z $1 ]; then
             echo "Error: No DB instance identifier provided."
        echo "Usage: create_rds_snapshot <db-instance-identifier>"
        exit 1
        
         fi
    aws rds create-db-snapshot --db-instance-identifier "$1" --db-snapshot-identifier "snapshot-$1"
  
        if [ $? -ne 0 ]; then
        echo "Failed to create RDS snapshot for DB instance $1."
        exit 1
    else 
        echo "RDS snapshot created successfully for DB instance $1. Snapshot ID: $snapshot_identifier"
    fi
}

main() {
    while true; do
        echo "select backup task:"
        echo "1. create ec2 snapshot"
        echo "2. create rds snapshot" 
        echo "3. exit"
        read -p "enter your choice: " choice

        case $choice in 
            1) read -p "enter volume id: " volume_id
            create_ec2_snapshot $volume_id ;;
            2) read -p "enter db instance id: " db_instance_id
            create_rds_snapshot $db_instance_id ;;
            3) echo "exiting..."
            exit ;;
            esac 
            done
}
main