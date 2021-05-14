#' Bind 2 factors
#'
#'Create a new factor from 2 existing factors where there are
#'a union of the levels of existing factors
#'
#' @param a  Factor a
#' @param b Factor b
#'
#' @return A new factor that binds a and b
#' @export
#'
#' @examples
#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
fbind <- function(a, b) {
  factor(c(as.character(a), as.character(b)))
}
