#!/bin/bash
#assumes backup_competitions.sh has been run
for year in `ls | egrep -oh -e 19.* -e 20.*`
do
  echo -n > horse_checks.tmp
  echo -n > horse_checks.sh
	for competition in `ls $year/*.html`
	do
    competition_number=$(echo `basename $competition` | tr -cd '[[:digit:]]')
    grep -oh  "http://www.usdf.org/scorecheck/ScoreCheckResults.asp?NumberPass=[0-9]*" "$competition" |
		while read url;do
      horse_number=$(echo $url | tr -cd '[[:digit:]]')
      echo  "echo  $horse_number; wget -T 7  --tries=10 --retry-connrefused -O \"$year/horse-check-$year-$competition_number-$horse_number.html\"  \"$url\"" >> horse_checks.tmp
		done
    sort -u horse_checks.tmp > horse_checks.sh
    sh horse_checks.sh
	done
done



