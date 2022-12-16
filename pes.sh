#!/bin/bash

OUTPUT_FILE='pes.txt'
rm -f $OUTPUT_FILE

function header() {

    echo '|--------------------------------------------------------------------' >> $OUTPUT_FILE
    echo "| $1" >> $OUTPUT_FILE
    echo '|--------------------------------------------------------------------' >> $OUTPUT_FILE
    echo '' >> $OUTPUT_FILE
}

function section() {

    echo '' >> $OUTPUT_FILE
    echo "||-- $1 --||" >> $OUTPUT_FILE
}

function cmd() {

    eval "nice -20 $1 2> /dev/null" >> $OUTPUT_FILE
}

function SystemEnum() {

    section 'Service version'
    cmd 'uname -a'

    section 'Architecture'
    cmd 'lscpu'

    section 'Running process'
    cmd 'ps aux'

    section 'SUID'
    cmd 'find / -perm -u=s -type f'

    section 'Capabilities'
    cmd 'getcap -r /'

    section 'Cron'
    cmd 'cat /etc/crontab'

    section 'Root Squash'
    cmd 'cat /etc/exports'
}

function UserEnum() {

    section 'Who am i?'
    cmd 'whoami'

    section 'id'
    cmd 'id'

    section '/etc/passwd'
    cmd 'ls -la /etc/passwd'

    section '/etc/shadow'
    cmd 'ls -la /etc/shadow'

    section '/etc/group'
    cmd 'cat /etc/group'

    section 'SSH keys'
    cmd 'find / -name authorized_keys'
    cmd 'find / -name id_rsa'

    section 'looking for the commands on which the current user has permission'
    cmd 'find / -perm /4000'
}

echo "---------------------------------------------------------------------------------------"
echo "PES (privilege escalation scanner) by Awkward_Lancer (https://github.com/AwkwardLancer)"
echo "---------------------------------------------------------------------------------------"

echo "This may take a while..."
echo "The results will be in the $OUTPUT_FILE file"

header 'SYSTEM ENUMERATION'
SystemEnum

header 'USER ENUMERATION'
UserEnum

echo "The scanning is over, thank you for use PES"
echo "Goodbye!"
