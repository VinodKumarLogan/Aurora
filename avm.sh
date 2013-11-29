#!/bin/bash
helpData=$(cat <<'END_HEREDOC'

Usage: ./avm.sh <command> <options>

List of commands:-
-------------------------------------------------------------------------------------------------------------
  Command                                       Functionality
-------------------------------------------------------------------------------------------------------------
help                            Lists all available commans=ds and options
start                           Starts the virtual machine named Aurora at /home/username/vmware/Aurora.vmx
stop <path>                     Stop the OpenStack services and transfer the logs to the given path
                                Note: Stops the virtual machine if path is not given
initialize                      Copies tis script to the Guest OS and creates directories where the logs  
                                will be stored
installgui                      Adds GUI for the Ubuntu Server OS
installos                       Installs OpenStack by cloning devstack from github
timedlog <path> <time> <count>  Runs this script for "count" number of times and collects the logs
getlogs <path> <time>           Transfers the logs to the given directory path and Sets a timer for  
                                collecting openstack logs (time is seconds). If timer is not  set then its 
                                set to infinity by default
-------------------------------------------------------------------------------------------------------------

END_HEREDOC
)
logTimer=0
logPath=""
logCount=0
userName=$USER
argCount=$#
if [ $argCount -eq 0 ] ; then
    echo "Too few arguments"
    echo "$helpData"
    exit
