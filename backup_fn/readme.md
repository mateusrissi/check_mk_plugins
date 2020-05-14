# Backup_fn

This script works as a plugin for check_mk. This script will check if the backup generated the files from today, yesterday and the day before yesterday. If none of these exists, then this plugin will alarm.

## Install

1. Include the file at the dir ../usr/lib/check_mk_agent/local/
2. Give execution permission chmod +x backup_fn.sh

### Multiple directories

To use this script with multiple log dirs, you can just create a copy and rename it.

## Settings
You should change just the variables "log_file_dir" and "log_files", accordingly your necessities.

For example, to monitor the log files named routine_01, tracker_level0 and tracker_level1 that are at the directory "/opt/test/logs/":

```bash
   log_file_dir="/opt/test/logs/"
   log_files="
       routine_01
       tracker_level0
       tracker_level1
   "
```

## Output example
```
0 backup_fn-routine_01 days_without_backup=0 All ok with the backup
0 backup_fn-tracker_level0 days_without_backup=0 All ok with the backup
2 backup_fn-tracker_level1 days_without_backup=2 Error with the backup - Backup file is missing for two or more days
```
