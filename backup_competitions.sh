#!/bin/bash
for  year in {2011..1990};do
	if [ ! -d "$year" ]; then
	  mkdir "$year"
	fi
  for show in {0..9999} ; do
  	wget --quiet -O "$year/$year_$show".html  "http://www.usdf.org/calendar/results.asp?RCYear=$year&CompetitionPass=$show&KeyPass=RC"
		echo "$? $year $show"
  done
	tar -zcvf "$year.tar.gz" "$year"
done

