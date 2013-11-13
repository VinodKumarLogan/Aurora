helpData=$(cat <<'END_HEREDOC'
Usage: ./avm <command> <option>

List of commands:-
------------------------------------------------------------------------------------------------
  Command              Functionality
------------------------------------------------------------------------------------------------
help            Lists all available commans=ds and options
run             Starts the virtual machine named Aurora at /home/username/vmware/Aurora.vmx
initialize      Copies tis script to the Guest OS and creates directories where the logs will 
                be stored
installgui      Adds GUI for the Ubuntu Server OS
installos       Installs OpenStack by cloning devstack from github
timer <time>    Sets a timer for collecting openstack logs (time is seconds). If timer is not 
                set then its set to infinity by default
start           Starts the collection of OpenStack logs by starting its services
stop            Stops all OpenStack services
getlogs <path>  Transfers the logs to the given path
END_HEREDOC
)
helpC=0
run=0
installgui=0
installos=0
timer=0
start=0
stop=0
getlogs=0
argCount=$#
if [ $argCount -eq 0 ] ; then
    echo "Too few arguments"
    echo "$helpData"
    exit
fi
if [ $argCount -le 2 ] ; then
    if [ $1 = "help" ] ; then
        if [ $argCount -eq 1 ] ; then
            echo "$helpData"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit
    fi
    if [ $1 = "run" ] ; then
      if [ $argCount -eq 1 ] ; then
            vmrun -T ws start /home/vinod/vmware/Aurora/Aurora.vmx
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "initialize" ] ; then
      if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu vinod -gp hawkeye createDirectoryInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/Aurora"
            vmrun -T ws -gu vinod -gp hawkeye createDirectoryInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/Aurora/logs"
            vmrun -T ws -gu vinod -gp hawkeye CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/avm.sh" "/home/vinod/Documents/Aurora/avm.sh"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installgui" ] ; then
      if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu vinod -gp hawkeye CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/install-gui.sh" "/home/vinod/Documents/Aurora/install-gui.sh"
            vmrun -T ws -gu vinod -gp hawkeye runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/Aurora/install-openstack.sh"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
    if [ $1 = "installos" ] ; then
      if [ $argCount -eq 1 ] ; then
            vmrun -T ws -gu vinod -gp hawkeye CopyFileFromHostToGuest  "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/aurora/Aurora/install-openstack.sh" "/home/vinod/Documents/Aurora/install-openstack.sh"
            vmrun -T ws -gu vinod -gp hawkeye runProgramInGuest "/home/vinod/vmware/Aurora/Aurora.vmx" "/home/vinod/Documents/Aurora/install-openstack.sh"
        else
            echo "Too many arguments"
            echo "$helpData"
        fi
        exit  
    fi
else
    echo "Invalid arguments"
    echo "$helpData"
fi
