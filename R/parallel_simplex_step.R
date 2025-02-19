#' Parallel Simplex Step
#'
#' This function performs key steps of the simplex method in parallel, with cross-platform support.
#'
#' @param c A numeric vector of coefficients for the objective function.
#' @param A A numeric matrix of coefficients for the constraints.
#' @param b A numeric vector of constants on the right-hand side of the constraints.
#' @param B A numeric vector of indices for basic variables.
#' @param pcol The index of the entering variable (pivot column).
#' @param prow The index of the pivot row.
#' @param process A logical value indicating whether to print the simplex table.
#' @return A list containing updated values of `A`, `b`, `sigma`, and `B`.
#' @importFrom parallel makeCluster stopCluster detectCores
#' @importFrom foreach foreach %dopar%
#' @importFrom doParallel registerDoParallel
parallel_simplex_step <- function(c, A, b, B, pcol, prow, process) {
  n <- ncol(A)
  m <- nrow(A)

  b[prow] <- b[prow] / A[prow, pcol]
  A[prow, ] <- A[prow, ] / A[prow, pcol]

  # 非主元行索引
  non_pivot_rows <- setdiff(1:m, prow)

  update_row <- function(i, b, A, prow, pcol) {
    b[i] <- b[i] - b[prow] * A[i, pcol]
    A[i, ] <- A[i, ] - A[i, pcol] * A[prow, ]
    return(list(b = b[i], A_row = A[i, ]))
  }

  # 跨平台并行化
  if (.Platform$OS.type == "unix") {
    # Unix/Linux/macOS 使用 mclapply
    results <- mclapply(non_pivot_rows, update_row, b = b, A = A, prow = prow, pcol = pcol, mc.cores = detectCores() - 2)
  } else {
    # Windows 使用 foreach 和 doParallel
    cl <- makeCluster(detectCores() - 1)
    registerDoParallel(cl)

    # 使用 foreach 并行更新非主元行，使用 .export 参数
    results <- foreach(i = non_pivot_rows, .export = c("b", "A", "prow", "pcol")) %dopar% {
      update_row(i, b, A, prow, pcol)
    }
    stopCluster(cl)
  }

  b[non_pivot_rows] <- sapply(results, `[[`, "b")
  A[non_pivot_rows, ] <- do.call(rbind, lapply(results, `[[`, "A_row"))
  sigma <- c - colSums(c[B] * A)
  B[prow] <- pcol
  return(list(A = A, b = b, sigma = sigma, B = B))
}
