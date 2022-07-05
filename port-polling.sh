#!/bin/sh

set -e

PORT=$1
PORT_PS=$(lsof -i :${PORT} | awk 'FNR==2 {print $2}')

SLEEP_COUNTER=0
while [ ! -n "${PORT_PS}" ]
do
 SLEEP_COUNTER=$((SLEEP_COUNTER+2))
 echo "Waiting port ${PORT} to start."
 sleep 2

 PORT_PS=$(lsof -i :${PORT} | awk 'FNR==2 {print $2}')

 if [ "${SLEEP_COUNTER}" == 20  ]
 then
   echo "Wait Time Out !"
   break
 fi

done

echo "Check Complete!"
