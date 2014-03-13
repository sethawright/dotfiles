#!/bin/sh

curl --silent "http://xml.weather.yahoo.com/forecastrss?p=27516&u=f" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/ *//g' -e 's/F<BR\/>//' -e 's/<description>//' -e 's/<\/description>//' | tr -d '[blank]' | cut -f2 -s -d','
