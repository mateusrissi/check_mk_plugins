Error Counter
====================

    This script works as a plugin for check_mk. It will count the errors (setted by the errorListKeys variable)
    found in the log file in the logFileName variable.

## Install

1. Include the file at the dir ../usr/lib/check_mk_agent/local/
2. Give execution permission chmod +x error_counter.sh


## Return example

###### Output of check plugin

OK - 0 sample_error /// 0 buffer_error /// 0 what_error /// 0 love_error

###### Long output of check plugin

    0 sample_error
    0 buffer_error
    0 what_error
    0 love_error
