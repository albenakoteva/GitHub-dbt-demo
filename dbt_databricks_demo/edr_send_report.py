import subprocess


def run_edr_send_report():
    subprocess.run("edr send-report", shell=True)


if __name__ == "__main__":
    run_edr_send_report()
