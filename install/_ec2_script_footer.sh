DEXY_SITE_TGZ="/mnt/build-dexy-site/dexy-site/dexy-site.tgz"

if [ -e $DEXY_SITE_TGZ ]
then /home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $DEXY_SITE_TGZ /artifacts/dexy-site.tgz
fi

tar -czvf $script_name.tgz $script_name
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $script_name.tgz $FOLDER_NAME/$script_name-$TIMESTAMP.tgz
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $script_name/out.log $FOLDER_NAME/$script_name-$TIMESTAMP-out.log

tar -czvf syslog.tgz -C /var/log syslog
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T syslog.tgz $FOLDER_NAME/syslog-$TIMESTAMP.tgz

echo ">>> finishing script at `date`"

#shutdown -h now
