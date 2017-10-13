#!/bin/bash
#Written by Muhammad Najmi Ahmad Zabidi <najmi.zabidi@gmail.com>, Oct 2017

PROGNAME=`basename $0`

usage() {
    echo "" 
    echo "Usage:"
    echo " $PROGNAME -s duit -t tahun -d dividen " 
    echo " Contoh  - $PROGNAME -s 1000 -t 3 -d 5"
    echo ""
    exit 3
}

while getopts ":s:t:d:" opt; do 
  case $opt in 
    s)
      simpanan_tahunan=$OPTARG
      ;;      
    t)
      TAHUN=$OPTARG 
     ;;      
    d)
      dividen_tahunan=$OPTARG
     ;;
    h)
      usage
     ;;
    :)
      echo "Opsyen -$OPTARG perlukan argumen." >&2
      echo ""
      exit 3  
    ;;      
  esac
done


if [[ -z "$simpanan_tahunan" || -z "$TAHUN" || -z "$dividen_tahunan" ]] ; then
        echo "Sila masukkan input yang diperlukan :)"
        echo ""
        usage
        exit 3

elif [ "$#" -eq 0 ]; then
        usage
        exit 3

fi

DIVIDEN=$(echo "scale=2;($dividen_tahunan/100)"|bc)

kira() {

for ((tempoh=1; tempoh<=$TAHUN; tempoh++)); 
do
if [[ $tempoh -eq 1 ]]; then
	dividen_tahunan[0]=$(echo "scale=2;${simpanan_tahunan[0]}*$DIVIDEN"|bc)
	simpanan_tahunan[0]=$(echo "scale=2;${simpanan_tahunan[0]}+${dividen_tahunan[0]}"|bc)


elif [[ $tempoh -gt 1 ]]; then
	
	dividen_tahunan[$tempoh-1]=$(echo "scale=2;${simpanan_tahunan[$tempoh-2]}*$DIVIDEN"|bc)
	simpanan_tahunan[$tempoh-1]=$(echo "scale=2;${simpanan_tahunan[$tempoh-2]}+${dividen_tahunan[$tempoh-1]}"|bc)

else
	echo "Kena check balik..ada benda tak betul"
	echo ""

fi
        printf "\t $tempoh \t ${simpanan_tahunan[$tempoh-1]} \t\t ${dividen_tahunan[$tempoh-1]} "
	printf "\n"

done

}
printf "\tTAHUN\tSIMPANAN+DIVIDEN\tDIVIDEN\n"
echo '------------------------------------------------------'
kira
echo ""
