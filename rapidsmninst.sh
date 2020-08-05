# cd ~ && wget https://raw.githubusercontent.com/shastus/InstallMN/master/rapidsmninst.sh -O rapidsmninstall.sh && chmod +x rapidsmninstall.sh && ./rapidsmninstall.sh
#!/bin/bash
Cur_Wallet=""
red='\033[1;31m'
grn='\033[1;31m'
grn='\033[1;32m'
yel='\033[1;33m'
blu='\033[1;36m'
grn='\033[1;33m'
grn='\033[1;36m'
clr='\033[0m'
echo
echo -ne "${blu}Installing Requisites${NC}"
sudo apt-get update  > /dev/null 2>&1
sudo apt-get install build-essential software-properties-common -y  > /dev/null 2>&1
sudo add-apt-repository ppa:bitcoin/bitcoin -y > /dev/null 2>&1
echo -ne "${grn} >Progress: ${blu}[#####---------]\r"

sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade   
sudo apt-get install libtool bsdmainutils autotools-dev autoconf pkg-config automake python3 libssl-dev libgmp-dev libevent-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libzmq3-dev libminiupnpc-dev -y
sudo apt-get install gcc-4.9
sudo apt-get upgrade libstdc++6
echo -ne "${grn} >Progress: ${blu}[#######-------]\r"
CHKSWAP=`free | grep Swap | awk '{print $2}'`
if [ "CHKSWAP" == "0" ]
then
  fallocate -l 3G /swapfile      > /dev/null 2>&1
  chmod 600 /swapfile      > /dev/null 2>&1
  mkswap /swapfile  > /dev/null 2>&1
  swapon /swapfile  > /dev/null 2>&1
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
  echo "Swap already exists, not creating..."
fi
cd ~
mkdir rapids
cd rapids
echo -ne "${grn} >Progress: ${grn}[##########----]\r"
wget https://github.com/RapidsOfficial/Rapids/releases/download/v3.1/Rapids-v3.1-daemon-ubuntu1804.tar.gz > /dev/null 2>&1
tar zxvf Rapids-v3.1-daemon-ubuntu1804.tar.gz -C ~/rapids  > /dev/null 2>&1
echo -ne "${grn} >Progress: ${grn}[##############]${NC}"
cd ~/rapids
./rapidsd -daemon
echo -e "${grn}Please enter the masternode private key generated in the debug console via ${yel}createmasternodekey ${NC}[0/1]"
read -e -p " : " MN_KEY
echo -e "${grn}Please enter a RPC Username  ${yel}Long and random${NC}[0/1]"
read -e -p " : " RPC_USER
echo -e "${grn}Please enter RPC Password ${yel}Longer and Randomer${NC}[0/1]"
read -e -p " : " PASSWORD
echo -e "${yel}Please enter the masternode IP Address with Port${NC}[0/1]"
read -e -p " : " IPADDRESSPORT
echo -e "${yel}Please enter the masternode IP Address${NC}[0/1]"
read -e -p " : " IPADDRESS
cd ~/rapids/Rapids-v3.1-daemon-ubuntu1804
./rapids-cli stop
    echo -ne "${BLUE}Writing the rapids.conf file${NC}"
cat <<EOF > ~/.rapids/rapids.conf
rpcuser=$RPC_USER
rpcpassword=$PASSWORD
rpcallowip=127.0.0.1
server=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
externalip=$IPADDRESS
masternodeaddr=$IPADDRESSPORT
masternodeprivkey=$MN_KEY
EOF
echo -ne "${grn}Starting Wallet${NC}"
cd ~/rapids/Rapids-v3.1-daemon-ubuntu1804
./rapidsd -daemon
