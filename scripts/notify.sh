#!/usr/bin/env bash
# Notification helper for Automate
# Sends notifications via available channels

set -euo pipefail

NOTIFY_TYPE="${1:-info}"
NOTIFY_MSG="${2:-No message provided}"
NOTIFY_TARGET="${3:-console}"

timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)

case "$NOTIFY_TARGET" in
    console)
        echo "[$timestamp] [$NOTIFY_TYPE] $NOTIFY_MSG"
        ;;
    github)
        # Post as issue comment (requires GITHUB_TOKEN)
        if [ -n "${GITHUB_TOKEN:-}" ] && [ -n "${ISSUE_NUMBER:-}" ]; then
            curl -s -X POST \
                -H "Authorization: token $GITHUB_TOKEN" \
                -H "Accept: application/vnd.github+json" \
                "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${ISSUE_NUMBER}/comments" \
                -d "{\"body\": \"📢 **[$NOTIFY_TYPE]** $NOTIFY_MSG\\n\\n*$timestamp*\"}"
        else
            echo "⚠️ GitHub notification requires GITHUB_TOKEN and ISSUE_NUMBER"
        fi
        ;;
    webhook)
        # Generic webhook notification
        if [ -n "${WEBHOOK_URL:-}" ]; then
            curl -s -X POST "$WEBHOOK_URL" \
                -H "Content-Type: application/json" \
                -d "{\"type\": \"$NOTIFY_TYPE\", \"message\": \"$NOTIFY_MSG\", \"timestamp\": \"$timestamp\"}"
        else
            echo "⚠️ Webhook notification requires WEBHOOK_URL"
        fi
        ;;
    *)
        echo "Unknown target: $NOTIFY_TARGET"
        exit 1
        ;;
esac
