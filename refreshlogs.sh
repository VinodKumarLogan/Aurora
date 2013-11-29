echo "password" | sudo -S cp -R /var/log/keystone /home/aurora/Documents/Aurora/logs/keystone
echo "password" | sudo -S cp -R /var/log/glance /home/aurora/Documents/Aurora/logs/glance
echo "password" | sudo -S cp -R /var/log/nova /home/aurora/Documents/Aurora/logs/nova
echo "password" | sudo -S cp -R /var/log/rabbitmq /home/aurora/Documents/Aurora/logs/rabbitmq
echo "password" | sudo -S chmod -R 664 /home/aurora/Documents/Aurora/logs
echo "password" | sudo -S rm /var/log/keystone/*
echo "password" | sudo -S rm /var/log/glance/* 
echo "password" | sudo -S rm /var/log/nova/*
echo "password" | sudo -S rm /var/log/rabbitmq/*