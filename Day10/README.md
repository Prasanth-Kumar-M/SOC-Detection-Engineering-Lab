Day 10 — SOC L2 Cross-Log Correlation Investigation



Overview



This project demonstrates an evidence-based SOC investigation using two Windows telemetry sources: Sysmon Event ID 1 and Windows Security Event ID 4688.



The objective was to reconstruct a controlled PowerShell-to-Notepad execution sequence, correlate process identifiers across log sources, and document a defensible SOC disposition.



Investigation Workflow



Generated authorized process activity in a Windows 11 VirtualBox lab.



Collected Sysmon Event ID 1 process creation records.



Identified corresponding Windows Security Event ID 4688 records.



Correlated process IDs, parent process IDs, timestamps, and executable paths.



Exported four original event XML records into private evidence storage.



Generated SHA-256 hashes and verified all four files against the recorded manifest.



Documented the investigation findings and limitations.



Observed Process Chain



powershell.exe

&#x20;   PID: 9404

&#x20;      |

&#x20;      v

notepad.exe

&#x20;   PID: 4952

&#x20;      |

&#x20;      v

notepad.exe

&#x20;   PID: 10916



Investigation Results



Metric



Result



Sysmon events analyzed



2



Security 4688 events analyzed



2



Correlated process creations



2



Evidence integrity verification



4/4 PASS



Investigation disposition



Informational — authorized lab activity



Technical Findings



Sysmon and Windows Security auditing independently recorded the investigated process creation activity.



Decimal and hexadecimal process identifiers were reconciled to confirm matching records.



The observed parent-child relationships were consistent across both telemetry sources.



The activity was generated intentionally and did not warrant escalation within the controlled scenario.



Process creation telemetry alone does not establish malicious intent.



Repository Files



investigation-report.md — Investigation methodology, timeline, findings, and limitations.



correlation-results.csv — Sanitized summary of the two correlated process creation events.



README.md — Project overview and results.



Evidence Handling



Original Sysmon and Windows Security XML records are retained privately.



The public CSV contains summarized observations rather than raw event records. The original evidence and private SHA-256 manifest are not published.



Limitations



This exercise examined a controlled process chain and a narrow investigation window.



It does not demonstrate production detection accuracy, complete endpoint compromise assessment, or validation against real malicious activity.



Key Takeaway



One process execution can produce multiple telemetry records. Correlation provides stronger evidence than relying on a single alert.



The investigation demonstrates foundational SOC skills in process lineage analysis, event correlation, evidence handling, and technical reporting.

