scp settings.pgrestapi.js sunmoon:/etc/vmaps/PGRestAPI/settings/settings.js
scp start.sh sunmoon:/etc/vmaps
scp vmaps.conf sunmoon:/etc/nginx/sites-available
ssh sunmoon 'bash /etc/vmaps/start.sh'
