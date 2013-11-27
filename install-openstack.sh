echo "hawkeye" | sudo -S apt-get -y update && echo "hackeye" | sudo -S apt-get -y dist-upgrade
echo "hawkeye" | sudo -S apt-get -y install git-all
mkdir /home/vinod/Documents/OpenStack 
git clone https://github.com/ilearnstack/cloudgear.git /home/vinod/Documents/OpenStack/
python /home/vinod/Documents/OpenStack/cloudgear/cloudgear.py