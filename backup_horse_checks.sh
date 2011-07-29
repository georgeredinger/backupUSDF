#!/bin/bash
#assumes backup_competitions.sh has been run
OLD_IFS="$IFS";
# Character used for splitting
IFS=" ";
mkdir horses

ls | egrep -oh -e "^19.*" -e "^20.*" | 
while read year;do
  echo -n > horse_checks.tmp
  echo -n > horse_checks.srt
	ls $year/*.html | 
	while read competition;do
    competition_number=$(echo `basename $competition` | tr -cd '[[:digit:]]')
		echo  -ne "$competition_number\r"
    grep -oh  "http://www.usdf.org/scorecheck/ScoreCheckResults.asp?NumberPass=[0-9]*" "$competition" |
		while read url;do
      horse_number=$(echo $url | tr -cd '[[:digit:]]')
      echo  "$horse_number $url" >> horse_checks.tmp
		done
  done
	echo
    sort -u horse_checks.tmp > horse_checks.srt
		cat horse_checks.srt | while read line;do
		 a=( $line ); 
		 for i in {1..10};do
			 echo ${a[0]}
		   wget --quiet -O "horses/${a[0]}.html" "${a[1]}"
		    if [ "$?" == "0" ];then
					break
				fi	
	  	   echo  " retry  ${a[0]}"
	   done
	done
done



