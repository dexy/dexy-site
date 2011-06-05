
tar -czvf $script_name.tgz $script_name
./s3-put -k $AWS_ACCESS_KEY_ID -s secret.txt -T $script_name.tgz $FOLDER_NAME/$script_name-$TIMESTAMP.tgz
./s3-put -k $AWS_ACCESS_KEY_ID -s secret.txt -T $script_name/out.log $FOLDER_NAME/$script_name-$TIMESTAMP-out.log

tar -czvf syslog.tgz -C /var/log syslog
./s3-put -k $AWS_ACCESS_KEY_ID -s secret.txt -T syslog.tgz $FOLDER_NAME/syslog-$TIMESTAMP.tgz

#shutdown -h now
