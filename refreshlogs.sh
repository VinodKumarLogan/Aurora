echo "password" | sudo -S cp -R /var/log/keystone /home/aurora/Documents/Aurora/logs/keystone
echo "password" | sudo -S cp -R /var/log/glance /home/aurora/Documents/Aurora/logs/glance
echo "password" | sudo -S cp -R /var/log/nova /home/aurora/Documents/Aurora/logs/nova
echo "password" | sudo -S cp -R /var/log/rabbitmq /home/aurora/Documents/Aurora/logs/rabbitmq
echo "password" | sudo -S chmod -R 755 /home/aurora/Documents/Aurora/logs
echo "password" | sudo -S find /var/log/keystone -type f -exec sh -c '> "{}"' \;
echo "password" | sudo -S find /var/log/glance -type f -exec sh -c '> "{}"' \;
echo "password" | sudo -S find /var/log/nova -type f -exec sh -c '> "{}"' \;
echo "password" | sudo -S find /var/log/rabbitmq -type f -exec sh -c '> "{}"' \;