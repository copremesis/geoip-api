
Debian logs

Building the dictionaries

Extract ips from auth.log.x.gz file:

`gzcat ../uploads/auth.log.4.gz | grep invalid  | egrep -o '([0-9]+\.){3}[0-9]+' | sort | uniq -c  | sort -nr  | awk '{print $2}' > ips`

extract ips from ufw.log

`grep "UFW BLOCK" ../uploads/ufw.log| egrep -o 'SRC=([0-9]+\.){3}[0-9]+'| sort | uniq -c | sort -nr | awk '{print $2}' | cut -d= -f2 > ips`


followed by: 

`source build-geo-dict.bash ips > generated_dicts/DICTIONARY_NAME.py`


Centos logs



ssh hackers
gzcat ../uploads/secure-apr-2024.gz | grep maximum | egrep -o '([0-9]+\.){3}[0-9]+' | sort | uniq -c | sort -nr | awk '{print $2}' > ips

port scanners
gzcat ../uploads/messages-2024.gz | grep -i block | egrep -o '([0-9]+\.){3}[0-9]+' | sort | uniq -c | sort -nr | awk '{print $2}' > ips

db hackers
gzcat ../uploads/messages-2024.gz | grep -i aborted | egrep -o '([0-9]+\.){3}[0-9]+' | sort | uniq -c | sort -nr | awk '{print $2}' > ips

ip spoofers
gzcat ../uploads/messages-2024.gz | grep -iv aborted |  grep -iv block | egrep -o '([0-9]+\.){3}[0-9]+' | sort | uniq -c | sort -nr | awk '{print $2}' > ips
