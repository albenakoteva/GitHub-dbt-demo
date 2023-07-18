import subprocess
import sys


def run_edr_send_report(slack_token: str, slack_channel_name: str):

    command = "edr send-report --slack-token " + slack_token + \
        " --slack-channel-name " + slack_channel_name
    subprocess.run(command, shell=True)
    # print(command)


if __name__ == "__main__":
    slack_token = sys.argv[1]
    slack_channel_name = sys.argv[2]

    run_edr_send_report(slack_token, slack_channel_name)
