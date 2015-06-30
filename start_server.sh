sudo rm /etc/nginx/sites-enabled/vmaps.conf; sudo ln -s /etc/nginx/sites-available/vmaps.conf /etc/nginx/sites-enabled/vmaps.conf
sudo service nginx restart
forever list | egrep 'pgrestapi.+[0-9]+ +[0-9]+' -o | egrep '[0-9]+$' -o | (read PID; echo $PID; sudo forever stop $PID)
cd /etc/vmaps/PGRestAPI; forever start --uid pgrestapi --append app.js