#!/bin/bash

#Get the input for ssh port no
SSH_PORT="22"

if [[ ! -z "${1}" ]]
then
		SSH_PORT="${1}"
fi

#Get the files name to be copied to the clients
FILE_NAME="kali.pub"
HOME_FOLDER="${HOME}"
ORIGIN_FILE_PATH="${HOME_FOLDER}/.ssh/${FILE_NAME}"
DESTINATION_FILE_NAME="authorized_keys"
DESTINATION_FILE_PATH="/root/.ssh/${DESTINATION_FILE_NAME}"

#Dependancy Files
DOMAIN_NAME="domain_name.txt"
PASSWORD="password.txt"

#Get the input from the file and do the thing
paste -d@ "${DOMAIN_NAME}" "${PASSWORD}" | while IFS="@" read -r domain password
do
cat ${ORIGIN_FILE_PATH} | sshpass -p ${password} ssh -p ${SSH_PORT} -T -o StrictHostKeyChecking=no root@${domain} "cat >> ${DESTINATION_FILE_PATH}"
done