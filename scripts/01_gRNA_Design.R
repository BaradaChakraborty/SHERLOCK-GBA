# ---
# Project: SHERLOCK-GBA
# Objective: Development of a Field-Deployable Molecular Diagnostic for Malaria
# Focus: Pathogen-Host Crosstalk and Neuro-inflammation
# ---

# Load essential libraries (Ensure these are in my renv.lock later)
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Biostrings")

library(Biostrings) # Standard for sequence analysis

# 1. Update the lockfile to include Biostrings and BiocManager
renv::snapshot()

# 1. Target Sequence: Plasmodium falciparum Kelch13 (PfK13) Propeller Domain
# This is a representative sequence fragment often targeted for diagnostics.
# Addressing the ICMR project requirement for drug-resistance genotyping.
pfk13_propeller <- DNAString("GGTGGATTTGATGGTGTAGAATATTTAAATTCGATGGAATTATTAGATATTAGTCAACAATGCTGG")

# 2. Define the gRNA Design Function
# Designing for Cas13a (SHERLOCK) which requires ~28nt guides.
design_cas13_guides <- function(target_seq, width = 28) {
  # Create vectors for all possible start and end positions
  starts <- 1:(length(target_seq) - width + 1)
  ends <- starts + width - 1
  
  # Generate a sliding window of views
  guides <- Views(target_seq, start = starts, end = ends)
  return(as.character(guides))
}

# 3. Generate Potential Guides
candidate_guides <- design_cas13_guides(pfk13_propeller)

# 4. Preliminary Filtering: GC Content (Targeting 40-60% for stability)
# This ensures high-sensitivity for field-deployable diagnostics.
guide_df <- data.frame(gRNA = candidate_guides)
guide_df$GC_content <- sapply(guide_df$gRNA, function(x) {
  sum(strsplit(x, "")[[1]] %in% c("G", "C")) / nchar(x) * 100
})

# Filter for optimal guides
# Filter for optimal guides (Adjusting to 25-45% for the AT-rich Plasmodium genome)
# This addresses the biochemical specificity needed for sensitive malaria diagnostics.
optimal_guides <- guide_df[guide_df$GC_content >= 25 & guide_df$GC_content <= 45, ]

# 5. Save Results to the created folders
# This maintains the professional structure for the IISER Pune review.
write.csv(optimal_guides, "results/candidate_gRNAs.csv", row.names = FALSE)

# Record dependencies for reproducibility as per CV standards
renv::snapshot()