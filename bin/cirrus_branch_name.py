#!/usr/bin/env python

import argparse
import os
import subprocess

import git
import prompt_toolkit
from jira import JIRA
from prompt_toolkit import prompt
from prompt_toolkit.completion import WordCompleter

TOKEN = "<get a token>"
REPO_ROOT = "/home/ahonnecke/src"


def get_args(repo_dirs):
    parser = argparse.ArgumentParser(description="Perform terraform tasks")

    parser.add_argument(
        "--repo",
        help="Repository to create banch in",
        choices=repo_dirs,
        required=False,
    )

    parser.add_argument(
        "--parent",
        help="Parent branch",
        default="dev",
        required=False,
    )

    parser.add_argument("ticket", help="Ticket to build branch name from")

    return parser.parse_args()


if __name__ == "__main__":
    auth_email = "ashton.honnecke@us.panasonic.com"

    jira = JIRA("https://cirrusv2x.atlassian.net", basic_auth=(auth_email, TOKEN))

    repo_dirs = [x for x in os.listdir(REPO_ROOT)]
    args = get_args(repo_dirs)

    if args.repo:
        repo = args.repo
    else:
        html_completer = WordCompleter(repo_dirs)
        repo = prompt("Choose repository: ", completer=html_completer)
        print("Using repository: %s" % repo)

    ticket = args.ticket.upper()
    myissue = jira.issue(ticket)

    summary = myissue.fields.summary
    summary = summary.replace(" ", "-")
    for bad_char in ["."]:
        summary = summary.replace(bad_char, "")

    issue_type = str(myissue.fields.issuetype)
    issue_type = issue_type.upper()

    branch_name = f"{issue_type}/{ticket}--{summary}"

    # We're assuming that the user has cded to the appropriate dir

    os.chdir(REPO_ROOT + "/" + repo)
    print(branch_name)

    # git.checkout('dev')
    # git.reset('--hard', 'upstream/dev')
    # git checkout -b feature/V2X-2226_add-the-following-curves-to-the-curve-database upstream/dev

    # TODO fix the remote name
    remote = "upstream"
    print(f"Creating the branch {branch_name}")
    cmd = ["git", "checkout", "-b", branch_name, f"{remote}/{args.parent}"]

    subprocess.run(cmd, check=True)
