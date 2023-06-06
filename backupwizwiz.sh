#!/bin/bash

# Written By: wizwiz (edited by Real-kia :D )


BOT_TOKEN=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$botToken' | cut -d"'" -f2)
ROOT_USER=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$dbUserName' | cut -d"'" -f2)
ROOT_PASSWORD=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$dbPassword' | cut -d"'" -f2)
BOT_URL=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$botUrl' | cut -d'"' -f2)
BOT_URL2=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$botUrl' | cut -d"'" -f2)

filepath="/var/www/html/wizwizxui-timebot/baseInfo.php"
ADMIN_ID=$(cat $filepath | grep '$admin =' | sed 's/.*= //' | sed 's/;//')

echo "SELECT 1" | mysql -u$ROOT_USER -p$ROOT_PASSWORD 2>/dev/null

sleep 1
ASAS="$"
if [ $? -eq 0 ]; then

touch /var/www/html/wizwizxui-timebot/backup-wizwiz.php

chmod -R 777 /var/www/html/wizwizxui-timebot/backup-wizwiz.php

echo " " >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "<?php" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "include 'settings/jdf.php';" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "function sendDocument(${ASAS}username, ${ASAS}document_path, ${ASAS}caption = null, ${ASAS}parse_mode = 'HTML') {" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "${ASAS}url = 'https://api.telegram.org/bot${BOT_TOKEN}/sendDocument';" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "${ASAS}wizwiz = ['chat_id' => ${ASAS}username,'document' => new CURLFile(${ASAS}document_path),'caption' => ${ASAS}caption,'parse_mode' => ${ASAS}parse_mode];" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "${ASAS}ch = curl_init();" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "curl_setopt_array(${ASAS}ch, [CURLOPT_URL => ${ASAS}url,CURLOPT_RETURNTRANSFER => true,CURLOPT_POSTFIELDS => ${ASAS}wizwiz]);" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "${ASAS}result = curl_exec(${ASAS}ch);curl_close(${ASAS}ch);return ${ASAS}result;}" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "date_default_timezone_set('Asia/Tehran');${ASAS}date = jdate('Y-m-d | H:i:s');" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "sendDocument('${ADMIN_ID}', '/var/www/html/wizwizxui-timebot/wizwiz.sql', '❤️ db '.${ASAS}date);" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo "?>" >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php
echo " " >> /var/www/html/wizwizxui-timebot/backup-wizwiz.php

DB_NAME=wizwiz
backup_path="/var/www/html/wizwizxui-timebot/"
backup_filesql="$backup_path$DB_NAME.sql"
mysqldump --user=$ROOT_USER --password=$ROOT_PASSWORD --host=localhost wizwiz > $backup_filesql

clear

sleep 0.5

url="${BOT_URL}backup-wizwiz.php"
curl $url

url2="${BOT_URL2}backup-wizwiz.php"
curl $url2

clear

sleep 1
            
rm /var/www/html/wizwizxui-timebot/backup-wizwiz.php
rm /var/www/html/wizwizxui-timebot/wizwiz.sql


echo -e "\e[92m The backup settings have been successfully completed.\033[0m\n"

else
    echo "ERROR: MySQL password is incorrect"
fi

