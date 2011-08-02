#!/bin/bash
#count competitions with results for current year
year=`date +%Y`
for  region in {1..9};do
  	curl  -s  "http://www.usdf.org/calendar/competitions.asp?regionpass=$region&TypePass=All&YearPass=$year"
done | egrep -oh -e "results\.asp.RCYear=[0-9]*\&CompetitionPass=[0-9]*"|wc -l
#done | egrep -oh -e "USDF# [1-9][0-9]*" -e "results\.asp.RCYear=[0-9]*\&CompetitionPass=[0-9]*"


