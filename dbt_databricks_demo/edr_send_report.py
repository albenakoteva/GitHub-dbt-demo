import subprocess


def run_edr_send_report():
    command = "edr send-report --slack-token xoxb-5575323113526-5575412966566-SnTA5IdZ8nvl7umWCC9nC62e --slack-channel-name data-accelerator-dbt-demo"
    subprocess.run(command, shell=True)


if __name__ == "__main__":
    run_edr_send_report()
