#!/bin/bash

touch privEsc.txt


function SystemEnum {
echo "" >> privEsc.txt
echo "Service version:" >> privEsc.txt
echo "" >> privEsc.txt
uname -a >> privEsc.txt
echo "" >> privEsc.txt
echo "Architecture:" >> privEsc.txt
echo "" >> privEsc.txt
lscpu >> privEsc.txt
echo "" >> privEsc.txt
echo "Running process:" >> privEsc.txt
echo "" >> privEsc.txt
ps aux >> privEsc.txt
echo "" >> privEsc.txt
echo "SUID:" >> privEsc.txt
echo "" >> privEsc.txt
find / -perm -u=s -type f 2>/dev/null >> privEsc.txt
echo "" >> privEsc.txt
echo "Capabilities" >> privEsc.txt
echo "" >> privEsc.txt
getcap -r / 2>/dev/null >> privEsc.txt
echo "" >> privEsc.txt
echo "Cron" >> privEsc.txt
echo "" >> privEsc.txt
cat /etc/crontab >> privEsc.txt
echo "" >> privEsc.txt
echo "root squash" >> privEsc.txt
cat /etc/exports 2>/dev/null >> privEsc.txt
}


function UserEnum {
echo "" >> privEsc.txt
echo "Who am i?:" >> privEsc.txt
echo "" >> privEsc.txt
whoami >> privEsc.txt
echo "" >> privEsc.txt
echo "id:" >> privEsc.txt
echo "" >> privEsc.txt
id >> privEsc.txt
echo "" >> privEsc.txt
echo "/etc/passwd:" >> privEsc.txt
echo "" >> privEsc.txt
ls -la /etc/passwd >> privEsc.txt
echo "" >> privEsc.txt
echo "/etc/shadow:" >> privEsc.txt
echo "" >> privEsc.txt
ls -la /etc/shadow >> privEsc.txt
echo "" >> privEsc.txt
echo "/etc/group:" >> privEsc.txt
echo "" >> privEsc.txt
cat /etc/group >> privEsc.txt
echo "" >> privEsc.txt
echo "SSH keys:" >> privEsc.txt
find / -name authorized_keys 2>/dev/null >> privEsc.txt
find / -name id_rsa 2>/dev/null >> privEsc.txt
echo "looking for the commands on which the current user has permission:" >> privEsc.txt
find / -perm /4000 2>/dev/null >> privEsc.txt
}

echo "---------------------------------------------------------------------------------------"
echo "PES (privilege escalation scanner) by Awkward_Lancer (https://github.com/AwkwardLancer)"
echo "---------------------------------------------------------------------------------------"

echo "This may take a while..."
echo "The results will be in the privEsc.txt file"

echo "SYSTEM ENUMERATION:" >> privEsc.txt
SystemEnum

echo "USER ENUMERATION:" >> privEsc.txt
UserEnum

echo "The scanning is over, thank you for use PES"
echo "Goodbye!"
