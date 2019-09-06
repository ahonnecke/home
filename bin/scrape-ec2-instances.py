#!/usr/bin/env python3

import boto3
import os
from pathlib import Path

HOME = str(Path.home())
PROFILES = ["web", "docker", "terraform", "nodes", "ops"]
DESTINATION = os.path.join(HOME, ".aws/hosts")


def main():
    results = {}

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

                if not name:
                    continue

                if not public and not private:
                    continue

                results[name] = i

    with open(DESTINATION, "w") as hostsfile:
        for name, tags in results.items():
            private = tags.get("PrivateIpAddress")
            public = tags.get("PublicIpAddress")

            if private:
                hostline = f"{private.ljust(16)}          {name}"
                print(f" * {hostline}")
                hostsfile.write(f"{hostline}\n")

            if public:
                hostline = f"{public.ljust(16)}          {name}-public"
                print(f" * {hostline}")
                hostsfile.write(f"{hostline}\n")


if __name__ == "__main__":
    main()
