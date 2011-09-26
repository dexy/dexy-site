UBUNTU_AMI="ami-06ad526f" # natty
UBUNTU_LUCID_AMI="ami-61be7908" # lucid, for python 2.6 testing

cd ~/.ec2
source dexy-env.sh

ec2-run-instances $UBUNTU_AMI -k $EC2_KEYPAIR \
  --instance-initiated-shutdown-behavior stop \
  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh

ec2-run-instances $UBUNTU_LUCID_AMI -k $EC2_KEYPAIR \
  --instance-initiated-shutdown-behavior stop \
  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh

