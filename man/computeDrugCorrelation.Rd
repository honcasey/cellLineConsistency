% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/computeDrugCorrelation.R
\name{computeDrugCorrelation}
\alias{computeDrugCorrelation}
\title{Compute correlations between drugs sensitivity measures}
\usage{
computeDrugCorrelation(
  pSet,
  cellLines = "all",
  coefs,
  sensMeasures,
  pval = TRUE
)
}
\arguments{
\item{pSet}{Intersected PharmacoSet object containing common drugs and/or
cell lines, as returned by PharmacoGx::intersectPSet(). PharmacoSets
should have sensitivity information which can be checked using
PharmacoGx::availablePSets() in the 'type' column.}

\item{cellLines}{Character cell lines to keep in analysis. Default is all
common cell lines between PharmacoSets given in pSet ("all").}

\item{coefs}{Character of correlation coefficients of interest. Current options
are: "pearson", "spearman", "kendall".}

\item{sensMeasures}{Character of drug sensitivity measures of interest. Options
depend on the PharmacoSets chosen, and can be identified by looking at
names(pSetName@sensitivity[["profiles"]])}

\item{pval}{Logical of whether or not to include p-values of each
correlation coefficient. Default is TRUE.}
}
\value{
Returns a list of dataframes, one dataframe for each sensitivity
    measure of interest, where rows correspond to drugs and columns
    correspond to each type of correlation coefficient from coefs.
    Also includes p-values in columns is pval was set to TRUE.
}
\description{
Computes Pearson, Spearman, and/or Kendall Correlation Coefficients and
    associated p-values for specified drug sensitivity measures
    (such as IC50 of AUC) between common drugs of two or more
    PharmacoSets.
}
\examples{
# Intersect PharmacoSets of interest based on common cell lines
CTRP <- PharmacoGx::downloadPSet("CTRPv2_2015")
GRAY <- PharmacoGx::downloadPSet("GRAY_2013")
intersected <- PharmacoGx::intersectPSet(c(CTRP, GRAY),
    intersectOn = c("drugs", "cell.lines"))

cellLineCorrelations <- computeCellLineCorrelation(pSet = intersected,
    coefs = "pearson",
    sensMeasures = "aac_recomputed",
    pval = TRUE)
consistentLines <- getConsistentCellLines(cellLineCorrelations,
    sensMeasure = "aac_recomputed_corrs",
    coefName = "pearson")
drugAllCorrelations <- computeDrugCorrelation(intersected,
    coefs = "pearson",
    sensMeasures = "aac_recomputed")
drugConsistentCorrelations <- computeDrugCorrelation(intersected,
    cellLines = rownames(consistentLines),
    coefs = "pearson",
    sensMeasures = "aac_recomputed")

}
\references{
Smirnov P, Safikhani Z, El-Hachem N, Wang D, She A, Olsen C, Freeman M,
    Selby H, Gendoo D, Grossman P, Beck A, Aerts H, Lupien M, Haibe-Kains
    AG, (2016). “PharmacoGx: an R package for analysis of large
    pharmacogenomic datasets.” \emph{Bioinformatics (Oxford, England)}.
}
\author{
{Casey Hon, \email{casey.hon@mail.utoronto.ca}}
}
