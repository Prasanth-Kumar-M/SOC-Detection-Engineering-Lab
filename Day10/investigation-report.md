Day 10 — SOC L2 Cross-Log Investigation



Investigation Summary



Investigation date: October 19, 2026

Environment: Isolated Windows 11 cybersecurity lab

Telemetry: Sysmon Event ID 1 and Windows Security Event ID 4688

Investigation type: Process creation and parent-child correlation

Disposition: Informational — authorized laboratory activity



Objective



Correlate Windows process creation telemetry from two event sources to reconstruct a controlled execution sequence and validate the investigation findings.



Scenario



PowerShell was used to launch Notepad during an authorized lab exercise.



Sysmon recorded the initial process creation and an additional Notepad-related process. Windows Security auditing independently recorded the corresponding process creation events.



Process Timeline



Sequence



Process



PID



Parent PID



Sysmon Record



Security Record



1



PowerShell



9404



Not assessed



—



—



2



Notepad



4952



9404



105510



42337



3



Additional Notepad



10916



4952



105511



42338



The observed process creation events occurred at approximately 9:10:01 PM local time on October 19, 2026.



Cross-Log Correlation



Windows Security Event ID 4688 records process IDs in hexadecimal notation, while the Sysmon records examined in this investigation displayed decimal process IDs.



The identifiers were correlated as follows:



PowerShell: decimal 9404 / hexadecimal 0x24BC



Initial Notepad: decimal 4952 / hexadecimal 0x1358



Additional Notepad: decimal 10916 / hexadecimal 0x2AA4



The corresponding process names, timestamps, and parent-child relationships support the conclusion that both event sources describe the same controlled execution sequence.



Privilege Context



Sysmon reported high integrity for the Notepad process.



Windows Security Event ID 4688 recorded an elevated token type.



This is consistent with the controlled activity being launched from an elevated PowerShell session. Elevated execution alone does not establish malicious behavior.



Evidence Integrity



Four original event records were exported into a private evidence directory:



sysmon-105510.xml



sysmon-105511.xml



security-42337.xml



security-42338.xml



SHA-256 hashes were generated and recorded in an evidence manifest.



Subsequent integrity verification returned 4/4 PASS.



The original event XML files and full hash manifest are retained privately and are not included in the public repository.



Investigation Findings



Two Windows telemetry sources independently recorded the controlled process execution.



Process identifiers and parent-child relationships were consistent across the reviewed records.



The additional Notepad process demonstrates why analysts should examine full process lineage instead of assuming one application launch corresponds to one process.



The observed activity matched the authorized laboratory scenario.



The reviewed records did not independently establish malicious activity.



SOC Disposition



Classification: Informational / Authorized Lab Activity



Escalation: Not required for the controlled scenario.



Rationale: The execution was intentionally generated and the observed process relationships were consistent with the expected lab activity.



Limitations



The investigation examined a narrow time window and a limited set of process creation records.



No complete endpoint compromise assessment was performed.



No production detection accuracy or false-positive rate was measured.



SHA-256 verification confirms consistency with the recorded hashes, not independent authenticity or full forensic chain of custody.



The findings should not be generalized to unrelated PowerShell executions.



Lessons Learned



A process creation alert is an investigation starting point, not an incident verdict.



Correlating multiple telemetry sources strengthens confidence in process relationships and provides a more defensible investigation timeline.



Detect the activity. Correlate the evidence. Validate the conclusion.

