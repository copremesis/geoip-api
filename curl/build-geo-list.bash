#/bin/bash


#generate python tuple list 
#for mapping
host="http://0.0.0.0:4567"
echo "coordinates={"
for ip in $(cat $1) #pass in a list of ip addresses 
do
  #echo $ip
  geo_raw=$(curl -s $host/geo/$ip | jq ".latitude, .longitude")
  
  #open street map experiments for spot checking
  #geo_query=$(echo $geo_raw | sed 's/ /%2C/')
  #geo_map=$(echo $geo_raw | sed 's/ /\//')
  #echo "https://www.openstreetmap.org/search?query=$geo_query#map=4/$geo_map"

  #build python list of tuples
  geo_tuple=$(echo $geo_raw | sed 's/ /,/')
  echo "    '$ip':  ($geo_tuple),"
done
echo "}"

#run with
#source build-geo-list.bash 2>/dev/null
#as some ips do not resolve and manual cleanup is required

