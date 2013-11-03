AURORA				

An opensource technology to collect and analyse openstack logs.

Instructions

1. Setting up the environment

	(i)	  Setup the project on your host system by typing

			git clone https://github.com/VinodKumarLogan/Aurora.git

		  and change the directory to Aurora

	(i)   Download and install VMWare Player 5.0.2 on your linux machine

	(ii)  Download and install VMWare VIX APIs for VMWare Player 5.0.x version

	(iii) Download Ubuntu Server 12.04 LTS iso file

	(iv)  Open VMWare Player (Turn off automatic updates) and create a new virtual machine
		  with the name "Aurora" having a minimum of 2GB RAM and 40GB secondary memory and 
		  choose the Ubuntu Server12.04 LTS iso file and let the installation complete.

	(v)   Close the newly created virtual machine after the installation is complete.

2. Installing GUI for Ubuntu Server 12.04 LTS

	(i)   Give execution permissions to avm file by typing this in your terminal 
			
			sudo chmod +x avm

	(ii)  Run the following in your terminal
			
			./avm --install-gui
