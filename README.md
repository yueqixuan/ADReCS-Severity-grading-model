The [ADReCS](http://www.bio-add.org/ADReCS) severity-grading model consists of three steps:
----

* Step1: Data input<br>
* Step2: Calculate ADR Severity_score<br>
* Step3: ADR Severity Grading<br>

Input files: report_data.txt and drug_adr_ROR.txt.
----

1. The [report_data.txt](https://github.com/yueqixuan/ADReCS-Severity-grading-model/blob/main/example_data/report_data.txt) file needs four columns:<br>
	* substance_name: Drug name<br>
	* pt_term: ADR Term<br>
	* report_source: Adverse event reports ID (custom ID used for unique identification of reports)<br>
	* reaction_outcome: Outcome of the reaction in [FAERS](https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers/fda-adverse-event-reporting-system-faers-public-dashboard)<br>

2. The [drug_adr_ROR.txt](https://github.com/yueqixuan/ADReCS-Severity-grading-model/blob/main/example_data/drug_adr_ROR.txt) file needs three columns:<br>
	* substance_name: Drug name<br>
	* pt_term: ADR Term<br>
	* drug_adr_pair_ROR: The reporting odds ratio (ROR) for ADR induced by Drug was calculated based on the two-by-two contingency table
