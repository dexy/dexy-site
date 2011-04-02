UBUNTU_AMI="ami-3e02f257"

cd ~/.ec2

ec2-run-instances $UBUNTU_AMI -k ec2-keypair \
  --instance-initiated-shutdown-behavior stop \
  -f /sites/dexy-site/install/full-setup-ubuntu.sh
