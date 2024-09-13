#!/bin/bash
source ./scan.lib

PATH_TO_DIRSEARCH="/home/arthur/arthur/Projects/dirsearch"

while getopts "m:i" OPTION; do
    case $OPTION in 
        m)
            MODE=$OPTARG
            ;;
        i)
            INTERACTIVE=true
            ;;
    esac
done




scan_domain(){
   DOMAIN=$1
   DIRECTORY=${DOMAIN}_recon
   echo -e "\n \t \t ************** \n \t \t creating drectory $DIRECTORY \n \t \t ************** \n "
   mkdir -p $DIRECTORY
    case $MODE in 
       nmap-only)
           nmap_scan
           ;;
       dirsearch-only)
           dirsearch_scan
           ;;
       crt-only)
           crt_scan
           ;;
       *)
           nmap_scan
           dirsearch_scan
           crt_scan
           ;;
   esac
}
report_domain(){
    DOMAIN=$1
   echo -e "\n \t \t ************** \n \t \t Creating recon report for $DOMAIN ...\n \t \t ************** \n"
   TODAY=$(date)
   echo -e "\n \t \t ************** \n \t \t created at $TODAY \n \t \t ************** \n " > $DIRECTORY/report
   if [    -f $DIRECTORY/nmap  ];then
       echo -e "\n \t \t ************** \n \t \t Results for Nmap: \n \t \t ************** \n" >> $DIRECTORY/report
       grep -P -i "([A-Za-z0-9]+(\s+[A-Za-z0-9]+)+)"   $DIRECTORY/nmap >> $DIRECTORY/report
   fi
   if [    -f $DIRECTORY/dirsearch  ];then
       echo -e "\n \t \t ************** \n \t \tResults for Dirsearch: \n \t \t ************** \n" >> $DIRECTORY/report
       jq -r ".results[] | select(.status >= 200 and .status <= 399) | .url " $DIRECTORY/dirsearch >> $DIRECTORY/report
   fi
   if [    -f $DIRECTORY/crt  ];then
       echo -e "\n \t \t ************** \n \t \t Results for crt.sh: \n \t \t ************** \n" >> $DIRECTORY/report
       jq -r ".[] | .name_value " $DIRECTORY/crt  | sort | uniq >>  $DIRECTORY/report
   fi

}

if [ "$INTERACTIVE" ];then
    INPUT="BLANK"
    echo -e "\n \t \t ************** \n hi.I'm milad.Welcome to my Recon Script.Press enter to continue... \n \t \t ************** \n"
    read INPUT
    while [ "$INPUT" != "quit" ]; do 
        echo  -e "\n \t \t ************** \n \t \t Please enter a Domain \n \t \t ************** \n"
        read  INPUT
        if [ "$INPUT" != "quit" ];then
            scan_domain $INPUT
            report_domain $INPUT
        fi
    done
else
    for i in "${@:$OPTIND:$#}";do
        scan_domain "$i"
        report_domain "$i"
    done
fi
