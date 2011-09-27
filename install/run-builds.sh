### @export "function"
function run_script_in_ec2 {
  temp_filename=/tmp/user-data-script.$RANDOM.$$.sh
  echo $temp_filename

  script_dir=/home/ana/dev/dexy-site/install/

  script=$1
  script_name_length=${#script}
  script_name=${script:0:($script_name_length-3)}
  ami_id=$2

  cat $script_dir/script-header.sh > $temp_filename
  echo "FOLDER_NAME=\"/dexy-builds/\$TIMESTAMP--$script_name--$ami_id\"" >> $temp_filename
  echo "script_name=$script_name" >> $temp_filename
  echo "cd /mnt" >> $temp_filename
  echo "mkdir $script_name" >> $temp_filename
  echo "cd $script_name" >> $temp_filename
  echo "cat > script.sh <<END" >> $temp_filename
  cat $script_dir/$1 >> $temp_filename
  echo "END" >> $temp_filename
  echo "bash script.sh &> out.txt" >> $temp_filename
  echo "cd .." >> $temp_filename
  cat $script_dir/close.sh >> $temp_filename

  ec2-run-instances $ami_id -k $EC2_KEYPAIR -g ssh \
    -t $3 -f $temp_filename --instance-initiated-shutdown-behavior terminate
}

### @export "amis"
UBUNTU_AMI="ami-06ad526f" # natty
UBUNTU_LUCID_AMI="ami-61be7908" # lucid, for python 2.6 testing

CUSTOM_AMI="ami-1554967c" # natty
CUSTOM_LUCID_AMI="ami-ef549686" # lucid
### @end

cd ~/.ec2
source dexy-env.sh # AWS security credentials

### @export "run-scripts"
run_script_in_ec2 min-install-ubuntu.sh $UBUNTU_AMI t1.micro
run_script_in_ec2 min-install-ubuntu.sh $UBUNTU_LUCID_AMI t1.micro
run_script_in_ec2 virtualenv-install.sh $CUSTOM_AMI t1.micro
run_script_in_ec2 virtualenv-install.sh $CUSTOM_LUCID_AMI t1.micro
run_script_in_ec2 source-install.sh $CUSTOM_AMI t1.micro
run_script_in_ec2 source-install.sh $CUSTOM_LUCID_AMI t1.micro

