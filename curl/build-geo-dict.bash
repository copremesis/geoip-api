#/bin/bash
#generate python ip to tuple dictionary
host="http://0.0.0.0:4567"
echo "coordinates={"
for ip in $(cat $1) #pass in a list of ip addresses
do
  geo_raw=$(curl -s $host/geo/$ip | jq ".latitude, .longitude")
  geo_tuple=$(echo $geo_raw | sed 's/ /,/')
  echo "    '$ip':  ($geo_tuple),"
done
echo "}"
