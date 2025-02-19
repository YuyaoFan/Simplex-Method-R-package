#' LPsimplex
#'
#' This function solves a linear programming problem using the simplex method
#'
#' @param c A numeric vector of coefficients for the objective function
#' @param A A numeric matrix of coefficients for the constraints (after adding slack variables)
#' @param b A numeric vector of constants on the right-hand side of the constraints
#' @param slack A numeric vector of indices for slack variables (forming the identity matrix)
#' @param max A logical value of indicating whether to maximize the objective function
#'   - 'TRUE': Maximize the objective function
#'   - 'FALSE': Minimize the objective function
#' @param process A logical value indicating whether to print the simplex table during the solving process
#'   - 'TRUE': Print the simplex table at each step
#'   - 'FALSE': Do not print the simplex table in the process
#' @return A list containing the optimal solution and the optimal value of the objective function
#' @examples
#' c=c(60,120,0,0,0)
#' A=matrix(c(9,3,4,4,10,5,1,0,0,0,1,0,0,0,1),3)
#' b=c(360,300,200)
#' slack=c(3,4,5)
#' result <- LPsimplex(c, A, b, slack, max = TRUE, process = TRUE)
#' print(result)
#' @export
LPsimplex <- function(c, A, b, slack, max = TRUE, process = TRUE) {
  if(!max) c <- -c
  check_inputs(c, A, b, slack)
  n <- ncol(A)
  m <- nrow(A)
  sol <- rep(0, n)
  sol[slack] <- b[1:length(slack)]
  B <- slack
  sigma <- c - c[slack] %*% A
  unbounded = FALSE
  print_simplex_table(c[B], B, b, A, sigma, "初始单纯形表")

  while (any(sigma > 0)) {
    infty <- which(sigma > 0)
    if (any(colSums(A[, infty, drop = FALSE] > 0) == 0)) {
      print("该问题存在无界解")
      unbounded = TRUE
      break
    }

    pcol <- which.max(sigma)
    sita0 <- b / A[, pcol]
    sita0[A[, pcol] <= 0] <- Inf
    prow <- which.min(sita0)
    B[prow] <- pcol

    b[prow] <- b[prow] / A[prow, pcol]
    A[prow, ] <- A[prow, ] / A[prow, pcol]

    non_pivot_rows <- setdiff(1:m, prow)
    b[non_pivot_rows] <- b[non_pivot_rows] - b[prow] * A[non_pivot_rows, pcol]
    A[non_pivot_rows, ] <- A[non_pivot_rows, ] - outer(A[non_pivot_rows, pcol], A[prow, ])

    sigma <- c - c[B] %*% A
    if(process) print_simplex_table(c[B], B, b, A, sigma, "过程单纯形表")
  }
  if(!unbounded){
  if (any(sigma[-B] == 0)) {
    print("该问题存在无穷多最优解")
  } else {
    print("该问题有唯一最优解")
  }

  print_simplex_table(c[B], B, b, A, sigma, "最终单纯形表")

  sol <- rep(0, n)
  sol[B] <- b[1:length(B)]
  if(max)return(list("最优解" = sol, "最大值" = sum(sol * c)))
  return(list("最优解" = sol, "最小值" = sum(sol * c)))}
  else{return(NULL)}
}
