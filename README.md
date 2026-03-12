# Automate

A persistent subagent for secure task automation, orchestrated via GitHub.

## What Is This?

**Automate** is a GitHub-native task delegation system. It uses GitHub Issues, Actions, and encrypted secrets to securely receive, execute, and report on automated tasks.

## How It Works

1. **Create an Issue** → Automate picks it up as a task
2. **GitHub Actions** runs the automation workflow
3. **Results posted** back to the issue as comments
4. **Secure comms** via GitHub's encrypted secrets and SSH

## Security Model

- All secrets stored in GitHub Encrypted Secrets (never in code)
- SSH key authentication (no passwords)
- Workflow permissions scoped to minimum required
- Audit trail via GitHub's native logging
- Branch protection available for approval gates

## Task Types

- 🔍 **Research** — web lookups, data gathering
- 📁 **File Operations** — generate, transform, organize
- 🔄 **Automation** — scheduled tasks via cron workflows
- 📊 **Reports** — compile and post summaries
- 🔗 **Integration** — bridge between services

## Usage

### Quick Task
```
Create a new issue with your task description.
Label it: `task`, `priority:high|medium|low`
```

### Scheduled Task
```
Edit .github/workflows/scheduled.yml with your cron expression.
```

### Secure Data
```
Add secrets via: Settings → Secrets and Variables → Actions
Reference in workflows as: ${{ secrets.YOUR_SECRET }}
```

## Structure

```
automate/
├── .github/
│   ├── workflows/
│   │   ├── task-runner.yml      # Triggered by new issues
│   │   ├── scheduled.yml        # Cron-based automation
│   │   └── secure-comm.yml      # Encrypted message relay
│   └── ISSUE_TEMPLATE/
│       └── task.md              # Task submission template
├── scripts/
│   ├── run-task.sh              # Main task executor
│   └── notify.sh                # Notification helper
├── config/
│   └── automate.yml             # Agent configuration
└── README.md
```

## License

Private — for authorized use only.
