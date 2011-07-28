#!/bin/bash
#assumes backup_competitions.sh has been run
for year in `ls | egrep -oh -e 19.* -e 20.*`
do
	for competition in `ls $year/*.html`
	do
    competition_number=$(echo `basename $competition` | tr -cd '[[:digit:]]')
    url=`grep -oh "competition-contact.asp?CompetitionPass=[0-9]*&KeyPass=" $competition| sed "s/^/http:\/\/usdf.org\/calendar\//"` 
    id_number=$(echo $url | tr -cd '[[:digit:]]')
		if [ "$id_number" !=  "" ]
		then
      echo "$year  $competition_number"
      wget --quiet -O "$year/contact-$year-$competition_number.html" $url
	  fi
	done
done


