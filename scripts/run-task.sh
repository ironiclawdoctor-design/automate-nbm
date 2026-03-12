#!/usr/bin/env bash
# Automate Task Runner
# Processes tasks submitted via GitHub Issues

set -euo pipefail

RESULT_FILE="/tmp/task-result.md"

echo "🤖 Automate Task Runner"
echo "========================"
echo "Task: ${TASK_TITLE:-Unknown}"
echo "Issue: #${ISSUE_NUMBER:-0}"
echo "Time: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo ""

# Parse task type from body
TASK_BODY="${TASK_BODY:-}"

# Initialize result
cat > "$RESULT_FILE" << EOF
### ✅ Task Processed

**Task:** ${TASK_TITLE:-Unknown}
**Processed at:** $(date -u +%Y-%m-%dT%H:%M:%SZ)

EOF

# Check if we can reach OpenClaw for AI-powered tasks
if [ -n "${OPENCLAW_TOKEN:-}" ]; then
    echo "🔗 OpenClaw token available — AI-powered processing enabled"
    echo "🔗 **AI Processing:** Available" >> "$RESULT_FILE"
else
    echo "ℹ️ No OpenClaw token — running in basic mode"
    echo "ℹ️ **AI Processing:** Not configured (add OPENCLAW_TOKEN secret)" >> "$RESULT_FILE"
fi

# SSH key check
if [ -n "${AUTOMATE_SSH_KEY:-}" ]; then
    echo "🔑 SSH key available for secure operations"
    mkdir -p ~/.ssh
    echo "$AUTOMATE_SSH_KEY" > ~/.ssh/automate_key
    chmod 600 ~/.ssh/automate_key
    echo "🔑 **Secure SSH:** Available" >> "$RESULT_FILE"
fi

echo "" >> "$RESULT_FILE"
echo "---" >> "$RESULT_FILE"
echo "*Task body for reference:*" >> "$RESULT_FILE"
echo "" >> "$RESULT_FILE"
echo "${TASK_BODY}" >> "$RESULT_FILE"

echo ""
echo "✅ Task processing complete. Results written to $RESULT_FILE"
