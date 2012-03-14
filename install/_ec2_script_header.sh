exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo ">>> starting script at `date`"

cd /home/ubuntu

echo -n $AWS_SECRET_ACCESS_KEY > secret.txt

curl -o s3-bash.tgz http://s3-bash.googlecode.com/files/s3-bash.0.02.tar.gz
tar -xzvf s3-bash.tgz

TIMESTAMP=`date +%s--%H-%M`
