UBUNTU_AMI="ami-06ad526f" # natty

cd ~/.ec2

ec2-run-instances $UBUNTU_AMI -k anakeyxx \
  --instance-initiated-shutdown-behavior stop \
  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh
