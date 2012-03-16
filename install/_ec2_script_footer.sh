
echo $AWS_ACCESS_KEY_ID
echo $SCRIPT_NAME
echo $FOLDER_NAME
echo $TIMESTAMP

tar -czvf $SCRIPT_NAME.tgz $SCRIPT_NAME
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $SCRIPT_NAME.tgz $FOLDER_NAME/$SCRIPT_NAME-$TIMESTAMP.tgz
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $SCRIPT_NAME/out.log $FOLDER_NAME/$SCRIPT_NAME-$TIMESTAMP-out.log

tar -czvf syslog.tgz -C /var/log syslog
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T syslog.tgz $FOLDER_NAME/syslog-$TIMESTAMP.tgz

echo ">>> finishing script at `date`"

#shutdown -h now
