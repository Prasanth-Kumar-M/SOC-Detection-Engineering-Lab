# Day 9 — Detection Engineering and Automated Validation

## Objective
Develop and validate a reusable detection for a direct
PowerShell-to-Notepad process creation relationship.

## Environment
Windows 11 domain-joined workstation
Domain: example.local
Telemetry: Sysmon Event ID 1
Language: PowerShell

## Detection Logic
Match when:
- Image ends with \notepad.exe
- ParentImage ends with \powershell.exe

## Test Cases
1. PowerShell -> Notepad
   Expected: True
   Actual: True
   Result: PASS

2. Notepad -> Notepad
   Expected: False
   Actual: False
   Result: PASS

## Validation Summary
Tests executed: 2
Tests passed: 2
Tests failed: 0

## Technical Contributions
- Parsed original Sysmon XML evidence.
- Evaluated immediate parent-child process relationships.
- Created a reusable PowerShell validation script.
- Implemented expected-versus-actual assertions.
- Exported results in CSV and JSON formats.

## Limitations
- Both test cases originate from one controlled lab scenario.
- The rule detects a process relationship, not malicious intent.
- No production false-positive rate was measured.
- No external validation or organizational adoption is claimed.
- Additional datasets and adversarial scenarios are required.

## Potential Broader Application
This methodology could be extended to automated regression
testing for endpoint detection rules in SOC environments.
That application has not yet been independently demonstrated.

## Future Work
- Expand positive and negative test datasets.
- Test other process relationships.
- Add additional behavioral context.
- Develop reusable detection test fixtures.
- Seek independent technical review.

## Evidence
test-detection.ps1
parent-event.xml
child-event.xml
detection-test-results.csv
detection-test-results.json
validation-results.csv
automated-validation.csv