fi
if [ $argCount -le 4 ] ; then
    if [ $1 = "help" ] ; then
        if [ $argCount -eq 1 ] ; then
            echo "$helpData"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit
    fi
    if [ $1 = "start" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws start /home/${userName}/vmware/Aurora/Aurora.vmx
            echo "Virtual Machine started successfully"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "stop" ] ; then
        if [ $argCount -le 2 ] ; then
            if [ $argCount -eq 1 ] ; then
                vmrun -T ws stop /home/${userName}/vmware/Aurora/Aurora.vmx
                echo "Virtual Machine stopped successfully"
                exit
            fi
            logPath=$2
            if ![ -d "${logPath}" ] ; then
                echo "Invalid Path"
            else
                vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/refreshlogs.sh"
                mkdir ${logPath}"glance"
                mkdir ${logPath}"keystone"
                mkdir ${logPath}"nova"
                mkdir ${logPath}"rabbitmq"
                mkdir ${logPath}"apache2"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/api.log" "${logPath}/glance/api.log" 
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/registry.log" "${logPath}/glance/registry.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/keystone/keystone.log" "${logPath}/keystone/keystone.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-api.log" "${logPath}/nova/nova-api.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-cert.log" "${logPath}/nova/nova-cert.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-compute.log" "${logPath}/nova/nova-compute.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-conductor.log" "${logPath}/nova/nova-conductor.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-consoleauth.log" "${logPath}/nova/nova-consoleauth.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-manage.log" "${logPath}/nova/nova-manage.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-scheduler.log" "${logPath}/nova/nova-scheduler.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu.log" "${logPath}/rabbitmq/rabbitmq@ubuntu.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/shutdown_log" "${logPath}/rabbitmq/shutdown_log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/startup_log" "${logPath}/rabbitmq/startup_log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu-sasl.log" "${logPath}/rabbitmq/rabbitmq@ubuntu-sasl.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/access.log" "${logPath}/apache2/access.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/error.log" "${logPath}/apache2/error.log"
                vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/other_vhosts_access.log" "${logPath}/apache2/other_vhosts_access.log"
                vmrun -T ws stop /home/${userName}/vmware/Aurora/Aurora.vmx
                echo "Logs collected and Virtual Machine stopped successfully"
            fi
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "initialize" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password createDirectoryInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora"
            vmrun -T ws -gu aurora -gp password createDirectoryInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/${userName}/Documents/aurora/Aurora/avm.sh" "/home/aurora/Documents/Aurora/avm.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/${userName}/Documents/aurora/Aurora/install-gui.sh" "/home/aurora/Documents/Aurora/install-gui.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/${userName}/Documents/aurora/Aurora/install-openstack.sh" "/home/aurora/Documents/Aurora/install-openstack.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/${userName}/Documents/aurora/Aurora/refreshlogs.sh" "/home/aurora/Documents/Aurora/refreshlogs.sh"
            echo "Directories and Files have been initialized"

        else    
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installgui" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/install-openstack.sh"
            echo "GUI Installed"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installos" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/install-openstack.sh"
            echo "OpenStack Installed"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "getlogs" ] ; then
        if [ $argCount -le 2 ] ; then
            echo "Too few arguments"
            echo "$helpData"
        fi
        if [ $argCount -eq 3 ] ; then
            logPath=$2
            logTimer=$3
            if [ -d "${logPath}" ] ; then
                re='^[0-9]+$'
                if [[ $logTimer =~ $re ]] ; then
                    vmrun -T ws start /home/${userName}/vmware/Aurora/Aurora.vmx
                    echo "Virtual Machine started successfully"
                    sleep $((logTimer+0))
                    vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/refreshlogs.sh"
                    mkdir ${logPath}"glance"
                    mkdir ${logPath}"keystone"
                    mkdir ${logPath}"nova"
                    mkdir ${logPath}"rabbitmq"
                    mkdir ${logPath}"apache2"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/api.log" "${logPath}/glance/api.log" 
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/registry.log" "${logPath}/glance/registry.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/keystone/keystone.log" "${logPath}/keystone/keystone.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-api.log" "${logPath}/nova/nova-api.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-cert.log" "${logPath}/nova/nova-cert.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-compute.log" "${logPath}/nova/nova-compute.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-conductor.log" "${logPath}/nova/nova-conductor.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-consoleauth.log" "${logPath}/nova/nova-consoleauth.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-manage.log" "${logPath}/nova/nova-manage.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-scheduler.log" "${logPath}/nova/nova-scheduler.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu.log" "${logPath}/rabbitmq/rabbitmq@ubuntu.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/shutdown_log" "${logPath}/rabbitmq/shutdown_log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/startup_log" "${logPath}/rabbitmq/startup_log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu-sasl.log" "${logPath}/rabbitmq/rabbitmq@ubuntu-sasl.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/access.log" "${logPath}/apache2/access.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/error.log" "${logPath}/apache2/error.log"
                    vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/other_vhosts_access.log" "${logPath}/apache2/other_vhosts_access.log"
                    vmrun -T ws stop /home/${userName}/vmware/Aurora/Aurora.vmx
                    sudo chmod -R 731 /home/${userName}/Documents/aurora/Aurora/logs
                    echo "Logs collected and Virtual Machine stopped successfully"
                else
                    echo "Time is not an integer"
                    echo "$helpData"
                fi
            else
                echo "Invalid Directory Path"
                echo "$helpData"
            fi
        fi
        if [ $argCount -ge 4 ] ; then
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit
    fi
    if [ $1 = "timedlog" ] ; then
        if [ $argCount -eq 4 ] ; then
            logPath=$2
            logTimer=$3
            logCount=$4
            if [ -d "${logPath}" ] ; then
                re='^[0-9]+$'
                if [[ $logTimer =~ $re ]] ; then
                    if [[ $logCount =~ $re ]] ; then
                        i=1
                        while [[ i -le $logCount ]]; do
                            dirName=${logPath}"log "$(date)
                            vmrun -T ws start /home/${userName}/vmware/Aurora/Aurora.vmx
                            echo "Virtual Machine started successfully"
                            sleep $((logTimer+0))
                            vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/refreshlogs.sh"
                            mkdir dirName
                            mkdir dirName"/glance"
                            mkdir dirName"/keystone"
                            mkdir dirName"/nova"
                            mkdir dirName"/rabbitmq"
                            mkdir dirName"/apache2"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/api.log" "${dirName}/glance/api.log" 
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/glance/registry.log" "${dirName}/glance/registry.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/keystone/keystone.log" "${dirName}/keystone/keystone.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-api.log" "${dirName}/nova/nova-api.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-cert.log" "${dirName}/nova/nova-cert.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-compute.log" "${dirName}/nova/nova-compute.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-conductor.log" "${dirName}/nova/nova-conductor.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-consoleauth.log" "${dirName}/nova/nova-consoleauth.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-manage.log" "${dirName}/nova/nova-manage.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/nova/nova-scheduler.log" "${dirName}/nova/nova-scheduler.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu.log" "${dirName}/rabbitmq/rabbitmq@ubuntu.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/shutdown_log" "${dirName}/rabbitmq/shutdown_log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/startup_log" "${dirName}/rabbitmq/startup_log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/rabbitmq/rabbitmq@ubuntu-sasl.log" "${dirName}/rabbitmq/rabbitmq@ubuntu-sasl.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/access.log" "${dirName}/apache2/access.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/error.log" "${dirName}/apache2/error.log"
                            vmrun -T ws -gu aurora -gp password CopyFileFromGuestToHost  "/home/${userName}/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs/apache2/other_vhosts_access.log" "${dirName}/apache2/other_vhosts_access.log"
                            vmrun -T ws stop /home/${userName}/vmware/Aurora/Aurora.vmx
                            sudo chmod -R 731 /home/${userName}/Documents/aurora/Aurora/logs
                            sleep 60
                            echo "Logs collected and Virtual Machine stopped successfully"
                            i=`expr $i + 1`
                        done
                    else
                        echo "Count is not an integer"
                        echo "$helpData"
                    fi
                else
                    echo "Time is not an integer"
                    echo "$helpData"
                fi
            else
                echo "Invalid Directory Path"
                echo "$helpData"
            fi
        else
            echo "Invalid arguments"
            echo "$helpData"
        fi
        exit
    else
            echo "Invalid arguments"
            echo "$helpData"  
    fi
else
    echo "Invalid arguments"
    echo "$helpData"
fi