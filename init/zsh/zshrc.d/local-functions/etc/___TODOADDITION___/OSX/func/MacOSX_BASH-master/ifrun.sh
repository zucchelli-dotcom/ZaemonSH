#!/bin/bash
clear
echo '#######################'
echo '#######################'
echo '# ALPHA CODELAB v1.0  #'
echo '#######################'


#this secction serves the  menu of our tool
echo "------------------------------------------------------------"
echo "Choose the sub routine to run                               |"  
echo "[1] Check active intefaces                                  |"
echo "[2] Check Connectivity                                      |"
echo "[3] Namp Scan ip or range                                   |"
echo "[4] Check Man Pages for topic                               |" 		
echo "[5] Listing Listening ports                                 |"
echo "------------------------------------------------------------"
echo -e "\t\c" 
read type

echo -e "\n\t\t We shall do battle! \n\n\t\t" 
date -u
if [ $type -eq 1 ]; then
    echo "-----------"
    ifconfig -a | grep -B 6 -o 'status: active'
    fi

if [ $type -eq 2 ] ; then
    echo "Input the ip address"
    read ip
    ping_ip="ping $ip"
    $ping_ip
    fi

if [ $type -eq 3 ] ; then
    echo "Input the ip for Nmap "
    echo -e "\t\c" 
    read ip
    recon_3="nmap -sT -Pn  $ip -D 10.0.0.1,10.0.0.2,10.0.0.4"
    $recon_3
    fi


if [ $type -eq 4 ] ; then
    echo "Input to search the Man pages "
    echo -e "\t\c" 
    read ip
    recon_3="man -K $ip "
    $recon_3
    fi

if [ $type -eq 5 ] ; then
    echo -e  "\n\t\tPort Information Panel "
    
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\n\t\t Listing Active Listening Ports "
    lsof -i| grep LISTEN
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\n\t\t Listing TCP "
    lsof -i TCP  | more
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\n\t\t Listing UDP "
    lsof -i UDP  |more
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\n\t\t Listining all "
    ##netstat -s
    netstat -nal| more  
    netstat  -pt | more
   
    
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\t\c"
    echo -e  "\n\t\t Enter the Port Number to snoop \c"
   
    read ip
    recon_3="lsof -i :$ip"
    $recon_3 | more
    
    echo "********************************************************"
    echo "********************************************************"
    echo -e "\t\c"
    echo -e  "\n\t\t Enter the Process Id to check on \c"

    read ip
    recon_3="lsof -p $ip"
    $recon_3 | more
    fi


ifrun
