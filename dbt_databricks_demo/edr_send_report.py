import subprocess


def run_edr_send_report(slack_token, slack_channel_name):

    command = "edr send-report"
    subprocess.run(command, shell=True)


if __name__ == "__main__":
    run_edr_send_report()
