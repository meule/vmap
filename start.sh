# use: export VMAPSHOST=sunmoon ./start.sh
scp settings/settings.pgrestapi.js $VMAPSHOST:/etc/vmaps/PGRestAPI/settings/settings.js
scp server/start_server.sh $VMAPSHOST:/etc/vmaps
scp settings/vmaps.conf $VMAPSHOST:/etc/nginx/sites-available
ssh $VMAPSHOST 'bash /etc/vmaps/start_server.sh'
