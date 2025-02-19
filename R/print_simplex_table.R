#' Print Simplex Table
#'
#' This function prints the simplex table of a certain step
#'
#' @param CB A numeric vector representing the coefficients of the basic variables in the objective function
#' @param Base A numeric vector indicating the indices of the basic variables in the current simplex tableau
#' @param b A numeric vector representing the right-hand side values of the constraints (the constants in the equations)
#' @param A A numeric matrix representing the coefficients of the variables in the constraint (including slack variables)
#' @param sigma A numeric vector representing the reduced costs of the non-basic variables in the current simplex tableau
#' @param title A character string providing a title or description for the current simplex tableau
#'
#' @export

print_simplex_table <- function(CB, Base, b, A, sigma, title) {
  DF <- data.frame("CB" = CB, "Base" = Base, "b" = b, "x" = A)
  print(list("title" = title, "frame" = DF, "sigma" = sigma))
}
