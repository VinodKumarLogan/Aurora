echo "hawkeye" | sudo -S apt-get -y update && echo "hackeye" | sudo -S apt-get -y dist-upgrade
echo "hawkeye" | sudo -S apt-get -y install git-all
mkdir /home/vinod/Documents/OpenStack && mkdir /home/vinod/Documents/OpenStack/cloudgear 
git clone https://github.com/ilearnstack/cloudgear.git /home/vinod/Documents/OpenStack/cloudgear
python /home/vinod/Documents/OpenStack/cloudgear/cloudgear.py