#' Impute Local Haplotypes From Clustering Data
#'
#' `getHap()` is a wrapper around stats::cutree used to extract a given number
#' of clusters ,corresponding to local haplotypes (i.e. bin-markers alleles),
#' from a list of object of class "hclust" produced by `clusterPop()`
#' @param clust_list a list of object of class "hclust" as produced by
#' `clusterPop()`describing the tree of individuals produced by local
#' clustering.
#' @param k an integer with the desired number of groups (haplotypes) to
#' extract. This would be 2 for each parent of a diploid population.
#'
#' @return a list of vector corresponding to physical bins with group membership
#'  corresponding to local haplotypes.
#' @export
#'
#' @examples P1_hap_list <- getHap(P1_clust_list, k=2)
#' @importFrom stats cutree
getHap <- function(clust_list, k = 2) {
  hap_list <- lapply(clust_list, stats::cutree, k = k)
  return(hap_list)
}
