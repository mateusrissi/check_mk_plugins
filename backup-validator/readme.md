# Backup Validator
This script validates the backup execution through the last modified date of the log file. If the log file was not modified for 2 or more days, this plugin will generate an alarm.

## Instalação

1. Include the file at the dir ../usr/lib/check_mk_agent/local/
2. Give execution permission chmod +x backup-validator.sh

## Return example
If status is OK,

    All ok with the backup

otherwise,

    4 days without backup
