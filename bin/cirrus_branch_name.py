#!/usr/bin/env python

import argparse
import os
import subprocess

import git
from jira import JIRA

REPO_ROOT = "/home/ahonnecke/src"


def get_args():
    parser = argparse.ArgumentParser(description="Perform terraform tasks")

    repo_dirs = [x for x in os.listdir(REPO_ROOT)]

    parser.add_argument(
        "repo", help="Repository to create banch ing", choices=repo_dirs
    )

    parser.add_argument(
        "ticket",
        help="Ticket to build branch name from",
    )

    return parser.parse_args()


if __name__ == "__main__":

    jira = JIRA("https://cirrusv2x.atlassian.net", basic_auth=(auth_email, api_token))

    args = get_args()

    ticket = args.ticket.upper()
    myissue = jira.issue(ticket)

    summary = myissue.fields.summary
    summary = summary.replace(" ", "-")

    issue_type = str(myissue.fields.issuetype)
    issue_type = issue_type.upper()

    branch_name = f"{issue_type}/{ticket}--{summary}"

    # We're assuming that the user has cded to the appropriate dir

    os.chdir(REPO_ROOT + "/" + args.repo)
    print(branch_name)

    # git.checkout('dev')
    # git.reset('--hard', 'upstream/dev')

    # git checkout -b feature/V2X-2226_add-the-following-curves-to-the-curve-database upstream/dev

    cmd = ["git", "checkout", "-b", branch_name]

    subprocess.run(cmd, check=True)
