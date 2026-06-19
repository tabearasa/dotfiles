---
name: glab-releases
description: Read and analyze gitlab releases from a project with the glab-cli.
allowed-tools: Bash, read, write
version: 1.0
---

Best practices and workflows using `glab` for releases.

## ⚠️ Message Escaping — Common Trap

If your message contains backticks (`), $, or other shell special characters, NEVER inline them directly in -m "...". The shell interprets backticks as command substitution, silently mangling your message and producing errors like /bin/bash: line 1: client_name: command not found. This has caused real production failures: agents posting malformed comments to GitLab MRs/issues, followed by apologetic correction notes

