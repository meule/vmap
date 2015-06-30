# use: export VMAPSHOST=sunmoon ./start.sh
scp settings.pgrestapi.js $VMAPSHOST:/etc/vmaps/PGRestAPI/settings/settings.js
scp start_server.sh $VMAPSHOST:/etc/vmaps
scp vmaps.conf $VMAPSHOST:/etc/nginx/sites-available
ssh $VMAPSHOST 'bash /etc/vmaps/start_server.sh'
