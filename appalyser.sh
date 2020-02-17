#!/bin/bash

green='\033[1;32m'
end='\033[1;m'
info='\033[1;33m[!]\033[1;m'
run='\033[1;97m[~]\033[1;m'

printf """$green             
  ___,                   _                      
 /   |                  | |                     
|    |    _    _   __,  | |        ,   _   ,_   
|    |  |/ \_|/ \_/  |  |/  |   | / \_|/  /  |  
 \__/\_/|__/ |__/ \_/|_/|__/ \_/|/ \/ |__/   |_/
       /|   /|                 /|               
       \|   \|                 \|  
$end"""

if [ $1 ]
then
    :
else
    printf "Usage: ./appalyser.sh <path to apk file>\n"
    exit
fi

apk=$1
certificate () {
    v=`jarsigner -verify -verbose $apk 2>/dev/null| grep -E "Debug|Unknown|Getnet|Cielo|Rede|Stone"`
    case $v in
    *"Debug"*)
        printf $"\n\t\t$info Warning $info\nFound a Debug signature!\n$green $v $end\n\n" ;;
    *"Unknown"*)
        printf $"\n\t\t$info Warning $info\nFound an Unknown signature!\n$green $v $end\n\n" ;;
    *"Getnet"*)
        printf $"\n\t\t$info Warning $info\nFound a Getnet signature!\n$green $v $end\n\n" ;;
    *"Cielo"*)
        printf $"\n\t\t$info Warning $info\nFound a Cielo signature!\n$green $v $end\n\n" ;;
    *"Rede"*)
        printf $"\n\t\t$info Warning $info\nFound a Rede signature!\n$green $v $end\n\n" ;;
    *"Stone"*)
        printf $"\n\t\t$info Warning $info\nFound a Stone signature!\n$green $v $end\n\n" ;;
    esac
}

manifest () {
    echo "android.permission.INTERNET
android.permission.READ_EXTERNAL_STORAGE
android.permission.WRITE_EXTERNAL_STORAGE
android.permission.BLUETOOTH
android.permission.READ_PHONE_STATE
android.permission.ACCESS_COARSE_LOCATION
android.permission.ACCESS_FINE_LOCATION
android.permission.ACCESS_WIFI_STATE
android.permission.ACCESS_NETWORK_STATE" >> /tmp/apk_temp/allowed

    #save to a temp file
    grep "android.permission" /tmp/apk_temp/AndroidManifest.xml | cut -d "\"" -f 2 >> /tmp/apk_temp/permissions

    #compare with whitelist and creates warning
    #var=`grep -vf /tmp/apk_temp/allowed /tmp/apk_temp/permissions`; dialog --title "Warning!" --msgbox "Por favor, remova as seguintes permissões antes de prosseguir:\n\n${var}" 20 50; 
    var=`grep -vf /tmp/apk_temp/allowed /tmp/apk_temp/permissions`; printf $"\n\t\t$info Warning $info\nPlease, remove the following permissions before proceding:\n$green ${var} $end\n";

    #check external references
    var=`grep -Ei "getnet|rede|gertec|stone|cielo" /tmp/apk_temp/AndroidManifest.xml | cut -d "\"" -f 2`; if [[ $var ]];then printf $"\n\t\t$info Warning $info\nPlease, remove all external references of $green $var $end present in your code before proceding\n";fi
    
    #check backup and debuggable
    var=`grep -Eo 'android:debuggable="true"|android:allowBackup="true"' /tmp/apk_temp/AndroidManifest.xml`;  if [[ $var ]];then printf $"\n\t\t$info Warning $info\nPlease, remove this before proceding:\n$green $var $end \n";fi

    #remove temp dir
    rm -rf /tmp/apk_temp/
}

extract () {
    apktool d $apk -o /tmp/apk_temp -q 2>/dev/null
}

printf $"$run Analysing Certificates\n"
certificate

printf $"$run Decompiling the apk\n"
extract

printf $"$run Analysing Android Manifest\n"
manifest

exit
