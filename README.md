# sre-toolkit

A collection of Bash automation tools for system monitoring, log analysis, and disk alerting — built to simulate real SRE production workflows.

## Why This Exists

This project was built as part of a structured 6-month SRE/DevOps training program, focused on developing independent scripting and automation skills used in real production environments. Every script in this repo was written from scratch, tested locally, and refined through iterative code review — no AI-generated code, no copy-pasted solutions.

The goal: build the kind of muscle memory and troubleshooting instinct that real production incidents demand.

## Structure

```
sre-toolkit/
└── linux/
    ├── health_check.sh     # System health report — CPU, memory, disk, uptime, top processes
    ├── log_parser.sh       # Log analysis — error/warning/info counts, recent error extraction
    ├── disk_alert.sh       # Threshold-based disk usage alerting
    ├── run_all_checks.sh   # Orchestrator — runs all checks, saves timestamped reports
    └── sample.log          # Sample log file used for testing log_parser.sh
```

## Scripts

### `health_check.sh`
Generates a system health snapshot: hostname, uptime, CPU usage, memory usage, disk usage, and the top 3 processes by CPU consumption.

```bash
bash linux/health_check.sh


### `log_parser.sh`
Parses a log file and reports total line count, error/warning/info counts, and the 5 most recent errors. Exits with a clear alert status if errors are detected.

```bash
bash linux/log_parser.sh
```

### `disk_alert.sh`
Checks current disk usage against an 80% threshold and raises an alert if the threshold is breached — the core logic behind real disk-monitoring tools.

```bash
bash linux/disk_alert.sh
```

### `run_all_checks.sh`
Runs all three scripts above in sequence, saves their combined output to a timestamped report file under `linux/reports/`, and prints live progress to the screen. Designed to be cron-friendly for scheduled health checks.

```bash
bash linux/run_all_checks.sh
```

## Skills Demonstrated

- Bash scripting fundamentals: variables, command substitution, conditionals
- Text processing and data extraction with `awk`, `grep`, `tr`, `wc`
- Threshold-based alerting logic
- Log analysis and error detection
- Script composition and orchestration
- Output redirection and timestamped audit logging
- Git/GitHub version control workflow

## Roadmap

This toolkit is actively growing as part of an ongoing SRE training program:

- [x] **Phase 1 — Linux & Bash Foundations** (complete)
- [ ] **Phase 2 — Kubernetes, Observability & Incident Management**
- [ ] **Phase 3 — Python, Terraform, AWS, CI/CD**
- [ ] **Phase 4 — System Design & Reliability Engineering**
- [ ] **Phase 5 — Interview Simulation & Offer Preparation**

## Author

**Oluwaseyi Fayomade**
Senior SRE | Kubernetes • Terraform • AWS • Observability
[github.com/Oluwaseyi-Fayomade](https://github.com/Oluwaseyi-Fayomade)