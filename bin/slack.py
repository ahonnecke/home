#!/usr/bin/env python3

import argparse

import pyautogui


def get_args():
    parser = argparse.ArgumentParser(description="Get task IP")

    parser.add_argument(
        "action",
        help="Service name, or partial service name",
        choices=["kill", "start"],
    )

    # parser.add_argument("-c", "--cluster", help="The cluster to query")

    # parser.add_argument("-t", "--task", help="The task to query")

    return parser.parse_args()


def start():
    pyautogui.keyDown("winleft")
    pyautogui.write("a")  # prints out "slack" instantly
    pyautogui.keyUp("winleft")
    pyautogui.write("slack", interval=0.1)  # prints out "slack" instantly
    pyautogui.press("enter", interval=0.5)  # press the Enter key


def kill():
    start()

    pyautogui.hotkey("winleft", "q", interval=0.5)


if __name__ == "__main__":
    args = get_args()
    if args.action == "kill":
        kill()
    elif args.action == "start":
        start()
