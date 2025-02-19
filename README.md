# Simplex-Method-R-package
The simplex method is a fast and efficient algorithm for solving linear programming. Inspired by the optimization method and the simplex method in Seminar 1, this project considers programming the method with existing knowledge because the simplex table is very complex in manual calculation, so as to achieve the purpose and expected effect of quickly calculating the simplex table and finding the optimal solution of the planning problem.

The SimplexMethod package provides an efficient implementation of the Simplex Algorithm for solving linear programming (LP) problems. It supports both maximization and minimization of objective functions and allows users to visualize the intermediate steps of the algorithm through detailed simplex table outputs. 

There are five functions in this package, which are described in the function help documentation, but I will only briefly introduce them here.

- **check_inputs**: This function is used to check whether the input parameters are valid, and returns an error message if they are invalid and NULL if they are valid

- **print_simplex_table**: This function is used to print out a simplex table for a particular step

- **LPsimplex**: This function uses the simplex table method to solve linear programming problems, and the input parameters are detailed in the documentation

- **parallel_simplex_step**: This function is used to parallelize each step

- **LPsimplex_parallel**: This function is used to solve linear programming problems using the simplex table method after parallelization, and is used when dealing with large-scale problems, and is not suitable for small-scale problems, because the proportion of time spent on assigning tasks in small tasks is too large (or even hundreds of times) to the total solution time, so it is not recommended

![smrpg](https://github.com/user-attachments/assets/626d073c-599e-4665-a8b8-1e849a0b0255)
