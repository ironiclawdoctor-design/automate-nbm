# Agent Registry

Quick reference for all 61 agents. Each agent has a dedicated persona file in `agents/<department>/`.

## How to Invoke

### Via GitHub Issue
Label your issue with `agent:<agent-name>` or `department:<department>`.

### Via Orchestrator
Create an issue with label `orchestrate` — the orchestrator selects agents automatically.

### Via OpenClaw
```bash
# Single agent
openclaw skill use agency-agents --agent <agent-name> "your task"

# Orchestrator
openclaw skill use agency-agents --agent orchestrator "your project"

# Department
openclaw skill use agency-agents --department <dept> "your task"
```

---

## 💻 Engineering (7)

| Agent | File | Specialty |
|---|---|---|
| `frontend-developer` | [frontend-developer.md](agents/engineering/frontend-developer.md) | React/Vue/Angular, responsive UI, performance |
| `backend-architect` | [backend-architect.md](agents/engineering/backend-architect.md) | API design, databases, microservices, cloud |
| `mobile-app-builder` | — | iOS/Android/cross-platform mobile apps |
| `ai-engineer` | — | ML, deep learning, AI integration |
| `devops-automator` | — | CI/CD, infrastructure, containers |
| `rapid-prototyper` | — | MVP/POC rapid development |
| `senior-developer` | — | Complex implementations, architecture decisions |

## 🎨 Design (7)

| Agent | File | Specialty |
|---|---|---|
| `ui-designer` | — | Visual design, components, design systems |
| `ux-researcher` | — | User research, usability testing |
| `ux-architect` | — | Technical UX architecture, CSS systems |
| `brand-guardian` | — | Brand strategy, consistency |
| `visual-storyteller` | — | Visual narratives, multimedia |
| `whimsy-injector` | — | Micro-interactions, brand personality |
| `image-prompt-engineer` | — | AI image generation prompts |

## 📢 Marketing (8)

| Agent | File | Specialty |
|---|---|---|
| `growth-hacker` | [growth-hacker.md](agents/marketing/growth-hacker.md) | User acquisition, conversion, viral loops |
| `content-creator` | — | Multi-platform content, editorial calendar |
| `twitter-engager` | — | Real-time engagement, thought leadership |
| `tiktok-strategist` | — | Viral content, algorithm optimization |
| `instagram-curator` | — | Visual storytelling, community |
| `reddit-community-builder` | — | Community operations, organic growth |
| `app-store-optimizer` | — | ASO, conversion optimization |
| `social-media-strategist` | — | Cross-platform strategy |

## 📊 Product (3)

| Agent | File | Specialty |
|---|---|---|
| `sprint-prioritizer` | — | Agile planning, backlog grooming |
| `trend-researcher` | — | Market intelligence, competitive analysis |
| `feedback-synthesizer` | — | User feedback analysis, insights |

## 🎬 Project Management (5)

| Agent | File | Specialty |
|---|---|---|
| `studio-producer` | — | High-level coordination, portfolio mgmt |
| `project-shepherd` | — | Cross-functional coordination |
| `studio-operations` | — | Daily efficiency, process optimization |
| `experiment-tracker` | — | A/B testing, experiment management |
| `senior-pm` | [project-manager-senior.md](agents/project-management/project-manager-senior.md) | Scope planning, task decomposition |

## 🧪 Testing (7)

| Agent | File | Specialty |
|---|---|---|
| `evidence-collector` | — | Screenshot QA, visual verification |
| `reality-checker` | [testing-reality-checker.md](agents/testing/testing-reality-checker.md) | Quality certification, release approval |
| `test-results-analyzer` | — | Test evaluation, coverage analysis |
| `performance-benchmarker` | — | Performance testing, load testing |
| `api-tester` | — | API validation, integration testing |
| `tool-evaluator` | — | Technical tool evaluation |
| `workflow-optimizer` | — | Process analysis, optimization |

## 🛟 Support (6)

| Agent | File | Specialty |
|---|---|---|
| `support-responder` | — | Customer service, ticket resolution |
| `analytics-reporter` | — | Data analysis, dashboards |
| `finance-tracker` | — | Financial planning, budgets |
| `infrastructure-maintainer` | — | System reliability, maintenance |
| `legal-compliance-checker` | — | Compliance, regulations |
| `executive-summary-generator` | — | C-suite communications |

## 🎯 Specialized (6)

| Agent | File | Specialty |
|---|---|---|
| `orchestrator` | [orchestrator/SKILL.md](orchestrator/SKILL.md) | Multi-agent dispatch core engine |
| `data-analytics-reporter` | — | Business intelligence |
| `lsp-index-engineer` | — | Code intelligence, LSP |
| `sales-data-extraction-agent` | — | Sales data extraction |
| `data-consolidation-agent` | — | Data consolidation |
| `report-distribution-agent` | — | Report distribution |

---

Agents marked with `—` have their persona defined in the SKILL.md catalog and will be expanded to individual files as the project develops. The 6 core agents with dedicated files are fully operational.
