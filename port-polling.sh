#!/bin/sh

set -e

PORT=$1
PORT_PS=$(lsof -i :${PORT} | awk 'FNR==2 {print $2}')

SLEEP_COUNTER=0
while [ ! -n "${PORT_PS}" ]
do
 SLEEP_COUNTER=$((SLEEP_COUNTER+3))
 echo "Waiting port ${PORT} to start."
 sleep 3

 PORT_PS=$(lsof -i :${PORT} | awk 'FNR==2 {print $2}')

 if [ "${SLEEP_COUNTER}" == 30  ]
 then
   echo "Wait time out in ${SLEEP_COUNTER} second"
   break
 fi

done

echo "Check Complete!"
