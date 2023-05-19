The ADReCS severity-grading model consists of three steps:
Step 1: Data input
Step 2: Calculate ADR Severity_score
Step 3: ADR Severity Grading

The model's calculations rely on two input files: drug_adr_ROR.txt and report_data.txt.

1. The report_data.txt file has four columns:
	substance_name: Drug name
	pt_term: ADR Term
	report_source: Adverse event reports ID (custom ID used for unique identification of reports)
	reaction_outcome: Outcome of the reaction in FAERS

2. drug_adr_ROR.txt file has three columns:
	substance_name: Drug name
	pt_term: ADR Term
	drug_adr_pair_ROR: The reporting odds ratio (ROR) for ADR induced by Drug was calculated based on the two-by-two contingency table