### @export "function"
function run_script_in_ec2 {
  temp_filename=/tmp/user-data-script.$RANDOM.$$.sh
  echo $temp_filename

  script_dir=/home/ana/dev/dexy-site/install/

  script=$1
  script_name_length=${#script}
  script_name=${script:0:($script_name_length-3)}
  ami_id=$2

  echo "#!/bin/bash" > $temp_filename
  echo "AWS_SECRET_ACCESS_KEY=\"$AWS_SECRET_ACCESS_KEY\"" >> $temp_filename
  echo "AWS_ACCESS_KEY_ID=\"$AWS_ACCESS_KEY_ID\"" >> $temp_filename
  cat $script_dir/_ec2_script_header.sh >> $temp_filename
  echo "FOLDER_NAME=\"/dexy-builds/\$TIMESTAMP--$script_name--$ami_id\"" >> $temp_filename
  echo "script_name=$script_name" >> $temp_filename
  echo "cd /mnt" >> $temp_filename
  echo "mkdir $script_name" >> $temp_filename
  echo "chown -R ubuntu $script_name" >> $temp_filename
  echo "cd $script_name" >> $temp_filename
  echo "cat > script.sh <<END" >> $temp_filename
  cat $script_dir/$1 >> $temp_filename
  echo "END" >> $temp_filename
  echo "sudo -i -u ubuntu bash -c \"cd /mnt/$script_name; bash script.sh\" &> out.log" >> $temp_filename
  echo "cd .." >> $temp_filename
  cat $script_dir/_ec2_script_footer.sh >> $temp_filename

  ec2-run-instances $ami_id -k $EC2_KEYPAIR -g ssh \
    -t $3 -f $temp_filename --instance-initiated-shutdown-behavior terminate
}

### @export "amis"
UBUNTU_AMI="ami-a7f539ce" # oneiric
CUSTOM_AMI="ami-f50edf9c" # oneiric
### @end

cd ~/.ec2
source dexy-env.sh # AWS security credentials

### @export "run-scripts"
run_script_in_ec2 build-dexy-site.sh $CUSTOM_AMI m1.small
run_script_in_ec2 virtualenv-tests.sh $CUSTOM_AMI t1.micro
run_script_in_ec2 virtualenv-install.sh $UBUNTU_AMI t1.micro

