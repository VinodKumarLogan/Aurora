AURORA				

An opensource technology to collect and analyse openstack logs.

Instructions

1. Setting up the environment

	(i)	   Setup the project on your host system by typing

			git clone https://VinodKumarLogan@bitbucket.org/VinodKumarLogan/aurora.git


and change the directory to Aurora

	(ii)   Download and install VMWare Workstation 9.0.2 on your linux machine

	(iii)  Download Ubuntu Server 12.04 LTS iso file

	(iv)   Open VMWare Player (Turn off automatic updates) and create a new virtual machine
		   with the name "Aurora" having a minimum of 2GB RAM and 40GB secondary memory and 
		   choose the Ubuntu Server12.04 LTS iso file and let the installation complete.Let 
		   the username and password be "aurora".

	(v)   Close the newly created virtual machine after the installation is complete.



2. Running the Virtual Machine

	(i)    Give execution permissions to avm file by typing this in your terminal
		   (only once)
			
			sudo chmod +x avm

	(ii)   Run the following command

			./avm run  


3. Installing GUI for Ubuntu Server 12.04 LTS

	(i)    Run the following in your terminal (when the virtual machine is running)
			
			./avm install-gui


4. Initailizing directories for logging

	(i)    Run the following command (when the virtual machine is running)

			./avm initialize


5. Installing OpenStack
	
	(i)    Run the following command (when the virtual machine is running)

			./avm installos