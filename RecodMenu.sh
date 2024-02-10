#!/bin/bash
# COLOR VALIDATION
clear
y='\033[1;33m' #yellow
BGX="\033[42m"
CYAN="\033[96m"
z="\033[95;1m"
f="\033[1;97;41m"
G="\033[92m"
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[0;34m"
green='\033[0;32m'
grenbo="\e[92;1m"
purple="\033[1;95m"
YELL='\033[0;33m'

# underline
UPU='\033[5;35m'
UCY='\033[5;36m'
UWH='\033[5;37m'
#INTALLER-UDP
UDPX="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
IPVPS=$(curl -s ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
RAM=$(free -m | awk 'NR==2 {print $2}')
USAGERAM=$(free -m | awk 'NR==2 {print $3}')
MEMOFREE=$(printf '%-1s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
MODEL=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
DATEVPS=$(date +'%d-%m-%Y')
TIMEZONE=$(printf '%(%H-%M-%S)T')
SERONLINE=$(uptime -p | cut -d " " -f 2-10000)
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
echo ""
izinsc="https://raw.githubusercontent.com/RidwanzAnphelibelll/AutoScript/main/Register"
# USERNAME
rm -f /usr/bin/user
username=$(curl ${izinsc} | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
# validity
rm -f /usr/bin/e
valid=$(curl ${izinsc} | grep $MYIP | awk '{print $3}')
echo "$valid" >/usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
# VPS Information
DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

# Status Expired Or Active
Info="(${green}Active${NC})"
Error="(${RED}Expired${NC})"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl ${izinsc} | grep $MYIP | awk '{print $3}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${coREDiilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
# IPVPS=$(curl -s ipinfo.io/ip )
IPVPS=$(curl -sS ipv4.icanhazip.com) 
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#Status
clear
colorize_status() {
    if [[ $1 == "ON" ]]; then
        echo -e "\e[32m$1\e[0m" 
    else
        echo -e "\e[31m$1\e[0m"
    fi
}
# STATUS SERVICE SSH
if [[ $ssh_service == "running" ]]; then 
   status_ssh=$(colorize_status "ON")
else
   status_ssh=$(colorize_status "OFF")
fi

# SSH Websocket Proxy
ssh_ws=$(systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro=$(colorize_status "ON")
else
    status_ws_epro=$(colorize_status "OFF")
fi

# STATUS SERVICE HAPROXY
if [[ $haproxy_service == "running" ]]; then 
   status_haproxy=$(colorize_status "ON")
else
   status_haproxy=$(colorize_status "OFF")
fi

# STATUS SERVICE XRAY
if [[ $xray_service == "running" ]]; then 
   status_xray=$(colorize_status "ON")
else
   status_xray=$(colorize_status "OFF")
fi

# STATUS SERVICE NGINX
if [[ $nginx_service == "running" ]]; then 
   status_nginx=$(colorize_status "ON")
else
   status_nginx=$(colorize_status "OFF")
fi

# STATUS SERVICE Dropbear
if [[ $dropbear_service == "running" ]]; then 
   status_dropbear=$(colorize_status "ON")
else
   status_dropbear=$(colorize_status "OFF")
fi
# //
# // Log account
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let trb=$trx/2
ssx=$(grep -c -E "^#ss# " "/etc/xray/config.json")
let ssa=$ssx/2
# //
r="\033[1;31m"  # merah
a="ACCOUNT PREMIUM" 
BWC='\033[1;36'
cyan='\033[96m'
bwhite='\033[1;37m'
clear
echo -e " "                                                           
echo -e " ${NC} ╭════════════════════════════════════════════════════════════════╮"
echo -e " ${NC} │${bwhite}\033[41m               AUTOSCRIPT PPREMIUM BY RIDWANZ SAPUTRA            ${NC}│"
echo -e " ${NC} ╰════════════════════════════════════════════════════════════════╯"
echo -e " ${NC} ╭════════════════════════════════════════════════════════════════╮"
echo -e " ${NC} │$BRED ● ${bblue}SYSTEM OS ${YELL}  : ${NC}$MODEL${NC}"
echo -e " ${NC} │$BRED ● ${bblue}SERVER RAM ${YELL} : ${NC}$tram / $uram MB $NC"
echo -e " ${NC} │$BRED ● ${bblue}DATE ${YELL}       : ${NC}$DATEVPS${NC}"
echo -e " ${NC} │$BRED ● ${bblue}TIME ${YELL}       : ${NC}$TIMEZONE${NC}"
echo -e " ${NC} │$BRED ● ${bblue}UPTIME ${YELL}     : ${NC}$SERONLINE${NC}"
echo -e " ${NC} │$BRED ● ${bblue}IP VPS ${YELL}     : ${BRED}$IPVPS${NC}"
echo -e " ${NC} │$BRED ● ${bblue}DOMAIN ${YELL}     : ${green}$domain${NC}"
echo -e " ${NC} ╰════════════════════════════════════════════════════════════════╯$NC"
echo -e " ${NC}                     >>> INFORMATIONS ACCOUNT <<<"
echo -e " ${NC}         ══════════════════════════════════════════════════${NC}" | lolcat
echo -e "               ${BRED} SSH/OPENVPN/UDP  $YELL=$NC $ssh1  ${YELL}$a"
echo -e "               ${BRED} VMESS/WS/GRPC    $YELL=$NC $vma  ${YELL}$a"
echo -e "               ${BRED} VLESS/WS/GRPC    $YELL=$NC $vla  ${YELL}$a"
echo -e "               ${BRED} TROJAN/WS/GRPC   $YELL=$NC $trb  ${YELL}$a"
echo -e "               ${BRED} SHADOW/WS/GRPC   $YELL=$NC $ssa  ${YELL}$a"
echo -e " ${NC}         ══════════════════════════════════════════════════${NC}" | lolcat
echo -e " ${NC}                  >>> STATUS SERVICE ACCOUNT <<<"
echo -e "╭════════════════════╮╭════════════════════╮╭════════════════════╮"
echo -e "│ SSH     : $status_ssh           NGINX : $status_nginx      HAPROXY  :  $status_haproxy        │"
echo -e "│ WS-ePro : $status_ws_epro       XRAY  : $status_xray        DROPBEAR : $status_dropbear      │"
echo -e "╰════════════════════╯╰════════════════════╯╰════════════════════╯"
echo -e " ${NC} ╭════════════════════════════════════════════════════════════════╮"
echo -e " ${NC} │$NC [${BRED}01$NC]${YELL} SSH MENU     $NC│ [${BRED}07$NC]${YELL} BCKP/RSTR     $NC│ [${BRED}13$NC]${YELL} BACKUP BOT       ${NC}│"
echo -e " ${NC} │$NC [${BRED}02$NC]${YELL} VMESS MENU   $NC│ [${BRED}08$NC]${YELL} GOTOP X RAM   $NC│ [${BRED}14$NC]${YELL} CHANGE DOMAIN    ${NC}│"    
echo -e " ${NC} │$NC [${BRED}03$NC]${YELL} VLESS MENU   $NC│ [${BRED}09$NC]${YELL} RESTART ALL   $NC│ [${BRED}15$NC]${YELL} FIX CRT DOMAIN   ${NC}│"   
echo -e " ${NC} │$NC [${BRED}04$NC]${YELL} TROJAN MENU  $NC│ [${BRED}10$NC]${YELL} TELE BOT      $NC│ [${BRED}16$NC]${YELL} CLEAR CHACHE     ${NC}│" 
echo -e " ${NC} │$NC [${BRED}05$NC]${YELL} SS - LIBEV   $NC│ [${BRED}11$NC]${YELL} UPDATE SCRIPT $NC│ [${BRED}17$NC]${YELL} CREATE SLOW DNS  ${NC}│"
echo -e " ${NC} │$NC [${BRED}06$NC]${YELL} TRIAL ACC    $NC│ [${BRED}12$NC]${YELL} RUNNING       $NC│ [${BRED}18$NC]${YELL} SPEEDTEST        ${NC}│"
echo -e " ${NC} │$NC [${BRED}19$NC]${YELL} INSTALL UDP                                               ${NC}│"
echo -e " ${NC} │$NC [${BRED}20$NC]${YELL} CHANGE BANNER                                             ${NC}│"
echo -e " ${NC} ╰════════════════════════════════════════════════════════════════╯"
echo -e " ${NC} ╭════════════════════════════════════════════════════════════════╮"
echo -e " ${NC} │$bblue Script Versions $YELL=$NC V6.1 (Last Updates)"
echo -e " ${NC} │$bblue Script Status   $YELL=$NC $sts"
echo -e " ${NC} │$bblue Username        $YELL=$green $username "
echo -e " ${NC} │$bblue Expired Script  $YELL=$NC $exp ${NC}/$green $certifacate ${NC}Days"
echo -e " ${NC} ╰════════════════════════════════════════════════════════════════╯"
echo -e " "
read -p "  Options [ 1 / 20 ] ❱❱❱ " opt
echo -e ""

case $opt in
1 | 01)
clear
m-sshws
;;
2 | 02)
clear
m-vmess
;;
3 | 03)
clear
m-vless
;;
4 | 04)
clear
m-trojan
;;
5 | 05)
clear
m-ssws
;;
6 | 06)
clear
m-trial
;;
7 | 07)
clear
menu-backup
;;
8 | 08)
clear
gotop
;;
9 | 09)
clear
restart
;;
10)
clear
m-bot
;;
11)
clear
wget -q https://raw.githubusercontent.com/RidwanzAnphelibelll/AutoScript/main/update.sh
chmod +x update.sh
./update.sh
;;
12)
clear
run
;;
13)
clear
mbot-backup
;;
14)
clear
addhost
;;
15) 
clear
fixcert
;;
16)
clear
clearcache
;;
17)
clear;
sd
;;
18)
clear ;
speedtest
;;
19) 
clear ;
wget --load-cookies /tmp/cookies.txt ${UDPX} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp
;;
20) 
clear;
nano /etc/kyt.txt
;;

0 | 00)
exit
;;
x)
menu
;;
*) clear ;
menu
;;
esac
