The [ADReCS](http://www.bio-add.org/ADReCS) severity-grading model consists of three steps:
----
* Step1: Data input.
* Step2: Calculate ADR Severity_score.
* Step3: ADR Severity Grading.

Input files: *report_data.txt* and *drug_adr_ROR.txt*.
----
1. The [report_data.txt](https://github.com/yueqixuan/ADReCS-Severity-grading-model/blob/main/example_data/report_data.txt) needs four columns:
	* substance_name: drug name.
	* pt_term: ADR term.
	* report_source: adverse event reports ID (custom ID used for unique identification of reports).
	* reaction_outcome: outcome of the reaction in [FAERS](https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers/fda-adverse-event-reporting-system-faers-public-dashboard).
2. The [drug_adr_ROR.txt](https://github.com/yueqixuan/ADReCS-Severity-grading-model/blob/main/example_data/drug_adr_ROR.txt) needs three columns:
	* substance_name: drug name.
	* pt_term: ADR term.
	* drug_adr_pair_ROR: The reporting odds ratio (ROR) for ADR induced by Drug was calculated based on the two-by-two contingency table.
