#!/bin/bash
#count competitions with results for current year
year=`date +%Y`
curls=0
recurls=0
failures=0
for  region in {1..9};do
  	curl  -s  "http://www.usdf.org/calendar/competitions.asp?regionpass=$region&TypePass=All&YearPass=$year"
done |
egrep -oh -e "results\.asp.RCYear=[0-9]*\&CompetitionPass=[0-9]*" | 
sed "s/^/http:\/\/www.usdf.org\/calendar\//" > show_urls.txt

while read url;do
	for trys in {1..6};do
          curls=$(( $curls + 1 ))
	  curl -s $url > temp_show.txt
	  errors=`fgrep -c "Microsoft OLE DB" temp_show.txt`
	  if [ "$trys" -gt 5 ];then
            failures=$(( $failures + 1 ))
          fi
          if [ "$errors" != "0" ];then
            recurls=$(( $recurls + 1 ))
	  else
	    cat temp_show.txt
	    break
	  fi
  done
done < show_urls.txt  > rides_blob.txt
grep -o "<strong>Placing:</strong>"  rides_blob.txt  | wc -l
echo "tries: $curls"
echo "retries: $recurls"
echo "failures: $failures"




