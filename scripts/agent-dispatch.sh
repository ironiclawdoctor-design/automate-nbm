#!/usr/bin/env bash
# Agent Dispatch Script
# Routes tasks to the appropriate AI agent based on labels/input

set -euo pipefail

RESULT_FILE="/tmp/agent-result.md"
AGENTS_DIR="agents"

echo "🤖 Agent Dispatch"
echo "=================="
echo "Agent: ${AGENT:-auto}"
echo "Department: ${DEPARTMENT:-none}"
echo "Orchestrate: ${ORCHESTRATE:-false}"
echo "Task: ${TASK_TITLE:-Unknown}"
echo ""

# Resolve agent persona file
resolve_agent() {
  local agent_name="$1"
  local persona_file=""

  # Search all department directories
  for dept_dir in "$AGENTS_DIR"/*/; do
    for f in "$dept_dir"*.md; do
      if [ -f "$f" ]; then
        # Check if filename matches agent name
        local basename=$(basename "$f" .md)
        if [ "$basename" = "$agent_name" ] || echo "$basename" | grep -qi "$agent_name"; then
          persona_file="$f"
          break 2
        fi
      fi
    done
  done

  echo "$persona_file"
}

# Build result header
cat > "$RESULT_FILE" << EOF
## 🤖 Agent Task Result

**Task:** ${TASK_TITLE:-Unknown}
**Agent:** ${AGENT:-auto-detect}
**Processed:** $(date -u +%Y-%m-%dT%H:%M:%SZ)

---

EOF

# Find the agent persona
if [ -n "${AGENT:-}" ]; then
  PERSONA_FILE=$(resolve_agent "$AGENT")

  if [ -n "$PERSONA_FILE" ]; then
    echo "✅ Found agent persona: $PERSONA_FILE"
    echo "### Agent Persona Loaded" >> "$RESULT_FILE"
    echo "" >> "$RESULT_FILE"

    # Extract agent metadata from frontmatter
    AGENT_DESC=$(head -20 "$PERSONA_FILE" | grep "^description:" | sed 's/description: //' || echo "")
    AGENT_DEPT=$(head -20 "$PERSONA_FILE" | grep "^department:" | sed 's/department: //' || echo "")

    echo "- **Name:** $AGENT" >> "$RESULT_FILE"
    echo "- **Description:** $AGENT_DESC" >> "$RESULT_FILE"
    echo "- **Department:** $AGENT_DEPT" >> "$RESULT_FILE"
    echo "" >> "$RESULT_FILE"
  else
    echo "⚠️ No persona file found for: $AGENT (using catalog definition)"
    echo "### Agent: $AGENT" >> "$RESULT_FILE"
    echo "" >> "$RESULT_FILE"
    echo "ℹ️ This agent is defined in the catalog but doesn't have a dedicated persona file yet." >> "$RESULT_FILE"
    echo "" >> "$RESULT_FILE"
  fi
fi

# Department routing
if [ -n "${DEPARTMENT:-}" ]; then
  DEPT_AGENTS=$(find "$AGENTS_DIR/$DEPARTMENT/" -name "*.md" -type f 2>/dev/null | wc -l)
  echo "### Department: $DEPARTMENT" >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
  echo "- **Available agents:** $DEPT_AGENTS" >> "$RESULT_FILE"

  if [ "$DEPT_AGENTS" -gt 0 ]; then
    echo "- **Agents:**" >> "$RESULT_FILE"
    for f in "$AGENTS_DIR/$DEPARTMENT/"*.md; do
      [ -f "$f" ] && echo "  - $(basename "$f" .md)" >> "$RESULT_FILE"
    done
  fi
  echo "" >> "$RESULT_FILE"
fi

# AI-powered processing
if [ -n "${OPENCLAW_TOKEN:-}" ]; then
  echo "### 🧠 AI Processing" >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
  echo "OpenClaw token detected — AI-powered task execution is available." >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"

  # Here you would call the OpenClaw API to process the task
  # using the agent's persona as the system prompt
  echo "**Integration point:** The agent's persona file serves as the system prompt" >> "$RESULT_FILE"
  echo "for AI-powered task execution via the OpenClaw API." >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
else
  echo "### ℹ️ Basic Mode" >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
  echo "Add the \`OPENCLAW_TOKEN\` secret to enable AI-powered task execution." >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
fi

# SSH key setup
if [ -n "${AUTOMATE_SSH_KEY:-}" ]; then
  mkdir -p ~/.ssh
  echo "$AUTOMATE_SSH_KEY" > ~/.ssh/automate_key
  chmod 600 ~/.ssh/automate_key
  echo "🔑 SSH key loaded for secure operations" >> "$RESULT_FILE"
  echo "" >> "$RESULT_FILE"
fi

# Task body reference
echo "### 📝 Task Details" >> "$RESULT_FILE"
echo "" >> "$RESULT_FILE"
echo "${TASK_BODY:-No task body provided}" >> "$RESULT_FILE"
echo "" >> "$RESULT_FILE"

echo "---" >> "$RESULT_FILE"
echo "*🤖 Automate — $(date -u +%Y-%m-%dT%H:%M:%SZ)*" >> "$RESULT_FILE"

echo ""
echo "✅ Dispatch complete. Results: $RESULT_FILE"
