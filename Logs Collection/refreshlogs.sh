#!/bin/bash -xv
echo "password" | sudo -S rm /var/log/keystone/*
echo "password" | sudo -S rm /var/log/glance/* 
echo "password" | sudo -S rm /var/log/nova/*
echo "password" | sudo -S rm /var/log/rabbitmq/*
echo "password" | sudo -S rm /var/log/apache2/*