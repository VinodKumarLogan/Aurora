AURORA				

An opensource technology to collect and analyse openstack logs.

Instructions

1. Setting up the environment

	(i)	  Setup the project on your host system by typing

			git clone https://VinodKumarLogan@bitbucket.org/VinodKumarLogan/aurora.git

			and change the directory to Aurora

	(ii)   Download and install VMWare Workstation 9.0.2 on your linux machine

	(iii)  Download and install VMWare VIX APIs for VMWare Player 5.0.x version

	(iv) Download Ubuntu Server 12.04 LTS iso file

	(v)  Open VMWare Player (Turn off automatic updates) and create a new virtual machine
		  with the name "Aurora" having a minimum of 2GB RAM and 40GB secondary memory and 
		  choose the Ubuntu Server12.04 LTS iso file and let the installation complete.Let 
		  the username and password be "aurora".

	(vi)   Close the newly created virtual machine after the installation is complete.

2. Installing GUI for Ubuntu Server 12.04 LTS

	(i)   Give execution permissions to avm file by typing this in your terminal 
			
			sudo chmod +x avm

	(ii)  Run the following in your terminal
			
			./avm install-gui

3. Initailizing directories for logging

	(i)   Run the following command

			./avm initialize

4. Installing OpenStack
	
	(i)   Run the following command

			./avm installos