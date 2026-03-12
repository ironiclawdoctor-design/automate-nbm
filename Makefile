# =============================================================================
# Automate — Makefile
# =============================================================================
# Common operations for the AI Agent Agency + Task Automation platform.
#
# Usage:
#   make help          Show available targets
#   make list-agents   List all agents by department
#   make validate      Validate configs, agents, and workflows
#   make test          Run the test suite
# =============================================================================

.PHONY: help list-agents list-departments validate test test-agents test-config test-workflows test-scripts clean

SHELL := /bin/bash
AGENTS_DIR := agents
CONFIG_FILE := config/automate.yml
SCRIPTS_DIR := scripts
WORKFLOWS_DIR := .github/workflows
TESTS_DIR := tests

# Colors
GREEN  := \033[0;32m
YELLOW := \033[0;33m
RED    := \033[0;31m
CYAN   := \033[0;36m
RESET  := \033[0m

# ---------------------------------------------------------------------------
# Help
# ---------------------------------------------------------------------------
help: ## Show this help
	@echo ""
	@echo "Automate — Available targets:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(CYAN)%-20s$(RESET) %s\n", $$1, $$2}'
	@echo ""

# ---------------------------------------------------------------------------
# Agent Operations
# ---------------------------------------------------------------------------
list-agents: ## List all agents by department
	@echo ""
	@echo "$(GREEN)Agent Registry$(RESET)"
	@echo "=============="
	@for dept in $(AGENTS_DIR)/*/; do \
		dept_name=$$(basename "$$dept"); \
		count=$$(find "$$dept" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l); \
		if [ "$$count" -gt 0 ]; then \
			echo ""; \
			echo "$(YELLOW)$$dept_name$(RESET) ($$count profiles):"; \
			for f in "$$dept"*.md; do \
				[ -f "$$f" ] && echo "  - $$(basename "$$f" .md)"; \
			done; \
		fi; \
	done
	@echo ""
	@total=$$(find $(AGENTS_DIR) -name "*.md" -type f 2>/dev/null | wc -l); \
	echo "Total agent profiles: $$total"
	@echo ""

list-departments: ## List all departments
	@echo ""
	@echo "$(GREEN)Departments$(RESET)"
	@echo "==========="
	@for dept in $(AGENTS_DIR)/*/; do \
		dept_name=$$(basename "$$dept"); \
		count=$$(find "$$dept" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l); \
		echo "  $$dept_name ($$count agent profiles)"; \
	done
	@echo ""

# ---------------------------------------------------------------------------
# Validation & Testing
# ---------------------------------------------------------------------------
validate: test-agents test-config test-workflows test-scripts ## Run all validations
	@echo ""
	@echo "$(GREEN)✅ All validations passed$(RESET)"
	@echo ""

test: ## Run the full test suite
	@echo "Running test suite..."
	@echo ""
	@failed=0; \
	for t in $(TESTS_DIR)/test_*.sh; do \
		if [ -f "$$t" ]; then \
			echo "$(CYAN)▶ Running $$(basename $$t)$(RESET)"; \
			if bash "$$t"; then \
				echo "$(GREEN)  ✅ PASS$(RESET)"; \
			else \
				echo "$(RED)  ❌ FAIL$(RESET)"; \
				failed=$$((failed + 1)); \
			fi; \
			echo ""; \
		fi; \
	done; \
	if [ "$$failed" -gt 0 ]; then \
		echo "$(RED)$$failed test(s) failed$(RESET)"; \
		exit 1; \
	else \
		echo "$(GREEN)All tests passed$(RESET)"; \
	fi

test-agents: ## Validate agent definition files
	@echo "$(CYAN)Validating agent files...$(RESET)"
	@bash $(TESTS_DIR)/test_agent_configs.sh

test-config: ## Validate automate.yml configuration
	@echo "$(CYAN)Validating configuration...$(RESET)"
	@bash $(TESTS_DIR)/test_config.sh

test-workflows: ## Validate GitHub Actions workflow syntax
	@echo "$(CYAN)Validating workflows...$(RESET)"
	@bash $(TESTS_DIR)/test_workflows.sh

test-scripts: ## Validate scripts are executable and have shebangs
	@echo "$(CYAN)Validating scripts...$(RESET)"
	@bash $(TESTS_DIR)/test_scripts.sh

# ---------------------------------------------------------------------------
# Task Operations
# ---------------------------------------------------------------------------
run-task: ## Run a task (usage: make run-task AGENT=name TASK="description")
	@if [ -z "$(AGENT)" ] || [ -z "$(TASK)" ]; then \
		echo "Usage: make run-task AGENT=<agent-name> TASK=\"<description>\""; \
		echo "Example: make run-task AGENT=backend-architect TASK=\"Design a REST API\""; \
		exit 1; \
	fi
	@bash $(SCRIPTS_DIR)/run-task.sh "$(AGENT)" "$(TASK)"

dispatch: ## Dispatch a task (usage: make dispatch TASK="description")
	@if [ -z "$(TASK)" ]; then \
		echo "Usage: make dispatch TASK=\"<description>\""; \
		echo "  Optional: AGENT=<name> DEPARTMENT=<dept> ORCHESTRATE=true"; \
		exit 1; \
	fi
	@TASK_BODY="$(TASK)" AGENT="$(AGENT)" DEPARTMENT="$(DEPARTMENT)" \
		ORCHESTRATE="$(ORCHESTRATE)" bash $(SCRIPTS_DIR)/agent-dispatch.sh

# ---------------------------------------------------------------------------
# Maintenance
# ---------------------------------------------------------------------------
clean: ## Remove temporary files
	@rm -f /tmp/task-result.md /tmp/task-result.json /tmp/agent-result.md /tmp/orchestrator-result.md
	@echo "$(GREEN)Cleaned temporary files$(RESET)"
