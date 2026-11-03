#!/usr/bin/env python3
import os
import sys
import socket
import json
import subprocess
import time

def get_status():
    try:
        active = json.loads(subprocess.check_output(['hyprctl', 'activeworkspace', '-j']).decode())
        ws_list = json.loads(subprocess.check_output(['hyprctl', 'workspaces', '-j']).decode())
        active_id = active.get('id', 1)
        occupied = [w.get('id') for w in ws_list]
        return f"STATUS:{active_id}:{','.join(str(x) for x in sorted(occupied))}"
    except Exception as e:
        return "STATUS:1:1"

def main():
    sys.stdout.write(get_status() + "\n")
    sys.stdout.flush()

    sig = os.environ.get('HYPRLAND_INSTANCE_SIGNATURE')
    runtime = os.environ.get('XDG_RUNTIME_DIR')
    if not sig or not runtime:
        return

    sock_path = f"{runtime}/hypr/{sig}/.socket2.sock"
    if not os.path.exists(sock_path):
        return

    while True:
        try:
            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
            s.connect(sock_path)
            f = s.makefile('r', encoding='utf-8')
            for line in f:
                line = line.strip()
                if line.startswith("workspace>>") or line.startswith("focusedmon>>") or \
                   line.startswith("createworkspace>>") or line.startswith("destroyworkspace>>") or \
                   line.startswith("openwindow>>") or line.startswith("closewindow>>"):
                    sys.stdout.write(get_status() + "\n")
                    sys.stdout.flush()
        except Exception:
            time.sleep(1)

if __name__ == "__main__":
    main()
