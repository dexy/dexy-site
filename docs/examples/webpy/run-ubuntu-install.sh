export UBUNTU_AMI="ami-06ad526f" # natty
cd ~/.ec2
ec2run $UBUNTU_AMI -k $EC2_KEYPAIR \
    -t t1.micro -f ~/dev/dexy-examples/webpy/ubuntu-install.sh
