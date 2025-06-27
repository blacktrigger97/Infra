#!/bin/bash
echo -e "\n*****************************************"
echo -e "****** started replication process ******"
echo -e "*****************************************\n"

counter=1

# HOSTS=`env | grep MC_HOST`
HOSTS='minio1.bdc.home
minio2.bdc.home
minio3.bdc.home
'
# like: minio1 minio2 ...
# INSTANCES=`for host in $HOSTS; do echo $host | cut -d "@" -f 2 | cut -d ":" -f 1; done`
# REPLICATED_INSTANCES=''
# NON_REPLICATED_INSTANCES=''

# waiting for all hosts to start responding
for host in $HOSTS
do
  mc alias set $host http://${host}:9000 admin minio;
  # until curl -s `echo ${host} | cut -d "=" -f 2` > /dev/null; do sleep 5 &&
  #   echo "host `echo $host | cut -d "@" -f 2` not up yet. retrying"; done
done

# detect the replicated/non-replicated instances
# for instance in $INSTANCES;
# do
#   mc admin replicate info $instance #| grep http > /dev/null
#   if [ $? == 0 ];
#   then
#     REPLICATED_INSTANCES="${REPLICATED_INSTANCES} ${instance}"
#   else
#     NON_REPLICATED_INSTANCES="${NON_REPLICATED_INSTANCES} ${instance}"
#     echo "non-replicated instance found: $instance"
#   fi
# done

# # decide wether there is an instance to be added to replication or not
# if [ "x${NON_REPLICATED_INSTANCES}" != "x" ];
# then
#   mc admin replicate add $REPLICATED_INSTANCES $NON_REPLICATED_INSTANCES
#   echo -e "\n************************************************"
#   echo -e "****** new instances added to replication ******"
#   echo -e "************************************************\n"
#   echo "new replicated instances:"
#   echo $NON_REPLICATED_INSTANCES
# else
#   echo -e "\n***************************************"
#   echo -e "****** replication already setup ******"
#   echo -e "***************************************\n"
# fi

echo -e "\n*****************************************"
echo -e "****** started bucket creation process ******"
echo -e "*****************************************\n"
mc mb minio/dos
if [ $? == 0 ];
then
  mc policy set public minio/dos
  mc admin replicate add minio1 minio2 minio2
else
  echo "Bucket Creation Failed."
  exit 1
echo -e "\n*****************************************"
echo -e "****** Bucket creation process Completed ******"
echo -e "*****************************************\n"

