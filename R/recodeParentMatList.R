#' Re-code Bi-parental Dosages Matrix
#'
#' `recodeParentMatList()` re-code a chromosomal bi-parental dosage matrix into
#'  2 parental integer matrix representing presence / absence data of parent
#'  specific variant encoded under their simplest form (e.g. 1x2 -> 1x0).
#' @param dosages_matrix an integer matrix with variant in rows
#'  and individuals, parents and marker physical position (in bp) in columns.
#' @param P1_name a character vector with the sample names of parent 1.
#' @param P2_name a character vector with the sample names of parent 2.
#' @param snp_pos_colname a character vector with the column name of marker
#' position.
#' @return return a list of 2 (male and female) integer matrix with with variant
#'  in rows and individuals, parents and marker position in columns.
#' @export
#'
#' @examples parent_mat_list<- recodeParentMatList(dosages_matrix,
#'                                                 "P1",
#'                                                 "P2",
#'                                                 "pos")
recodeParentMatList <- function(dosages_matrix, P1_name, P2_name,
                                snp_pos_colname = "pos") {
  ## Encode dosage data as binary and simplified form
  # get offspring columns
  pop <- !(colnames(dosages_matrix) %in% c(P1_name, P2_name, snp_pos_colname))

  # get 1x0
  pos1x0 <- dosages_matrix[, P1_name] == 1 & dosages_matrix[, P2_name] == 0
  # re-encode 2 -> 1
  dosages_matrix[pos1x0, pop][dosages_matrix[pos1x0, pop] == 2] <- 1

  # get 1x2
  pos1x2 <- dosages_matrix[, P1_name] == 1 & dosages_matrix[, P2_name] == 2
  # re-encode 0 -> 1 THEN 2 -> 0
  dosages_matrix[pos1x2, pop][dosages_matrix[pos1x2, pop] == 0] <- 1
  dosages_matrix[pos1x2, pop][dosages_matrix[pos1x2, pop] == 2] <- 0

  # get 0x1
  pos0x1 <- dosages_matrix[, P1_name] == 0 & dosages_matrix[, P2_name] == 1
  # re-encode 2 -> 1
  dosages_matrix[pos0x1, pop][dosages_matrix[pos0x1, pop] == 2] <- 1

  # get 2x1
  pos2x1 <- dosages_matrix[, P1_name] == 2 & dosages_matrix[, P2_name] == 1
  # re-encode 0 -> 1 THEN 2 -> 0
  dosages_matrix[pos2x1, pop][dosages_matrix[pos2x1, pop] == 0] <- 1
  dosages_matrix[pos2x1, pop][dosages_matrix[pos2x1, pop] == 2] <- 0

  ## Turn all -1 into NA
  dosages_matrix[dosages_matrix == -1] <- NA

  ## Export female and male matrix
  dosages_list <- list(
    dosages_matrix[
      pos1x0 | pos1x2,
      !(colnames(dosages_matrix) %in% c(
        P1_name,
        P2_name
      ))
    ],
    dosages_matrix[
      pos0x1 | pos2x1,
      !(colnames(dosages_matrix) %in% c(
        P1_name,
        P2_name
      ))
    ]
  )
  names(dosages_list) <- c("P1", "P2")

  return(dosages_list)
}
