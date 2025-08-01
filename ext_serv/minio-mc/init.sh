#!/bin/bash
echo -e "\n*****************************************"
echo -e "****** started replication process ******"
echo -e "*****************************************\n"

# HOSTS=`env | grep MC_HOST`
HOSTS='minio1.bdc.home
minio2.bdc.home
minio3.bdc.home
'
# like: minio1 minio2 ...
# INSTANCES=`for host in $HOSTS; do echo $host; done`
REPLICATED_INSTANCES=''
NON_REPLICATED_INSTANCES=''

# waiting for all hosts to start responding
for host in $HOSTS
do
  tmp=`echo $host | cut -d'.' -f 1`
  mc alias set $tmp http://${host}:9000 admin password;
  # until curl -s `echo ${host} | cut -d "=" -f 2` > /dev/null; do sleep 5 &&
  #   echo "host `echo $host | cut -d "@" -f 2` not up yet. retrying"; done
done

# detect the replicated/non-replicated instances
for host in $HOSTS;
do
  instance=`echo $host | cut -d'.' -f 1`
  mc admin replicate info $instance #| grep http > /dev/null
  if [ $? == 0 ];
  then
    REPLICATED_INSTANCES="${REPLICATED_INSTANCES} ${instance}"
  else
    NON_REPLICATED_INSTANCES="${NON_REPLICATED_INSTANCES} ${instance}"
    echo "non-replicated instance found: $instance"
  fi
done

# decide wether there is an instance to be added to replication or not
if [ "x${NON_REPLICATED_INSTANCES}" != "x" ];
then
  mc admin replicate add $REPLICATED_INSTANCES $NON_REPLICATED_INSTANCES
  echo -e "\n************************************************"
  echo -e "****** new instances added to replication ******"
  echo -e "************************************************\n"
  echo "new replicated instances:"
  echo $NON_REPLICATED_INSTANCES
else
  echo -e "\n***************************************"
  echo -e "****** replication already setup ******"
  echo -e "***************************************\n"
fi

echo -e "\n*****************************************"
echo -e "****** Started Bucket creation process ******"
echo -e "*****************************************\n"
mc mb minio1/warehouse/nessie --ignore-existing
mc mb minio1/spark --ignore-existing
mc mb minio1/tmp --ignore-existing
if [ $? == 0 ];
then
  mc anonymous set public minio1/warehouse/nessie
  mc anonymous set public minio1/spark
  mc anonymous set public minio1/tmp
else
  echo "Bucket Creation Failed."
  exit 1
fi
echo -e "\n*****************************************"
echo -e "*** Bucket creation process Completed ***"
echo -e "*****************************************\n"

while true; do
 sleep 1
done