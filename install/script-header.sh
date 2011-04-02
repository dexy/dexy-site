#!/bin/bash
cd /home/ubuntu

export AWS_ACCESS_KEY_ID="AKIA..."
export AWS_SECRET_ACCESS_KEY="AeT27..."
echo -n $AWS_SECRET_ACCESS_KEY > secret.txt

curl -o s3-bash.tgz http://s3-bash.googlecode.com/files/s3-bash.0.02.tar.gz
tar -xzvf s3-bash.tgz

TIMESTAMP=`date +%s`

export PATH=$PATH:/var/lib/gems/1.8/bin
export HOME=/home/ubuntu # for erlang

