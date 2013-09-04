#!/bin/bash
#
# The MIT License (MIT)
#
# Copyright (c) 2013 Christian Babeux <christian.babeux@efficios.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

CURDIR=$(dirname $0)/
TOP=${CURDIR}/..

RED="\033[0;31m"
GREEN="\033[0;32m"
NONE="\033[0m"

ascii="
                                   ';cloddddddol:,.                             
                            .',;:coddooooooooooooddl:,.                         
                      .',:codooooooooooooooooooooooooodl:,.                     
                   .;ldooooooooooooooooooooooooooooooooooodc.                   
                 .coooooooooooooooooooooooooooooooooooooooooo:.                 
               'cdooooooooooooooooooooooooooooooooooooooooooooo,                
             .cdooooooooooooooooooooooooooooooooooooooooooooooodc.              
           .:ooooooooooooooooooooooooooooooooooooooooooooooooooood,             
          'oooooooooooooddddddddddooooooooooooooooooooooooooooooood,            
         ;doooooooodxxkkkkkOkxxddoooooooooooooooooooooooooooooooooox.           
        .dooooooodxxxxxxxxkOxxxxxxdddoooooooooooooooooooooooooooooox:           
   .':lodoooooodxxodxxxxxxkkOkxxxxxdoooooooddoooooooooooooooooooooodd,.....     
.cONMMW0dooooddkkdodxxxxxxkOOkxxxxxxxddddxxdooooooooooooooooooooooooxddkxddx;   
0MMMMMXxooooddxkxoodxxxxxkO000kxxxxxxxxxxxxdddooooooooooooodkOkxdoookXo${RED}:c;.${NONE}cNc  
XMMMMM0oooddxxxkkoddxxxxxxkkOO0kxxxxxxxxxxxxdddddooooooood00kddOKkdxKk${RED};:do';${NONE}Xx. 
.ckXWNkodddxxxxxkxdddxxxxxxxxkOOOOkkxxxxxxxxxxxdddooooooxKk${RED}loo:,${NONE}xWKOXko${RED}o:,${NONE}k0;..
    .;:lokkkkxxxxkxddxxxxdol:;::lxO0OkxxxxxxxxxodxddddddKO${RED}:lodc,${NONE}xNxoxKOxxxOd'...
         ..,;:clxO0Oxxdo;'.......,lddOOkOOOkkkxxoxxxdxddK0c${RED}odlc${NONE}dKkooodkOxc,.....
               .:xOOkxc.............'okkxOxxlxdkdxkxxxdod00kxk0Kxoooooooxc....  
                .,oOkxc..............';.,:,;...,...,codocldOOkdooooool:;,cl'... 
                   .',,'.......''.....,,....'....     .';;cddxxddddoo;.....'.   
                            '..'.',...'......'...          .';codkkxdo;....,,   
                            ....  ...... ......                  .';:oo:;,,.    
                             ...   .....  .....                        ..       
                              .     .....  ....    ${GREEN}.:: LTTng ::.${NONE}
                                     ...                                        
                                      '.                                       
"
distros=("Ubuntu 12.04 LTS (Precise Pangolin)"
         "Ubuntu 12.10 (Quantal Quetzal)"
	 "Ubuntu 13.04 (Raring Ringtail)"
	 "Debian 6.0 (Squeeze)"
	 "Debian 7.0 (Wheezy)"
	 "Red Hat Enterprise Linux 6.4"
	 "CentOS 6.4"
	 "Fedora 18 (Spherical Cow)"
	 "Fedora 19 (Schrödinger's Cat)"
	 "SUSE Linux Enterprise Server 11"
	 "LAWL WINDOWZ")

instances=("t1.micro.32"
           "t1.micro.64"
           "m1.small.32"
           "m1.small.64"
           "m1.medium.32"
           "m1.medium.64"
           "m1.large.64"
           "m1.xlarge.64"
           "m3.xlarge.64"
           "m3.2xlarge.64"
           "c1.medium.32"
           "c1.medium.64"
           "c1.xlarge.64"
           "cc2.8xlarge.64"
           "m2.xlarge.64"
           "m2.2xlarge.64"
           "m2.4xlarge.64"
           "cr1.8xlarge.64"
           "hi1.4xlarge.64"
           "hs1.8xlarge.64")

