from datetime import datetime
import boto
import os
import sys
import time

def credentials():
    credential_file = "~/.dexyapis"
    with open(os.path.expanduser(credential_file), "rb") as f:
        credential_info = f.read()
    return "cat > /home/ubuntu/.dexyapis << API\n%s\nAPI" % credential_info

def user_data(
        script_name,
        ami_id,
        upload_s3=True,
        supplemental=None, # supplemental text to include
        include_credentials=False # whether to include dexyapis file
    ):
    user_data = []

    filenames = SCRIPTS[script_name]

    header_args= {
        "aws_secret_access_key" : os.getenv("AWS_SECRET_ACCESS_KEY"),
        "aws_access_key_id" : os.getenv("AWS_ACCESS_KEY_ID"),
        "timestamp" : datetime.now().strftime("%Y-%m-%d--%H-%M-%s"),
        "script_name" : script_name,
        "ami_id" : ami_id
    }

    header = """#!/bin/bash -v
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    echo ">>> starting script at `date`"
    AWS_ACCESS_KEY_ID="%(aws_access_key_id)s"
    AWS_SECRET_ACCESS_KEY="%(aws_secret_access_key)s"
    TIMESTAMP=%(timestamp)s
    FOLDER_NAME="/dexy-builds/$TIMESTAMP--%(script_name)s--%(ami_id)s"
    export SCRIPT_NAME="%(script_name)s"

    cd /home/ubuntu
    echo -n $AWS_SECRET_ACCESS_KEY > secret.txt
    curl -o s3-bash.tgz http://s3-bash.googlecode.com/files/s3-bash.0.02.tar.gz
    tar -xzf s3-bash.tgz

    cd /mnt
    mkdir %(script_name)s
    chown -R ubuntu %(script_name)s
    cd %(script_name)s
    cat > script.sh << "END"
    """ % header_args

    for line in header.splitlines():
        user_data.append(line.strip())

    if include_credentials:
        user_data.append(credentials())

    if supplemental:
        user_data.append(supplemental)

    for filename in filenames:
        with open(filename, "r") as f:
            user_data.append(f.read())

    footer = """END

    sudo -i -u ubuntu bash -c "cd /mnt/%s; bash script.sh" &> out.log
    cd ..
    """ % script_name

    for line in footer.splitlines():
        user_data.append(line.strip())

    if upload_s3:
        with open("_ec2_script_footer.sh", "r") as f:
            user_data.append(f.read())

    return "\n".join(user_data)

def launch_instance(conn, script_name, ami, instance_type, **kwargs):
    script = user_data(script_name, ami, **kwargs)
    reservation = conn.run_instances(ami,
               key_name=os.getenv("EC2_KEYPAIR"),
               instance_type=instance_type,
               user_data=script,
               instance_initiated_shutdown_behavior='terminate')
    return reservation.instances[0]

def wait_for_ip_address(instance):
    state = 'pending'
    while state == 'pending':
        state = instance.update()
        time.sleep(10)
    return instance.ip_address

UBUNTU_AMI="ami-baba68d3"
CUSTOM_AMI="ami-c0e73ba9"

# dict of script names and the filenames they need
SCRIPTS = {
        "dexy-site-develop" : ["temp-installs.sh", "dexy-site-environment.sh", "dexy-site-develop.sh"],
        "dexy-site-build" : ["temp-installs.sh", "dexy-site-environment.sh", "dexy-site-build.sh"],
        "virtualenv-installs" : ["virtualenv-installs.sh"],
        "virtualenv-tests" : ["virtualenv-tests.sh"]
        }

conn = boto.connect_ec2()

script_name = sys.argv[1]

if script_name == 'dexy-site-develop':
    instance = launch_instance(conn, script_name, CUSTOM_AMI, "m2.xlarge", include_credentials=True, upload_s3=False)
elif script_name == 'dexy-site-build':
    instance = launch_instance(conn, script_name, CUSTOM_AMI, "m1.large", include_credentials=True)
elif script_name == 'virtualenv-tests':
    instance = launch_instance(conn, script_name, CUSTOM_AMI, "t1.micro")
elif script_name == 'virtualenv-installs':
    instance = launch_instance(conn, script_name, UBUNTU_AMI, "t1.micro")
else:
    raise Exception("unexpected script name %s" % script_name)

print script_name
print instance
print wait_for_ip_address(instance)

