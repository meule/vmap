ssh $VMAPSHOST 'mkdir /etc/vmaps'
scp install_server.sh $VMAPSHOST:/etc/vmaps
ssh $VMAPSHOST 'bash /etc/vmaps/install.sh'