instances_desc=("1 vCPU | Var. ECU | 0.615 GiB | 32-bit | (FREE)"
                "1 vCPU | Var. ECU | 0.615 GiB | 64-bit | (FREE)"
                "1 vCPU | 1 ECU | 1.7 GiB | 32-bit" 
                "1 vCPU | 1 ECU | 1.7 GiB | 64-bit" 
                "1 vCPU | 2 ECU | 3.75 GiB | 32-bit" 
                "1 vCPU | 2 ECU | 3.75 GiB | 64-bit" 
                "2 vCPU | 4 ECU | 7.5 GiB | 64-bit" 
                "4 vCPU | 8 ECU | 15 GiB | 64-bit" 
                "4 vCPU | 13 ECU | 15 GiB | 64-bit" 
                "8 vCPU | 26 ECU | 30 GiB | 64-bit" 
                "2 vCPU | 5 ECU | 1.7 GiB | 32-bit" 
                "2 vCPU | 5 ECU | 1.7 GiB | 64-bit" 
                "8 vCPU | 20 ECU | 7 GiB | 64-bit" 
                "32 vCPU | 88 ECU | 60.5 GiB | 64-bit" 
                "2 vCPU | 6.5 ECU | 17.1 GiB | 64-bit" 
                "4 vCPU | 13 ECU | 34.2 GiB | 64-bit" 
                "8 vCPU | 26 ECU | 68.4 GiB | 64-bit" 
                "32 vCPU | 88 ECU | 244 GiB | 64-bit" 
                "16 vCPU | 35 ECU | 60.5 GiB | 64-bit" 
                "16 vCPU | 35 ECU | 117 GiB | 64-bit")

distro_options=()
instance_options=()

for ((i = 0; i < ${#distros[@]}; i++))
do
    num=$((i+1))
    distro="${distros[${i}]}"
    status="off"

    distro_options+=("${num}")
    distro_options+=("${distro}")
    distro_options+=("${status}")
done

for ((i = 0; i < ${#instances[@]}; i++))
do
    num=$((i+1))
    instance="${instances[${i}]}"
    instance_desc="${instances_desc[${i}]}"
    status="off"

    instance_options+=("${instance}")
    instance_options+=("${instance_desc}")
    instance_options+=("${status}")
done

distro_dialog=(dialog --backtitle "Vagrant AWS LTTng Setup" \
                      --title "Linux Distribution"          \
                      --radiolist "Select distribution:"    \
                      20 70 ${#distros[@]})

distro_choice=$("${distro_dialog[@]}" "${distro_options[@]}" 2>&1 >/dev/tty)

instance_dialog=(dialog --backtitle "Vagrant AWS LTTng Setup"   \
                        --title "AWS Instance Type"             \
                        --column-separator "|"                  \
                        --radiolist "Select AWS instance type:" \
                        30 80 ${#instances[@]})

instance_choice=$("${instance_dialog[@]}" \
                  "${instance_options[@]}" 2>&1 >/dev/tty)

clear

echo -e "${ascii}"
echo -e "${GREEN}[+]${NONE} Acquiring mole power ... done."

if [ -z "${distro_choice}" ] || [ -z "${instance_choice}" ]; then
    echo -e "${RED}[+]${NONE} Vagrant AWS LTTng setup ... FAIL."
    exit
fi

echo -e "${GREEN}[+]${NONE} Vagrant AWS LTTng setup ... done."

inst=$(echo $instance_choice | cut -d. -f1-2)
bit=$(echo $instance_choice | cut -d. -f3)
arch="amd64"

if [ $bit -eq 32 ]; then
    arch="i386"
fi

echo -e "${GREEN}[+]${NONE} Configuration summary:"
echo -e "    Distro: ${distros[$((${distro_choice}-1))]}"
echo -e "    Instance: ${inst}"
echo -e "    Architecture: ${arch}"

export AWS_ARCH="${arch}"
export AWS_INST="${inst}"

case $distro_choice in
         1)
	     # Ubuntu 12.04 LTS
	     box="boxes/ubuntu/12.04/"
	     cd "${TOP}/$box"
	     vagrant up --provider=aws
             ;;
         2)
	     # Ubuntu 12.10
	     box="boxes/ubuntu/12.10/"
	     cd "${TOP}/$box"
	     vagrant up --provider=aws
             ;;
         3)
	     # Ubuntu 13.04
	     box="boxes/ubuntu/13.04/"
	     cd "${TOP}/$box"
	     vagrant up --provider=aws
             ;;
         *)
             echo "Not implemented."
	     exit
             ;;
esac
echo -e ""
echo -e "${GREEN}[+]${NONE} Box location: ${box}"

echo -e ""
echo -e "${GREEN}-->${NONE} If for some reason the provisioning fails," \
        "you can retry with: "
echo -e "    cd ${box} && vagrant provision"
echo -e ""
echo -e "${GREEN}-->${NONE} To SSH into the AWS instance: "
echo -e "    cd ${box} && vagrant ssh"
echo -e ""
echo -e "${GREEN}-->${NONE} To shutdown the AWS instance: "
echo -e "    cd ${box} && vagrant destroy && cd -"
echo -e ""

