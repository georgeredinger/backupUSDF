#!/bin/bash

#delete zero length .html files
for year in `ls | egrep -oh -e 19.* -e 20.*`;do
  for i in $year/*.html;do
  	 	if [ ! -s $i ]; then 
  		 	 rm $i
  		fi
  done
done

