#!/usr/bin/env python3
import os
import glob
import re
import json

def get_apps():
    apps = []
    paths = ['/usr/share/applications', os.path.expanduser('~/.local/share/applications')]
    for p in paths:
        for f in glob.glob(os.path.join(p, '*.desktop')):
            try:
                with open(f, 'r', encoding='utf-8', errors='ignore') as fp:
                    content = fp.read()
                    if 'NoDisplay=true' in content:
                        continue
                    name_m = re.search(r'^Name=(.+)$', content, re.M)
                    exec_m = re.search(r'^Exec=(.+)$', content, re.M)
                    icon_m = re.search(r'^Icon=(.+)$', content, re.M)
                    if name_m and exec_m:
                        exec_cmd = re.sub(r' %[a-zA-Z]', '', exec_m.group(1)).strip()
                        apps.append({
                            'name': name_m.group(1).strip(),
                            'exec': exec_cmd,
                            'icon': icon_m.group(1).strip() if icon_m else 'application-x-executable'
                        })
            except Exception:
                pass
    unique_apps = sorted(list({a['name']: a for a in apps}.values()), key=lambda x: x['name'].lower())
    return unique_apps

if __name__ == '__main__':
    print(json.dumps(get_apps()))
