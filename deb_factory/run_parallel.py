"""Run release checks and both application builds before DEB packaging."""

import os
from pathlib import Path
import queue
import signal
import subprocess
import sys
import threading
import time


def reap(label, process, completed):
    completed.put((label, process.wait()))


def stop_workers(workers):
    # A build script may have exited while its compiler/test descendants remain.
    # Signal the entire session group, even when the script itself is already done.
    def send(signum):
        for process in workers:
            try:
                os.killpg(process.pid, signum)
            except ProcessLookupError:
                pass

    send(signal.SIGTERM)
    deadline = time.monotonic() + 5
    for process in workers:
        try:
            process.wait(timeout=max(0, deadline - time.monotonic()))
        except subprocess.TimeoutExpired:
            pass
    send(signal.SIGKILL)
    for process in workers:
        process.wait()


def main(aot_script):
    factory = Path(__file__).resolve().parent
    aot_script = Path(aot_script).resolve()
    jobs = [
        ("checks", [str(factory / "run_tests.sh")], factory),
        ("dslideshow_flutter", [str(aot_script)], aot_script.parent),
        (
            "config_app",
            [str(factory.parent / "config_app/build_web.sh"), "--no-pub"],
            factory.parent / "config_app",
        ),
    ]
    # SimpleQueue.put is reentrant, including calls from a Python signal handler.
    completed = queue.SimpleQueue()
    workers = []
    succeeded = False

    def interrupted(signum, _frame):
        completed.put((None, 128 + signum))

    signal.signal(signal.SIGINT, interrupted)
    signal.signal(signal.SIGTERM, interrupted)
    try:
        for label, command, cwd in jobs:
            print(f"--- Start '{label}' ---", flush=True)
            process = subprocess.Popen(command, cwd=cwd, start_new_session=True)
            workers.append(process)
            threading.Thread(
                target=reap, args=(label, process, completed), daemon=True,
            ).start()
        for _ in workers:
            label, result = completed.get()
            if label is None:
                return result
            if result:
                print(f"Error: '{label}' exited with status {result}", file=sys.stderr, flush=True)
                return 1
            print(f"--- Passed '{label}' ---", flush=True)
        succeeded = True
        return 0
    except OSError as error:
        print(f"Error: cannot start release worker: {error}", file=sys.stderr, flush=True)
        return 1
    finally:
        if not succeeded:
            signal.signal(signal.SIGINT, signal.SIG_IGN)
            signal.signal(signal.SIGTERM, signal.SIG_IGN)
            stop_workers(workers)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
