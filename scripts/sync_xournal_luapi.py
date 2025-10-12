#!/usr/bin/env python3
"""
Sync Xournal++ Lua API file from GitHub with documentation header
Usage: python sync_luapi.py
"""

import json
import urllib.request
import textwrap
from datetime import datetime
from pathlib import Path


REPO = "xournalpp/xournalpp"
FILE_PATH = "plugins/luapi_application.def.lua"


def get_latest_commit_info():
    """Fetch latest commit hash and date for the given file."""
    api_url = f"https://api.github.com/repos/{REPO}/commits?path={FILE_PATH}&per_page=1"
    with urllib.request.urlopen(api_url) as response:
        commit_data = json.loads(response.read())[0]
        commit_short = commit_data["sha"][:7]
        commit_full = commit_data["sha"]
        commit_date = commit_data["commit"]["committer"]["date"][:10]
    return commit_short, commit_full, commit_date


def download_file_content():
    """Download the Lua API file content from GitHub."""
    raw_url = f"https://raw.githubusercontent.com/{REPO}/master/{FILE_PATH}"
    with urllib.request.urlopen(raw_url) as response:
        return response.read().decode("utf-8")


def build_header(commit_short, commit_full, commit_date):
    """Generate the documentation header for the Lua API file."""
    header_template = textwrap.dedent(
        f"""\
        -- Xournal++ Lua Plugin API Type Definitions
        --
        -- This file provides IntelliSense, type checking,
        -- and documentation for the Xournal++ Lua API.
        -- It is used by the Lua Language Server for IDE features
        -- and is NOT loaded at runtime.
        -- Xournal++ provides the actual 'app' object when the plugin runs.
        --
        -- Source: https://github.com/{REPO}/blob/master/{FILE_PATH}
        -- Action properties:
        -- https://github.com/{REPO}/blob/master/src/core/control/actions/ActionProperties.h
        -- Based on commit: {commit_short} ({commit_date})
        -- Permalink: https://github.com/{REPO}/blob/{commit_full}/{FILE_PATH}
        --
        -- Last synced: {datetime.now().strftime("%Y-%m-%d")}

    """
    )
    return header_template


def get_old_commit_hash(output_path: Path):
    """Extract the previous commit hash from an existing file, if any."""
    if not output_path.exists():
        return None

    old_content = output_path.read_text("utf-8")
    for line in old_content.split("\n"):
        if line.startswith("-- Based on commit:"):
            return line.split(":")[1].strip().split()[0]
    return None


def main():
    """Main function for syncing the Lua API definition file."""
    commit_short, commit_full, commit_date = get_latest_commit_info()
    content = download_file_content()
    header = build_header(commit_short, commit_full, commit_date)
    output = Path("luapi_application.def.lua")

    old_commit = get_old_commit_hash(output)

    if old_commit == commit_short:
        print(f"Already up to date (commit {commit_short})")
        return

    output.write_text(header + content, "utf-8")

    if old_commit:
        print(f"Updated from {old_commit} to {commit_short} ({commit_date})")
    else:
        print(f"Synced from commit {commit_short} ({commit_date})")
    print(f"Saved to {output}")


if __name__ == "__main__":
    main()
