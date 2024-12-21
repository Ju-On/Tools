## Enumeration 
arp-scan -l

showmount -e <server ip>
mount -t nfs <server ip>:<remote path shown from showmount> <to local mount point>

nmap -sV -A -T4 -p- 
nmap --sC ? 

## Cracking
Zip files: fcrackzip -v -u -D -p /usr/share/wordlists/rockyou.txt <target.zip>

## Post Exploitation
history
pwd
sudo -l
crontab -l

