# OutcrossSeqDiploidR

## Description
This repository contains the R code for a package implementing the OutcrossSeqDiploidR algorithm.
Following the idea of OutcrossSeq[<https://doi.org/10.1016/j.molp.2021.01.003>],
OutcrossSeqDiploidR contains the functions necessary to locally infer bin-markers using sequence variants called from low coverage sequencing data of a diploid outcrossing population.
Parent specific variants within bins of arbitrary length are used to calculate local distance between individuals.
This distance information is then used to cluster individuals into local bin-markers alleles.
Those inferred bin-markers are further quality checked based on recombination frequency and deviation from local transmission ratio.

## Installation
Install using `devtools`:
```
devtools::install_github("https://github.com/ccrclot/OutcrossSeqDiploidR")
```
## Vignette
You can install the vignette and view it locally by using the code below (will take a couple minutes).
```
devtools::install_github("https://github.com/ccrclot/OutcrossSeqDiploidR", build_vignette = T)
browseVignettes("OutcrossSeqDiploidR")
```
