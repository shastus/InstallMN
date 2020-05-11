# Rapids Masternode Setup Guide

# 1. Introduction

This guide is for a single masternode, on a Ubuntu 16.04 64bit server & Ubuntu 18.04 64bit server  (VPS) running headless and will be controlled from the wallet on your local computer (Control wallet). The wallet on the VPS will be referred to as the Remote wallet.
You will need your server details for progressing through this guide.
First the basic requirements:
10.000.000 RPD(may need a fraction of a RPD more to cover for the transaction fee)
A main computer (Your everyday computer) — This will run the control wallet, hold your collateral 10.000.000 RPD and can be not running without affecting the masternode.
Masternode Server (VPS — The computer/node that will be on 24/7)
A unique IP address for your VPS / Remote wallet
(For security reasons, you’re are going to need a different IP for each masternode you plan to host)
The basic reasoning for these requirements is that, you get to keep your RPD in your local wallet and host your masternode remotely, securely..

# 2. Wallet configuration

1) Using the control wallet, enter the debug console (Settings>Debug>console) and type the following command:<p>
<b>`createmasternodekey`</b>
(This will be the masternode’s privkey. We’ll use this later…)
2) Using the control wallet still, enter the following command:<p>
<b>`getaccountaddress`</b> <AnyNameForYourMasternode>
3) Still in the control wallet, send 10.000.000 RPD to the address you generated in step 2 (Be 100% sure that you entered the address correctly. We cannot help you, if you send 10.000.000 RPD to an incorrect address.
4) Still in the control wallet, enter the command into the console:<p>
<b>`getmasternodeoutputs`</b> (This gets the proof of transaction of sending 10.000.000 RPD)
  
 ![1](https://www.rapidsnetwork.io/wp-content/uploads/12.png)
5) Still on the main computer, we need to edit the masternode.conf. You can find the file in the Rapids data directory, by default in Windows: it’ll be `%Appdata%/Rapids` on Linux: `~/Rapids`
  
   ![3](https://www.rapidsnetwork.io/wp-content/uploads/3.png)
         
  Click on the Rapids folder:
    
   ![4](https://www.rapidsnetwork.io/wp-content/uploads/4.png)
   
   Right click on masternode.conf and confirm with (execute with)
   
   ![5](https://www.rapidsnetwork.io/wp-content/uploads/5.png)
  
Once you have the masternode.conf file open in a text editor, add the following line to it:<p>
`<Name of Masternode (Use the name you entered earlier for simplicity)>MN Name <Unique IP address>:20480<The result of Step 1> <Result of Step 4> <The number after the long line in Step 4>`<p>
Example: <p> `MN1 31.14.135.27:20480 892WPpkqbr7sr6Si4fdsfssjjapuFzAXwETCrpPJubnrmU6aKzh c8f4965ea57a68d0e6dd384324dfd28cfbe0c801015b973e7331db8ce018716999 1`<p>
Substitute it with your own values and without the “<>”s

# 3. VPS Remote wallet install

- [www.vultr.com](https://www.vultr.com/?ref=7745997)
- $5 Basic cloud computer package

![7](https://www.rapidsnetwork.io/wp-content/uploads/7.png)

- Choose any location close to you for optimal connectivity to your server
- Ubuntu 16.04.x64 or Ubuntu 18.04.x64

![8](https://www.rapidsnetwork.io/wp-content/uploads/8.png)

- Server (Name anything you want, i.e MN01, MN02 or so)</br>

![9](https://www.rapidsnetwork.io/wp-content/uploads/9.png)

# 3.1 Start an SSH session

Depending upon which operating system you are using. Download the following software:

- [Windows - PUTTY](https://www.putty.org/)
- Mac/Linux - Terminal ( preinstalled ) - You can find terminal by following the steps: Go to finder, then click on utilities, then you'll find terminal there.

Next:

3.1.1 Load the SSH terminal<br />

3.1.2 Copy your IP from the VPS - And for windows Putty simply put in the IP and press enter. For Mac/Linux, use the command: 
```
ssh root@(yourserveripaddress)
```
![10](https://www.rapidsnetwork.io/wp-content/uploads/10.png)


3.1.3 It will connect to the server. Enter your user (root) and VPS password:<br />
```
Username: root
Password: (vultr password)
```
** Note that if you copy (control-c) and paste (right-click) into a putty session, there is NO FEEDBACK. That means you won't see the characters being typed or pasted in. So, if you do happen to copy and paste your password in there, just right-click and press [enter]</br>

# 3.2 Installing the Masternode on the VPS

3.2.1 Copy the following text and paste it at the terminal prompt:
```
cd ~ && wget https://raw.githubusercontent.com/shastus/InstallMN/master/rapidsmninst.sh -O rapidsmninstall.sh && chmod +x rapidsmninstall.sh && ./rapidsmninstall.sh
```

![11](https://www.rapidsnetwork.io/wp-content/uploads/11.png)

3.2.2 Press `ENTER` Then Simply follow the on-screen instructions.


3.3 Check whether the master node is completely started

Now go back to your VPS and type:

`./rapids-cli startmasternode local false`

If everything went well, you should receive the following message:

“Masternode successfully started”

Congratulations! You have successfully started your masternode!

ADDITIONAL NOTES:

1) if the output of

`getmasternodestatus`

is fine, then you are perfectly fine. But have in mind that it can take up to 2 hours for masternode to change status from
`ACTIVE`
to
`ENABLED`
in the masternode list.

2) First masternode reward requires a longer waiting period. It usually takes 3-5 days to receive a first masternode reward.
3) You can close the Control wallet, as it is not needed. Only VPS should be working 24/7.

If you have any troubles or issues, feel free to join Rapids Discord and post your question in #support channel. Again, DO NOT ever receive any help or assistance through private messages, as there are many scammers out there trying to steal your coins, even if they look the same as developers, admins or support staff. Every help ever will be provided through public channels.

# 5. Shutting down a Masternode

5.1) How do I stop running masternode on my VPS and delete masternode from my Rapids Control wallet?

a) In Control wallet in Masternode tab click on Masternode you wish to shutdown and click “Delete”.
b) Restart the wallet.
c) Your 10.000.000 coins are now unlocked and spendable.

5.2) How do I get the 10.000.000 RPD back that I’ve send to my Masternode address at the beginning?

You don’t need to “get it back” as it is already in your wallet.
Being in the different address is not an issue as that’s also your address.

5.3) Can I use this 10.000.000 RPD normally on my wallet then again, and sell it or stake it normally like before?

Yes! If your wallet is unlocked for staking, it will automatically stake these 10.000.000 coins and you can spend them at any time.
