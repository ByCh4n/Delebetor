#!/bin/bash

#    Copyright (C) 2022  ByCh4n
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Contributors:
#   - ByCh4n
#   - lazypwny751

# Define variables:

export status="true" version="1.0.0" banner="yes" COUNTER="1" DO="shell" i="" CLEAN=()
export reset="\033[0m" red="\033[0;31m" green="\033[0;32m" blue="\033[0;34m" purple="\033[0;35m" Bcyan="\033[1;36m" Bwhite="\033[1;37m" Magenta="\u001b[35m" cyan="\u001b[36m" blink="\e[5m"

if [[ "${status}" = "false" ]] ; then
    exit 1
fi

# Define functions:
delebetor:banner() {
    echo -e "${green}
     ______mXXXXXXm______
    *m==================m*
     D  _=  _=  _=  _=  T
     T  E   T   T   T   T
     L  T   T   T   T   T
     E  T   O   R   T   T
     T  B   T   T   T   T
     E  T   T   T   T   T
     T  T   T   T   T   T   
     T  ~=  ~=  ~=  ~=  T
     ~==================~${reset}
"
}
delebetor:web() {
    echo -e "${green}   (
    \
     )
##-------->        ByCh4n
     )
    /
   (${reset}
"
}
case "${DO}" in
    shell)
        export input="" subinput=""
        if [[ "${banner}" = "yes" ]] ; then
            clear
            delebetor:banner
        fi
        echo -e "You can learn commands with the ${green}help${reset} command."
        echo -e "Welcome ${green}${USER}@Delebetor${reset}${red}${reset}${green} [$PWD]${reset}"
        while true ; do
            echo -ne "${green}»»» ${reset}" ; read input
            case "${input}" in
                banner)
                    clear
                    delebetor:banner
                ;;
                install)
                clear
                delebetor:banner
                echo ""
                echo -e "[${blink}+${reset}] Download and installation process started."
                apt update -y &> /dev/null
                echo -e "[${blink}+${reset}] Metasploit"
                apt install metasploit-framework -y &> /dev/null
                echo -e "[${blink}+${reset}] Enum4Linux"
                apt install enum4linux -y &> /dev/null
                echo -e "[${blink}+${reset}] Python & Pip"
                apt install python3 python2 python python-pip python2-pip python3-pip -y &> /dev/null
                echo -e "[${blink}+${reset}] ArpScan"
                apt install arp-scan -y &> /dev/null
                echo -e "[${blink}+${reset}] Hydra"
                apt install hydra -y &> /dev/null
                echo -e "[${blink}+${reset}] Naabu"
                apt install naabu -y &> /dev/null
                echo -e "[${blink}+${reset}] Nuclei"
                apt install nuclei -y &> /dev/null
                echo -e "[${blink}+${reset}] CrackMapExec"
                apt install crackmapexec -y &> /dev/null
                echo -e "[${blink}+${reset}] Mimikatz"
                apt install mimikatz -y &> /dev/null
                echo -e "[${blink}+${reset}] HTTProbe"
                apt install httprobe -y &> /dev/null
                echo -e "[${blink}+${reset}] DNSRecon"
                apt install dnsrecon -y &> /dev/null
                echo -e "[${blink}+${reset}] TheHarvester"
                apt install theharvester -y &> /dev/null
                echo -e "[${blink}+${reset}] Sublist3r"
                apt install sublist3r -y &> /dev/null
                echo -e "[${blink}+${reset}] FTP & SSH & TELNET"
                apt install ftp ssh telnet -y &> /dev/null
                echo -e "[${blink}+${reset}] HashCat"
                apt install hashcat -y &> /dev/null
                echo -e "[${blink}+${reset}] SubFinder"
                apt install subfinder -y &> /dev/null
                echo -e "[${blink}+${reset}] KnockPY"
                apt install knockpy -y &> /dev/null
                echo -e "[${blink}+${reset}] GoLang"
                apt install golang -y &> /dev/null
                echo -e "[${blink}+${reset}] BloodHound"
                apt install bloodhound -y &> /dev/null
                echo -e "[${blink}+${reset}] Neo4J"
                apt install neo4j -y &> /dev/null
                echo -e "[${blink}+${reset}] Impacket -> /opt"
                git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket &> /dev/null
                echo -e "[${blink}+${reset}] Kerbrute -> /opt"
                git clone https://github.com/ropnop/kerbrute /opt/kerbrute &> /dev/null
                cd /opt/kerbrute &> /dev/null
                go get github.com/ropnop/kerbrute &> /dev/null
                make all &> /dev/null
                echo -e "[${blink}+${reset}] SmbClient & SmbMap"
                apt install smbmap -y &> /dev/null
                apt install smbclient -y &> /dev/null
                echo -e "[${blink}+${reset}] LdapDomainDump -> /opt"
                git clone https://github.com/dirkjanm/ldapdomaindump /opt/ldapdomaindump &> /dev/null
                cd /opt/ldapdomaindump &> /dev/null
                pip3 install -r requirements.txt &> /dev/null
                python3 setup.py install &> /dev/null
                echo -e "[${blink}+${reset}] WindapSearch -> /opt"
                git clone https://github.com/ropnop/windapsearch /opt/windapsearch &> /dev/null
                cd /opt/windapsearch &> /dev/null
                pip3 install -r requirements.txt &> /dev/null
                echo -e "[${blink}+${reset}] BloodHound.py -> /opt"
                git clone https://github.com/fox-it/BloodHound.py /opt/BloodHound &> /dev/null
                cd /opt/BloodHound &> /dev/null
                python3 setup.py install &> /dev/null
                echo -e "[${blink}+${reset}] Nessus -> /opt"
                cd /opt &> /dev/null
                wget -O nessus.deb "https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/16870/download?i_agree_to_tenable_license_agreement=true" &> /dev/null
                dpkg -i nessus.deb &> /dev/null
                systemctl stop nessusd.service &> /dev/null
                cd /opt/nessus/sbin &> /dev/null
                ./nessuscli adduser
                systemctl start nessusd.service &> /dev/null
                echo -e "[${blink}+${reset}] The download and installation process is complete."
                ;;
                delete)
                clear
                delebetor:banner
                function yesorno {
                read -p "Do you really want to delete it? [Y/N]" CONT
                echo ""
                if [[ "$CONT" =~ ^(y|Y|yes|YES) ]]; then
                echo -e "[${blink}+${reset}] Delete process started."
                echo "--------------------------------"
                rm -rf /opt/* &> /dev/null
                echo -e "-> ${green}OK${reset}"
                rm -rf /var/log/* &> /dev/null
                echo -e " -> ${green}OK${reset}"
                rm -rf ~/.bash_history &> /dev/null
                echo -e "  -> ${green}OK${reset}"
                rm -rf /root/.bash_history &> /dev/null
                echo -e "   -> ${green}OK${reset}"
                rm -rf /root/.zsh_history &> /dev/null
                echo -e "    -> ${green}OK${reset}"
                rm -rf ~/.zsh_history &> /dev/null
                echo -e "     -> ${green}OK${reset}"
                history -c &> /dev/null
                echo -e "      -> ${green}OK${reset}"
                history delete &> /dev/null
                echo -e "       -> ${green}OK${reset}"
                history clear &> /dev/null
                echo -e "        -> ${green}OK${reset}"
                echo "--------------------------------"
                echo -e "[${blink}+${reset}] Delete process is complete."                
                else
                echo "Tamam.";
                fi
                }
                yesorno
                ;;
                web)
                clear
                delebetor:web
                apt install nuclei -y &> /dev/null
                cd /opt &> /dev/null
                curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.3.0-debian9_amd64.deb' \
  --output 'Nessus-10.3.0-debian9_amd64.deb' &> /dev/null
                dpkg -i Nessus-10.3.0-debian9_amd64.deb &> /dev/null
                systemctl start nessusd.service &> /dev/null
                systemctl status nessusd.service
                ;;
                version)
                    echo -e "Developed by ${green}ByCh4n${reset} ${Bwhite}${0##*/}${reset}, version ${Bcyan}${version}${reset}."
                ;;
                help)
                    echo -e "${Bwhite}banner${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}banner${reset} ${Bwhite}]${reset}
${Bwhite}help${reset}    ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}help${reset} ${Bwhite}]${reset}
${Bwhite}install${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}install${reset} ${Bwhite}]${reset}
${Bwhite}web${reset}     ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}web${reset} ${Bwhite}]${reset}
${Bwhite}delete ${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}delete${reset} ${Bwhite}]${reset}
${Bwhite}version${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}version${reset} ${Bwhite}]${reset}
${Bwhite}clear${reset}   ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}clear${reset} ${Bwhite}]${reset}
${Bwhite}exit${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}exit${reset},${Bcyan} e ${reset},${Bcyan} x ${reset},${Bcyan} q ${reset} ${Bwhite}]${reset}"
                ;;
                exit|e|x|q)
                    exit 0
                ;;
                clear)
                    clear
                ;;
                *)
                    echo -e "${Bwhite}${0##*/}${reset}: ${red}case${reset}: '${Bcyan}${input}${reset}' pattern not found."
                ;;
            esac
        done
    ;;
    *)
        echo -e "${Bwhite}${0##*/}${reset}: there is ${red}no${reset} job like called by '${Bcyan}${DO}${reset}'."
        export status="false"
    ;;
esac
