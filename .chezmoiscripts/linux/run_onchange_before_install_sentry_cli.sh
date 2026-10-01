#!/bin/sh
set -e

# New Sentry CLI (https://cli.sentry.dev), installed as `sentry`.
# SENTRY_URL is required: the setup step reads ~/.sentryclirc (shared with the
# legacy sentry-cli) and refuses its self-hosted URL without a matching host.
# Update later with `sentry cli upgrade`.
if command -v sentry >/dev/null; then
  echo "Already sentry installed!"
else
  curl -fsS https://cli.sentry.dev/install | SENTRY_URL=https://sentry.example.com bash
fi
