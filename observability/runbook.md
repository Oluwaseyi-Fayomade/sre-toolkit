# Incident Response Runbook — sre-toolkit

This runbook covers the three alerts defined in [`alert_rules.yaml`](../observability/alert_rules.yaml). For each alert, follow the steps in order: 
**Verify → Remediate → Escalate**.

## Alert: HighDiskUsage

**Severity:** Warning
**Condition:** Disk usage has exceeded 80% for more than 5 minutes.

### Verify
1. Run `disk_alert.sh` (or `df -h /`) on the affected host to confirm current usage.
2. Check whether usage is steadily climbing or was a sudden spike — `du -sh /var/log/* | sort -rh | head -10` to find what's consuming space.
3. Confirm the alert isn't a false positive from a temporary process (e.g. a backup job mid-run).

### Remediate
1. Identify and clear non-critical large files — old logs, temp files, unused Docker images (`docker system prune` if applicable).
2. If logs are the cause, check log rotation is configured correctly (`logrotate` status).
3. If usage is from legitimate growth (e.g. database size), consider resizing the volume rather than deleting data.
4. Re-run `disk_alert.sh` to confirm usage has dropped below threshold.

### Escalate
- If disk usage cannot be reduced and continues climbing, escalate to the infrastructure team to provision additional storage.
- If the disk is at risk of filling completely within the hour, treat as urgent and notify the on-call lead immediately, regardless of time of day.


## Alert: PodNotRunning

**Severity:** Critical
**Condition:** Pod has not been in `Running` state for over 2 minutes, indicating the service is likely unavailable.

### Verify
1. Run `pod_health_check.sh` (or `kubectl get pods`) to confirm the pod's current status.
2. Check pod events for the failure reason: `kubectl describe pod <pod-name>`.
3. Check logs for crash details: `kubectl logs <pod-name> --previous` (the `--previous` flag shows logs from the last crashed instance).

### Remediate
1. If the pod is `CrashLoopBackOff`, check the most recent log output for the specific error before restarting anything.
2. If the cause is a bad deployment/image, roll back: `kubectl rollout undo deployment/<deployment-name>`.
3. If the cause is a resource limit (OOMKilled), check `resource_report.sh` output and consider increasing memory/CPU limits.
4. If the node itself is unhealthy, check `kubectl get nodes` — the issue may not be the pod at all.
5. Confirm recovery: re-run `pod_health_check.sh` until status shows all pods healthy.

### Escalate
- If the pod cannot be recovered within 15 minutes, or the root cause is unclear, escalate to the service owner immediately — this alert means the service is likely down for users right now.
- If this affects a customer-facing service, notify the incident commander / on-call lead per standard escalation policy.


## Alert: HighPodRestarts

**Severity:** Warning
**Condition:** Pod has restarted more than 3 times, suggesting an underlying stability issue such as a crash loop or misconfiguration.

### Verify
1. Run `restart_detector.sh` (or `kubectl get pods`) to confirm the current restart count.
2. Check `kubectl describe pod <pod-name>` for the `Last State` and exit code of the most recent crash.
3. Check logs from the previous crashed instance: `kubectl logs <pod-name> --previous`.
4. Determine if restarts are increasing in frequency (escalating) or stable/intermittent (lower urgency).

### Remediate
1. If the exit code indicates an application error (e.g. unhandled exception), this is likely a code/config issue — coordinate with the service owner.
2. If the exit code is `137` (OOMKilled), check memory limits via `resource_report.sh` and increase if the workload genuinely needs more memory.
3. If restarts coincide with a recent deployment, consider rolling back: `kubectl rollout undo deployment/<deployment-name>`.
4. Monitor for 10–15 minutes after any fix to confirm restarts have stopped.

### Escalate
- If restarts continue after remediation attempts, or the cause is not clear from logs, escalate to the service owner for deeper investigation.
- If restart frequency is increasing rapidly (e.g. multiple restarts within minutes), treat with the same urgency as `PodNotRunning`, since the service may become fully unavailable.


## General Escalation Path

1. **On-call engineer** (you) — initial triage, verify and attempt remediation.
2. **Service owner** — if the root cause is application-specific and outside infrastructure scope.
3. **Infrastructure/Platform team** — if the root cause is cluster, node, or storage capacity related.
4. **Incident commander** — if the issue is customer-facing, prolonged, or requires cross-team coordination.


## Post-Incident

After any alert is resolved:
- Document what happened, what was checked, and what fixed it (even briefly) — this is the raw material for a postmortem.
- If this is a recurring issue, consider whether the alert threshold, remediation steps, or underlying system design needs to change.