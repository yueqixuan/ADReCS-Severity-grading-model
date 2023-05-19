library(data.table)
library(tidyr)

# Load report data
report_data <- fread("example_data/report_data.txt", sep = "\t")

# Load report statistical data（ROR of Drug-ADR pairs)
drug_adr_ROR <- fread("example_data/drug_adr_ROR.txt", sep = "\t")

# Count the number of occurrences of each outcome in Drug-ADR pairs
Statistical_outcome <- function(input_data){
  report_data_tmp1 <- input_data[, table(reaction_outcome), by = c("substance_name", "pt_term")]
  report_data_tmp2 <- input_data[, names(table(reaction_outcome)), by = c("substance_name", "pt_term")]
  names(report_data_tmp1)[3] <- "outcome_Freq"
  names(report_data_tmp2)[3] <- "outcome"
  report_data_tmp1$outcome <- report_data_tmp2$outcome
  report_data_tmp <- spread(report_data_tmp1, key = "outcome", value = "outcome_Freq")
  report_data_tmp[is.na(report_data_tmp)] <- 0
  setDF(report_data_tmp)
  report_data_tmp[, !names(report_data_tmp) %in% c("substance_name", "pt_term")] <- sapply(report_data_tmp[, !names(report_data_tmp) %in% c("substance_name", "pt_term")], as.integer)
  report_data_tmp
}
report_data_tmp <- Statistical_outcome(report_data)
rm(Statistical_outcome, report_data)

# Calculate the conditional probability (P(O|A)) for each outcome in the Drug-ADR pair
names(report_data_tmp)[names(report_data_tmp) %in% c("1", "2", "3", "4", "5") ] <- c("count_outcome_1", "count_outcome_2", "count_outcome_3", "count_outcome_4", "count_outcome_5")
setDT(report_data_tmp)
report_data_tmp[, c("P_outcome_1", "P_outcome_2", "P_outcome_3", "P_outcome_4", "P_outcome_5")] <- report_data_tmp[, c("count_outcome_1", "count_outcome_2", "count_outcome_3", "count_outcome_4", "count_outcome_5")] / rowSums(report_data_tmp[, c("count_outcome_1", "count_outcome_2", "count_outcome_3", "count_outcome_4", "count_outcome_5")])
report_data_tmp <- report_data_tmp[, .(substance_name, pt_term, P_outcome_1, P_outcome_2, P_outcome_3, P_outcome_4, P_outcome_5)]
report_data_tmp <- merge(report_data_tmp, drug_adr_ROR, by = c("substance_name", "pt_term"), all.x = T, sort = F)
rm(drug_adr_ROR)

# Calculate the ADR Severity_score for each Drug-ADR pair
wight_x <- c(1, 2, 3, 4, 5)
penalty_x <- c(5, 4, 3, 2, 1)
severity_function <- function(input_x){
  x <- input_x[1:5]
  ROR <- input_x[6]
  sum((wight_x * x)/(log2(penalty_x + 1) * (1 + exp(-log2(ROR)))))
}
report_data_tmp$Severity_score <- apply(report_data_tmp[, c("P_outcome_1", "P_outcome_2", "P_outcome_3", "P_outcome_4", "P_outcome_5", "drug_adr_pair_ROR")], 1, severity_function)

# Determine threshold boundaries
number_of_grade <- 5
df_threshold <- data.frame()
for (i in 1: number_of_grade) {
  a <- c(0, 0, 0, 0, 0)
  a[i] <- 1
  df_threshold <- rbind(df_threshold, data.table(matrix(a, nrow = 1)))
}
rm(a, i, number_of_grade)
names(df_threshold) <- c("P_outcome_1", "P_outcome_2", "P_outcome_3", "P_outcome_4", "P_outcome_5")
df_threshold$ROR <- Inf
df_threshold$threshold <- apply(df_threshold, 1, severity_function)
rm(severity_function, wight_x, penalty_x)
threshold_list <- c(0, df_threshold$threshold)
rm(df_threshold)

# ADR severity grading
report_data_tmp$severity_grade <- cut(report_data_tmp$Severity_score, breaks = threshold_list, labels = c("Mild", "Moderate", "Severe", "Lifethreatening", "Death"))
ADR_Severity_Grade <- report_data_tmp[, .(substance_name, pt_term, severity_grade)]
rm(threshold_list, report_data_tmp)
