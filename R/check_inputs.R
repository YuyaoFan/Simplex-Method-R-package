#' Check Inputs for Linear Programming Problem
#'
#' This function checks the validity of inputs for a linear programming problem.
#'
#' @param c A numeric vector of coefficients for the objective function.
#' @param A A numeric matrix of coefficients for the constraints.
#' @param b A numeric vector of constants on the right-hand side of the constraints.
#' @param slack A numeric vector of indices for slack variables (forming the identity matrix).
#' @return NULL
#' @export
check_inputs <- function(c, A, b, slack) {
  # 检查 c 和 A 的维度
  if (length(c) != ncol(A)) {
    stop("The length of 'c' must match the number of columns in 'A'.")
  }

  # 检查 b 和 A 的维度
  if (length(b) != nrow(A)) {
    stop("The length of 'b' must match the number of rows in 'A'.")
  }

  # 检查 slack 和 A 的维度
  if (length(slack) != nrow(A)) {
    stop("The length of 'slack' must match the number of rows in 'A'.")
  }

  # 检查 A 是否为矩阵
  if (!is.matrix(A)) {
    stop("'A' must be a numeric matrix.")
  }

  # 检查 c、b、slack 是否为数值向量
  if (!is.numeric(c) || !is.numeric(b) || !is.numeric(slack)) {
    stop("'c', 'b', and 'slack' must be numeric vectors.")
  }

  # 检查 slack 是否为整数
  if (any(slack != as.integer(slack))) {
    stop("'slack' must contain integer values.")
  }

  # 如果所有检查通过，返回 NULL
  invisible(NULL)
}
