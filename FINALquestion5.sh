iptables -F INPUT
iptables -F FORWARD
iptables -F OUTPUT

iptables -A INPUT -p tcp -s 130.15.0.0/16 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 10.0.0.0 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.0.0 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.0.0 --dport 22 -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -P INPUT DROP

iptables -A OUTPUT -p tcp -s 130.15.0.0/16 -j DROP

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -s 0/0 --sport 1024:65535 -d 202.54.1.20 --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s 130.15.100.100 --sport 3306 -d 0/0 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -s 0.0.0.0 --dport 22 -j DROP

#I can no longer ssh to the vm from the host machine, as the host machine is not in the range 130.15.0.0 - 130.15.255.255
