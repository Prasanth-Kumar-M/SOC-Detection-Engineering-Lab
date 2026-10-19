# Day 8 — SOC Alert Investigation

## Scenario
A controlled lab test generated a process execution alert involving PowerShell and Notepad.

## Environment
Windows 11 workstation
Active Directory domain: example.local
Telemetry: Sysmon Event ID 1

## Investigation
The analyst reviewed the Day 7 detection CSV and correlated it with original Sysmon process creation events.

Verified process lineage:

PowerShell.exe
    |
    v
Notepad.exe (PID 5516)
    |
    v
Notepad.exe (PID 2500)

The initial CSV and one retrieved event showed different immediate parent processes. Correlation using ProcessGuid and ParentProcessGuid established the multi-process execution chain.

## Findings
- The activity was generated intentionally during an authorized lab test.
- Original Sysmon events were recovered.
- Process GUIDs were used to validate process relationships.
- Raw XML events were archived.
- SHA-256 hashes were recorded for evidence integrity.

## SOC Assessment
Severity: Informational
Disposition: Benign — Authorized Lab Activity
Escalation: Not required based on available evidence

## Detection Limitations
A PowerShell-to-Notepad relationship alone does not establish malicious activity.
Additional context and behavioral correlation are required before escalation.

## Lessons Learned
- A detection match is not proof of compromise.
- Original telemetry should be checked against exported alerts.
- Process GUID correlation helps reconstruct process lineage.
- Evidence integrity and reproducibility matter.

## Future Work
Improve the detection, test positive and negative scenarios, and document false-positive limitations.

