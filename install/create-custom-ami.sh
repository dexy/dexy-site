UBUNTU_AMI="ami-a7f539ce" # oneiric
UBUNTU_X64_AMI="ami-bbf539d2" # oneiric

cd ~/.ec2
source dexy-env.sh

ec2-run-instances $UBUNTU_AMI -k $EC2_KEYPAIR \
  --instance-initiated-shutdown-behavior stop \
  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh

#ec2-run-instances $UBUNTU_X64_AMI -k $EC2_KEYPAIR -t m1.large \
#  --instance-initiated-shutdown-behavior stop \
#  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh
