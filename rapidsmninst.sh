cd ~
mkdir rapids
cd rapids
echo -ne "${grn} >Progress: ${grn}[##########----]\r"
wget https://github.com/RapidsOfficial/Rapids/releases/download/v3.1/Rapids-v3.1-linux-1604.tar.gz > /dev/null 2>&1
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
cd ~/rapids/
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
cd ~/rapids/
./rapidsd -daemon
