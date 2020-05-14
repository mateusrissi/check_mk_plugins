#!/bin/bash

# backup-fn.sh - Check-MK plugin for backup validation

# Author: Mateus Rissi
# https://www.linkedin.com/in/mateusrissi/

#   This script will check if the backup generated the files from today,
#   yesterday and the day before yesterday. If none of these exists, then
#   this plugin will alarm.

#   Usage:
#
#   If the variables log_file_dir and log_files are set like this:
#
#   log_file_dir="/opt/test/logs/"
#   log_files="
#       routine_01
#       tracker_level0
#       tracker_level1
#   "
#
#   One example of output is:
#
#   0 backup_fn-routine_01 days_without_backup=0 All ok with the backup
#   0 backup_fn-tracker_level0 days_without_backup=0 All ok with the backup
#   2 backup_fn-tracker_level1 days_without_backup=2 Error with the backup - Backup file is missing for two or more days

# History:
#   v1.0.0 14/05/2020, Mateus:
#       - Start
#       - Funcionalities

# Tested on:
#   bash 4.2.46
# --------------------------------------------------------------------------- #

log_file_dir="/opt/test/logs/"
log_files="
    routine_01
    tracker_level0
    tracker_level1
"

today_date="$(date +%Y%m%d)"
one_day_ago_date="$(date --date="-1 day" +%Y%m%d)"
two_days_ago_date="$(date --date="-2 days" +%Y%m%d)"

status_code="0"
perform_data="days_without_backup=0"
output_txt="All ok with the backup"

for file in $log_files; do
    check_name="backup_fn-${file}"

    check_today=$(ls $log_file_dir | egrep -ioc "${file}_${today_date}[a-zA-Z0-9_]*")
    check_one_day_ago=$(ls $log_file_dir | egrep -ioc "${file}_${one_day_ago_date}[a-zA-Z0-9_]*")
    check_two_days_ago=$(ls $log_file_dir | egrep -ioc "${file}_${two_days_ago_date}[a-zA-Z0-9_]*")

    if [ $check_today -eq 0 ]; then
        status_code="1"
        output_txt="Today's backup file is missing"

        if [ $check_one_day_ago -eq 0 ]; then
            status_code="1"
            perform_data="days_without_backup=1"
            output_txt="Maybe there is a error with the backup"

            if [ $check_two_days_ago -eq 0 ]; then
                status_code="2"
                perform_data="days_without_backup=2"
                output_txt="Error with the backup - Backup file is missing for two or more days"
            fi
        fi
    fi

    echo "${status_code} ${check_name} ${perform_data} ${output_txt}"
done
