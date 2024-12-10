#import data
##OR meta-analysis ISrecurrence
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = d2)
summary(res)
forest(res)
metabias(res, method.bias = "linreg", k.min = 10)
funnel(res, common=FALSE, studlab=TRUE, pos.studlab = 4)

# supplementary analysis ISrecurrence -------------------------------------
##byvar risk of bias
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=`Overall quality`,
               data = d2)
##byvar AFsearch
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=`AF search`,
               data = d2)
##byvar PSM vs unmatched
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=cohorts,
               data = d2)
##byvar Source
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=Source,
               data = d2)
##byvar timing of assessment of outcome (T)
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=FUP_duration,
               data = d2)
##byvar TIA or IS as a population
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=`IS/TIA or both`,
               data = d2)
#restricting to those with IS as outcome
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               byvar=Recurrence,
               data = d2)

# metaregressions ----------------------------------------------------------
##metareg CHADSVASC
dREG <- d %>%
  select(Author, Year, KAF_n, AFDAS_n, KAF_ISrecurrence, AFDAS_ISrecurrence,
         CHADS_ratio,
  )
dREG <- dREG[complete.cases(dREG),]
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = dREG)
perform_metareg_with_plot(res, ~ CHADS_ratio)
bubble(m1)

##metareg anticoagulation
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = dREG)
perform_metareg_with_plot(res, ~AFDAS_KAF_anticoag_ratio)

##metareg female
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = dREG)
perform_metareg_with_plot(res, ~F_ratio, "Female ratio")

##metareg FUP category
res <- metabin(event.e = AFDAS_ISrecurrence, n.e = AFDAS_n,
               event.c = KAF_ISrecurrence, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = dREG)
m1<- metareg(res, ~FUP_duration)
perform_metareg_with_plot(res, ~FUP_duration)

# Plot the meta-regression results
ggplot(coef_data, aes(x = FUP_duration, y = estimate)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = ci.lb, ymax = ci.ub), width = 0.05) +
  labs(title = "Meta-Regression Results",
       x = "Follow-Up Duration",
       y = "Effect Size Estimate (Log RR)") +
  theme_minimal()

ggplot(coef_data, aes(x = FUP_duration, y = estimate)) +
  geom_point(size = 4, color = "darkorange") +
  geom_errorbar(aes(ymin = ci.lb, ymax = ci.ub), width = 0.1, color = "darkblue") +
  geom_line(aes(group = 1), color = "grey", linetype = "dashed") +
  labs(title = "Meta-Regression Results",
       subtitle = "Effect of Follow-Up Duration on Recurrence Rate",
       x = "Follow-Up Duration",
       y = "Effect Size Estimate (Log RR)",
       caption = "Data source: Your Study") +
  theme_minimal(base_size = 8) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "black")
  )

# gosh --------------------------------------------------------------------
library(metafor)
data <- data %>%
  mutate(
    AFDAS_ISrecurrence = AFDAS_ISrecurrence + 0.5,
    KAF_ISrecurrence = KAF_ISrecurrence + 0.5,
    AFDAS_n = AFDAS_n + 0.5,
    KAF_n = KAF_n + 0.5
  )
data <- data %>%
  mutate(
    RR = (AFDAS_ISrecurrence / AFDAS_n) / (KAF_ISrecurrence / KAF_n),
    var_RR = (1 / AFDAS_ISrecurrence) + (1 / AFDAS_n) + (1 / KAF_ISrecurrence) + (1 / KAF_n)
  )

meta_analysis <- rma(yi = log(RR), vi = var_RR, data = data, method = "REML")
gosh_analysis <- gosh(meta_analysis)
# Plot GOSH with the impact of study 
plot(gosh_analysis, out=5)
leave1out(meta_analysis, trans=exp)

# mortalityRR -------------------------------------------------------------
res <- metabin(event.e = AFDAS_mortality, n.e = AFDAS_n,
               event.c = KAF_mortality, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = d3)
metabias(res, method.bias = "linreg", k.min = 13)
funnel.meta(res, studlab=TRUE, pos.studlab = 4, common=FALSE)

# anyICH -------------------------------------------------------------
res <- metabin(event.e = AFDAS_anyICH, n.e = AFDAS_n,
               event.c = KAF_anyICH, n.c = KAF_n,
               studlab = paste(Author, Year), 
               sm = "RR",
               data = d3)
# prevalence estimate per time --------------------------------------------
#recall dataset
d <- dataframe

# Function to perform meta-analysis on annualized rates
annualizedrate_meta <- function(outcome, denominator, follow_up_col, d, subgroup_filter = "all") {
  d_filtered <- d_filtered %>% mutate(person_years = !!sym(denominator) * !!sym(follow_up_col))
  prop <- metarate(
    event = d_filtered[[outcome]], 
    time = d_filtered$person_years,
    studlab = paste(d_filtered$Author, d_filtered$Year), 
    sm = "IR", random = TRUE
  )
  return(prop)
}

# List numerators and denominators for AFDAS group
outcomes_afdas <- c("AFDAS_ISrecurrence", "AFDAS_anyICH", "AFDAS_mortality", "AFDAS_anystroke")
denominator_afdas <- "AFDAS_n"
follow_up_col <- "FUP_years"

# Run meta-analysis for each outcome with annualized rates for AFDAS group
meta_results_afdas <- lapply(outcomes_afdas, function(outcome) {
  result <- annualizedrate_meta(outcome, denominator_afdas, follow_up_col, d)
  return(list(outcome = outcome, meta = result))
})

# Create a table for AFDAS results
result_table_afdas <- data.frame(
  Outcome = sapply(meta_results_afdas, function(res) res$outcome),
  Rate_Estimate = round(exp(sapply(meta_results_afdas, function(res) res$meta$TE.random)), 2),
  Lower_CI = round(exp(sapply(meta_results_afdas, function(res) res$meta$lower.random)), 2),
  Upper_CI = round(exp(sapply(meta_results_afdas, function(res) res$meta$upper.random)), 2),
  I2 = round(sapply(meta_results_afdas, function(res) res$meta$I2), 2),
  p_Heterogeneity = round(sapply(meta_results_afdas, function(res) res$meta$pval.Q), 2)
)
print(result_table_afdas)

# Repeat for KAF group
outcomes_kaf <- c("KAF_ISrecurrence", "KAF_anyICH", "KAF_mortality", "KAF_anystroke")
denominator_kaf <- "KAF_n"

# Run meta-analysis for each outcome with annualized rates for KAF group
meta_results_kaf <- lapply(outcomes_kaf, function(outcome) {
  result <- annualizedrate_meta(outcome, denominator_kaf, follow_up_col, d)
  return(list(outcome = outcome, meta = result))
})

# Create a table for KAF results
result_table_kaf <- data.frame(
  Outcome = sapply(meta_results_kaf, function(res) res$outcome),
  Rate_Estimate = round(exp(sapply(meta_results_kaf, function(res) res$meta$TE.random)), 2),
  Lower_CI = round(exp(sapply(meta_results_kaf, function(res) res$meta$lower.random)), 2),
  Upper_CI = round(exp(sapply(meta_results_kaf, function(res) res$meta$upper.random)), 2),
  I2 = round(sapply(meta_results_kaf, function(res) res$meta$I2), 2),
  p_Heterogeneity = round(sapply(meta_results_kaf, function(res) res$meta$pval.Q), 2)
)
print(result_table_kaf)