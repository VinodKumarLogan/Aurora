#!/bin/bash -xv
helpData=$(cat <<'END_HEREDOC'

Usage: ./avm.sh <command> <options>

List of commands:-
----------------------------------------------------------------------------------------------------
  Command              Functionality
----------------------------------------------------------------------------------------------------
help                    Lists all available commans=ds and options
start                   Starts the virtual machine named Aurora at /home/username/vmware/Aurora.vmx
stop                    Stop the OpenStack services and the virtual machine
initialize              Copies tis script to the Guest OS and creates directories where the logs  
                        will be stored
installgui              Adds GUI for the Ubuntu Server OS
installos               Installs OpenStack by cloning devstack from github
getlogs <path> <time>   Transfers the logs to the given directory path and Sets a timer for  
                        collecting openstack logs (time is seconds). If timer is not  set then its 
                        set to infinity by default
----------------------------------------------------------------------------------------------------

END_HEREDOC
)
logTimer=0
logPath=""
argCount=$#
if [ $argCount -eq 0 ] ; then
    echo "Too few arguments"
    echo "$helpData"
    exit
fi
if [ $argCount -le 3 ] ; then
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
            vmrun -T ws start /home/vinod/vmware/Aurora/Aurora.vmx
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "stop" ] ; then
        if [ $argCount -eq 1 ] ; then
            if [ $logPath = "" ] ; then
                echo "Path not set, execute getlogs <path> before stopping VM"
            else
                vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/refreshlogs.sh"
                sudo scp -r aurora@172.16.114.128:/home/aurora/Documents/Aurora/logs ${logPath}
                vmrun -T ws stop /home/vinod/vmware/Aurora/Aurora.vmx
            fi
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "initialize" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password createDirectoryInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora"
            vmrun -T ws -gu aurora -gp password createDirectoryInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/logs"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/avm.sh" "/home/aurora/Documents/Aurora/avm.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/install-gui.sh" "/home/aurora/Documents/Aurora/install-gui.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/install-openstack.sh" "/home/aurora/Documents/Aurora/install-openstack.sh"
            vmrun -T ws -gu aurora -gp password CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/refreshlogs.sh" "/home/aurora/Documents/Aurora/refreshlogs.sh"
        else    
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installgui" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/install-openstack.sh"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installos" ] ; then
        if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/install-openstack.sh"
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
        if [ $argCount -eq 2 ] ; then
            logPath=$2
            if [ -d "${logPath}" ] ; then
                vmrun -T ws start /home/vinod/vmware/Aurora/Aurora.vmx                
            else
                echo "Invalid Directory Path"
                echo "$helpData"
            fi
        fi
        if [ $argCount -eq 3 ] ; then
            logPath=$2
            logTimer=$3
            if [ -d "${logPath}" ] ; then
                re='^[0-9]+$'
                if [[ $logTimer =~ $re ]] ; then
                    vmrun -T ws start /home/vinod/vmware/Aurora/Aurora.vmx
                    sleep $((logTimer+0))
                    vmrun -T ws -gu aurora -gp password runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/aurora/Documents/Aurora/refreshlogs.sh"
                    sudo scp -r aurora@172.16.114.128:/home/aurora/Documents/Aurora/logs ${logPath}
                    vmrun -T ws stop /home/vinod/vmware/Aurora/Aurora.vmx
                else
                    echo "Time is not an integer"
                    echo "$helpData"
                fi
            else
                echo "Invalid Directory Path"
                echo "$helpData"
            fi
        fi
        exit
    fi
else
    echo "Invalid arguments"
    echo "$helpData"
fi