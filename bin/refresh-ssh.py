#!/usr/bin/env python3

import boto3
import os
from pathlib import Path
from shutil import copyfile

HOME = str(Path.home())

# @TODO scrape profile for roles
PROFILES = ["web", "docker", "terraform", "nodes", "ops"]
PROFILES = ["web", "nodes"]
HOSTS = os.path.join(HOME, ".aws/hosts")
AWS_CONF = os.path.join(HOME, ".ssh/aws.conf")
STATIC_CONF = os.path.join(HOME, ".ssh/static.conf")
SSH_CONF = os.path.join(HOME, ".ssh/config")


def main():
    results = {}
    hostmap = []

    for profile in PROFILES:
        print(f"Assuming {profile}")
        session = boto3.Session(profile_name=profile)
        client = session.client("ec2")

        response = client.describe_instances()

        for r in response["Reservations"]:
            for i in r["Instances"]:
                tags = i.get("Tags", [])
                name = None
                for tag in tags:
                    if tag.get("Key") == "Name":
                        name = tag.get("Value").lower().replace(" ", "-")

                private = i.get("PrivateIpAddress")
                public = i.get("PublicIpAddress")

                if not name or not i.get("KeyName"):
                    continue

                if not public and not private:
                    continue

                if "bastion" in name:
                    continue

                results[name] = i

    for name, tags in results.items():
        private = tags.get("PrivateIpAddress")
        public = tags.get("PublicIpAddress")
        keyname = tags.get("KeyName")

        if private:
            hostmap.append({"name": name, "ip": private, "keyname": keyname})

    copyfile(STATIC_CONF, SSH_CONF)

    for host in hostmap:
        ip = host.get("ip")
        name = host.get("name")
        keyname = host.get("keyname").replace("-bastion", "")

        # @TODO figure out how to programatically determine the OS/username on the target box
        ssh_block = f"""
# {name} {keyname}
Host {name}
   Hostname {ip}
   StrictHostKeyChecking no
   User ubuntu
   IdentityFile ~/.ssh/{keyname}.pem
   ProxyCommand ssh -W %h:%p {keyname}-bastion

Host {name}
   Hostname {ip}
   StrictHostKeyChecking no
   User ec2-user
   IdentityFile ~/.ssh/{keyname}.pem
   ProxyCommand ssh -W %h:%p {keyname}-bastion

"""

        # file.write(ssh_block)

        print(ssh_block)

        with open(SSH_CONF, "a") as final:
            final.write(ssh_block)


if __name__ == "__main__":
    main()
