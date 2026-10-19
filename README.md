# SOC Alert Triage & Detection Validation

## The Scenario

A SOC analyst receives an alert showing that PowerShell
launched Notepad.

Should the analyst escalate it as a security incident?

Not necessarily.

The goal of this lab is to investigate the alert, verify
the process relationship, and make an evidence-based
SOC triage decision.

## Lab Environment

- Windows 11 domain-joined workstation
- Windows Server 2022 Active Directory lab
- Microsoft Sysmon
- Windows PowerShell
- VirtualBox

## Day 8 — SOC Investigation

We investigated a controlled PowerShell-to-Notepad
process creation event.

Investigation activities:
- Reviewed the original Sysmon Event ID 1 telemetry
- Compared exported alert fields with original events
- Examined process GUID relationships
- Reconstructed relevant process lineage
- Exported XML evidence
- Calculated SHA-256 hashes
- Documented the SOC disposition

SOC conclusion:
Informational — authorized benign lab activity.

The observed process relationship alone does not
establish malicious behavior.

## Day 9 — Detection Engineering

We developed a reusable PowerShell script to detect
a direct PowerShell-to-Notepad process relationship.

Detection conditions:
- Image ends with \notepad.exe
- ParentImage ends with \powershell.exe

## Test Results

| Test | Expected | Actual | Result |
|------|----------|--------|--------|
| PowerShell to Notepad | True | True | PASS |
| Notepad to Notepad | False | False | PASS |

Total: 2 tests passed out of 2.

These results validate the rule against two controlled
test cases, not production detection accuracy.

## Technical Skills Demonstrated

- SOC alert triage
- Sysmon Event ID 1 analysis
- Process lineage investigation
- PowerShell automation
- Detection engineering
- Positive and negative testing
- Evidence preservation
- SHA-256 integrity verification
- Technical report writing

## Limitations

- Single controlled lab scenario
- Only two automated test cases
- No production deployment
- No measured production false-positive rate
- No external validation
- Detection of this relationship does not prove compromise

## Future Improvements

- Add more benign and adversarial test cases
- Test other parent-child process relationships
- Improve detection context and rule quality
- Develop Sigma detection equivalents
- Evaluate rules with additional datasets

## Repository Contents

Day08/
- investigation-report.md

Day09/
- detection-engineering-report.md
- test-detection.ps1
- validation-results.csv

## Responsible Disclosure

This project documents activity performed in an
authorized, isolated cybersecurity home lab.

The examples are educational and do not represent
a real-world security compromise.

## Evidence Provenance

The public XML fixtures are synthetic examples created
for reproducible testing. They are not original Sysmon
events.

The original Sysmon telemetry and associated SHA-256
records are retained separately in the private lab archive.

The two passing tests demonstrate expected behavior
for these specific fixtures only.
