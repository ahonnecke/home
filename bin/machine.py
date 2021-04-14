#!/usr/bin/env python3

import argparse

import pyautogui


def get_args():
    parser = argparse.ArgumentParser(description="Lock machine")

    parser.add_argument(
        "action",
        help="Service name, or partial service name",
        choices=["sleep", "start"],
    )

    return parser.parse_args()


def lock():
    pyautogui.hotkey("winleft", "esc", interval=0.5)


if __name__ == "__main__":
    args = get_args()
    if args.action == "sleep":
        lock()
