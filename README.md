The [ADReCS](http://www.bio-add.org/ADReCS) severity-grading model consists of three steps:
----

* Step1: Data input<br>
* Step2: Calculate ADR Severity_score<br>
* Step3: ADR Severity Grading<br>

The model's calculations rely on two input files: drug_adr_ROR.txt and report_data.txt.
----

1. The report_data.txt file has four columns:<br>
	* substance_name: Drug name<br>
	* pt_term: ADR Term<br>
	* report_source: Adverse event reports ID (custom ID used for unique identification of reports)<br>
	* reaction_outcome: Outcome of the reaction in [FAERS](https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers/fda-adverse-event-reporting-system-faers-public-dashboard)<br>

2. drug_adr_ROR.txt file has three columns:<br>
	* substance_name: Drug name<br>
	* pt_term: ADR Term<br>
	* drug_adr_pair_ROR: The reporting odds ratio (ROR) for ADR induced by Drug was calculated based on the two-by-two contingency table
