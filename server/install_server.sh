sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y g++ curl libssl-dev apache2-utils git-core nginx osm2pgsql unzip default-jre python-pip make
sudo apt-add-repository ppa:chris-lea/node.js -y
sudo apt-get update 
sudo apt-get install -y nodejs
sudo add-apt-repository ppa:mapnik/nightly-2.3 -y
sudo apt-get update
sudo apt-get install -y libmapnik libmapnik-dev mapnik-utils python-mapnik mapnik-input-plugin-gdal gdal-bin mapnik-input-plugin-postgis
sudo pip install rtree imposm
sudo npm install -g forever

# dirs
mkdir /etc/vmaps
mkdir /etc/vmaps/data
mkdir /etc/vmaps/temp

# PGRestAPI
cd /etc/vmaps
git clone https://github.com/spatialdev/PGRestAPI.git
cd PGRestAPI
sudo npm install

# create users and db
sudo -u postgres createuser --superuser root
sudo -u postgres createuser geo
createdb geo

# get pg version and add trust authentification to pg config for geo and roo users for geo db
psql --version | egrep -o '[0-9]{1,}\.[0-9]{1,}' | (read PGVERSION; locate $PGVERSION/main/pg_hba.conf) | (read PGCONFIG; 
	echo $PGCONFIG; 
	echo 'local geo geo,root trust
		host geo geo,root 127.0.0.1/32 trust
		host geo geo,root ::1/128 trust' >> $PGCONFIG;
	sed -i 's/local *all *all *peer/#local all all peer/g' $PGCONFIG
	sed -i 's/host *all *all *127.0.0.1\/32 *md5/#host all all 127.0.0.1\/32 md5/g' $PGCONFIG
	sed -i 's/host *all *all *::1\/128 *md5/#host all all ::1\/128 md5/g' $PGCONFIG)
sudo /etc/init.d/postgresql restart

# readonly permissions for user geo
psql -d geo -c 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO geo;'
psql -d geo -c 'ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO geo;'
psql -d geo -c 'GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO geo;'
psql -d geo -c 'ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, USAGE ON SEQUENCES TO geo;'

psql -d geo -U root -c 'vacuum analyze;'

	
 /