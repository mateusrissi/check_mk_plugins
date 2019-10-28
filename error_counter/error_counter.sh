#!/bin/bash

#--------------------------------------------------------------------------------------------------------#
#config
declare -a errorListValues=(
    'MEDIA: NO SAMPLES AT LOCALE'
    'MEDIA: BLABLA BUFFER'
    'WHAT IS THIS ERROR'
    'WHAT IS LOVE'
)
declare -a errorListKeys=(
    'sample_error'
    'buffer_error'
    'what_error'
    'love_error'
)
checkName="error_counter"
pathLogs="/home/logs_test"
logFileName="generic.log"
pathGrepedFile="${pathLogs}grepedByDate.txt"

dateLog=$(date '+%d-%m-%Y')

statusData=0
outputTxtShort=""
outputTxtLong=""
performData=""

#--------------------------------------------------------------------------------------------------------#
fgrep "$dateLog" ${pathLogs}${logFileName} > ${pathGrepedFile}

contIndex=${#errorListValues[@]}

for ((i=0;i<${contIndex};++i)); do
    errorCount=$(fgrep -c "${errorListValues[i]}" ${pathGrepedFile})
	outputTxtShort+="${errorCount} ${errorListKeys[i]} /// "
    outputTxtLong+="\\n${errorCount} ${errorListKeys[i]}"
    performData+="${errorListKeys[i]}=${errorCount}|"
done

outputTxtShort=${outputTxtShort::${#outputTxtShort}-4}
outputTxt=${outputTxtShort}${outputTxtLong}
performData=${performData::${#performData}-1}

echo "${statusData} ${checkName} ${performData} ${outputTxt}"
