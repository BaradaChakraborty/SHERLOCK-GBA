# ---
# Project: SHERLOCK-GBA
# Script: 02_GBA_Correlation.R
# Objective: Modeling the link between Pathogen Genotype and Neuro-inflammation
# ---

# 1. Load Libraries

# Load essential libraries (Ensure these are in my renv.lock later)
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("tidyverse")
library(tidyverse)
library(ggplot2)

# 2. Creating a Synthetic Cohort (Reflecting trans-kingdom dialogues)
# We hypothesize that drug-resistant PfK13 mutants correlate with higher 
# systemic stress and hypothalamic microglial disruption.
set.seed(2026)
n_samples <- 100

gba_model <- data.frame(
  Sample_ID = paste0("GBA_", 1:n_samples),
  Parasite_Load = runif(n_samples, 50, 15000),
  Genotype = sample(c("Wild_Type", "PfK13_Mutant"), n_samples, replace = TRUE)
)

# 3. Integrating My Established Neuro-Immune Markers
# Modeling CX3CR1 downregulation and Iba1+ intensity as infection severity increases.
gba_model <- gba_model %>%
  mutate(
    Iba1_Intensity = (0.6 * Parasite_Load / 100) + 
      ifelse(Genotype == "PfK13_Mutant", 50, 20) + rnorm(n_samples, 0, 10),
    CX3CR1_Expression = 100 - (0.4 * Iba1_Intensity) + rnorm(n_samples, 0, 5)
  )

# 4. Visualizing the Correlation for the PhD Portfolio
gba_plot <- ggplot(gba_model, aes(x = Iba1_Intensity, y = CX3CR1_Expression, color = Genotype)) +
  geom_point(alpha = 0.6, size = 3) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed") +
  theme_minimal() +
  labs(
    title = "Neuro-Immune Set-Points during Plasmodium Infection",
    subtitle = "Correlation between Microglial Activation (Iba1) and Checkpoint Expression (CX3CR1)",
    x = "Microglial Activation (Iba1+ Intensity)",
    y = "CX3CR1 Relative Expression (%)"
  )

# 5. Save Results
ggsave("figures/GBA_Microglia_Correlation.png", gba_plot, width = 8, height = 6)
write.csv(gba_model, "results/GBA_simulation_results.csv", row.names = FALSE)

# Record dependencies for reproducibility
renv::snapshot()