echo "Starting Docker container and data volume..."
sudo docker run -d -p 127.0.0.1:9200:9200 -v $PWD/geonames_index/:/usr/share/elasticsearch/data elasticsearch:7.6.2

echo "Downloading Geonames gazetteer..."
wget http://download.geonames.org/export/dump/allCountries.zip
echo "Unpacking Geonames gazetteer..."
unzip allCountries.zip

echo "Creating mappings for the fields in the Geonames index..."
curl -XPUT 'localhost:9200/geonames' -H 'Content-Type: application/json' -d @geonames_mapping-es7.json

echo "Loading gazetteer into Elasticsearch..."
python geonames_elasticsearch_loader-es7.py

echo "Done"
