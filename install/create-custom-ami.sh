UBUNTU_AMI="ami-baba68d3"

#INSTANCE_TYPE="m1.medium" # Takes about 60 minutes, costs $0.16
#INSTANCE_TYPE="m1.large" # Takes about 40 minutes, costs $0.32
INSTANCE_TYPE="m2.xlarge" # Takes ? minutes, costs $0.45
#INSTANCE_TYPE="m2.2xlarge" # Takes 27 minutes, costs $0.90

cd ~/.ec2
source dexy-env.sh

ec2-run-instances $UBUNTU_AMI -k $EC2_KEYPAIR -t $INSTANCE_TYPE \
  --instance-initiated-shutdown-behavior stop \
  -f ~/dev/dexy-site/install/full-setup-ubuntu.sh
