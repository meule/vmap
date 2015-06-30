
# use: export VMAPSHOST=sunmoon ./deploy.sh
ssh $VMAPSHOST 'mkdir /etc/vmaps'
scp server/install_server.sh $VMAPSHOST:/etc/vmaps
ssh $VMAPSHOST 'bash /etc/vmaps/install_server.sh'
./start.sh