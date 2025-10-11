#!/usr/bin/env python3
"""
Sync Xournal++ Lua API file from GitHub with documentation header
Usage: python sync_luapi.py
"""

import json
import urllib.request
from datetime import datetime
from pathlib import Path

REPO = "xournalpp/xournalpp"
FILE_PATH = "plugins/luapi_application.def.lua"

# Get latest commit info for the file
API_URL = f"https://api.github.com/repos/{REPO}/commits?path={FILE_PATH}&per_page=1"
with urllib.request.urlopen(API_URL) as response:
    commit_data = json.loads(response.read())[0]
    commit_short = commit_data['sha'][:7]
    commit_full = commit_data['sha']
    commit_date = commit_data['commit']['committer']['date'][:10]

# Download file content
RAW_URL = f"https://raw.githubusercontent.com/{REPO}/master/{FILE_PATH}"
with urllib.request.urlopen(RAW_URL) as response:
    content = response.read().decode('utf-8')

# Create header
HEADER_TEMPLATE = """-- Xournal++ Lua Plugin API Type Definitions
-- 
-- This file provides IntelliSense, type checking, and documentation for the Xournal++ Lua API.
-- It is used by the Lua Language Server for IDE features and is NOT loaded at runtime.
-- Xournal++ provides the actual 'app' object when the plugin runs.
--
-- Source: https://github.com/{REPO}/blob/master/{FILE_PATH}
-- Action properties: https://github.com/{REPO}/blob/master/src/core/control/actions/ActionProperties.h
-- Based on commit: {commit_short} ({commit_date})
-- Permalink: https://github.com/{REPO}/blob/{commit_full}/{FILE_PATH}
--
-- Last synced: {sync_date}

"""

header = HEADER_TEMPLATE.format(
    REPO=REPO,
    FILE_PATH=FILE_PATH,
    commit_short=commit_short,
    commit_date=commit_date,
    commit_full=commit_full,
    sync_date=datetime.now().strftime("%Y-%m-%d")
)

output = Path("luapi_application.def.lua")
output.write_text(header + content, 'utf-8')

print(f"Synced from commit {commit_short} ({commit_date})")
print(f"Saved to {output}")
