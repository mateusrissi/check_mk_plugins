#!/bin/bash

# backup-validator.sh - Check-MK plugin for backup validation
# Author: Mateus Rissi

#   This script will subtract the log_file's last modified date from today's
#   date to check if the backup is okay. If the log_file's last modified date
#   is two or more days older than the today's date, it will alarm.
#

# History:
#   v1.0.0 11/05/2020, Mateus:
#       - Start
#       - Funcionalities

# Tested on:
#   bash 4.2.46
# --------------------------------------------------------------------------- #

# variables
log_file_dir="/opt/test"
log_file="test_file.log"

status_code="0"
perform_data="days_without_backup=0"
check_name="backup_validator_${log_file}"
output_txt="All ok with the backup"

# tests
if [ ! -f "${log_file_dir}/${log_file}" ]; then
    status_code="2"
    output_txt="File does not exist"
fi


# functions
date_diff_in_days() {
    local d1=$(date +%s)
    local d2=$(date -r "${log_file_dir}/${log_file}" +%s)
    echo "$((($d1-$d2)/86400))"
}


# exec
datediff="$(date_diff_in_days)"
perform_data="days_without_backup=${datediff}"

if [ $datediff -ge 2 ]; then
    status_code="2"
    output_txt="${datediff} days without backup"
fi

echo "${status_code} ${check_name} ${perform_data} ${output_txt}"
