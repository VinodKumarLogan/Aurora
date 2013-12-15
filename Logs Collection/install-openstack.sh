echo "password" | sudo -S apt-get -y install git-all git-core openssh-server openssh-client &&  echo "password" | sudo -S apt-get update && echo "password" | sudo -S apt-get dist-upgrade
mkdir /home/aurora/Documents/OpenStack && mkdir /home/aurora/Documents/OpenStack/cloudgear 
git clone https://github.com/ilearnstack/cloudgear.git /home/aurora/Documents/OpenStack/cloudgear
echo "password" | sudo -S python /home/aurora/Documents/OpenStack/cloudgear/cloudgear.py