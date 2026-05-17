# MATLAB Numerical Methods - Computer Assignments
This repository contains the computer assignmnents, code implementations, and generated vector graphics for different projects of the **Numerical Methods (1MA930)** course at Linnaeus University.

This repository is structured to house all three main projects for the VT2026 semester. The projects focus on implementing numerical algorithms, mathematical simulations, and computational problem-solving using **MATLAB**.

## 📚 Reference Material
The assignmnets, theoretical foundations, and mathematical algorithms implemented in this repository are based on the core textbook for the course:
* **Timothy Sauer**, *Numerical Analysis* (2nd Editon, Pearson).

## 📁 Repository Structure
The repository is divided into main directories for each project to keep the source code, numerical data, and visual outputs organized:
* `projects/1-bezier_curves`: Contains the implementation for drawing and manipulating cubic Bézier splines.
* `projects/2-eigenvalues_iteration_pagerank`: Contains theoretical mathematical proof, Power Iteration implementation, and PageRank network analysis.
* `projects/3_...`: Contains the implementation of numerical integration and root-finding algorithm to simulate constant and variable-speed motion along parametric curves.

## 🚀 Projects Overview

### Project 1: Bézier Curves
This project explores the mathematical explores the mathematical construction, simulation, and manual vector-coding of cubic Bézier splines to render complex typographical characters. The projects is divided into specific activities on Reality Check 3 (Sauer, pp. 183-187):
* `activity_1_ginput_implementation/`: Implementation of an interactive freehand drawing tool `bezier_interactive.m`). Using MATLAB's `ginput` function, this script allows the user to manually select spline points (also known as endpoints) and control points to construct cubic Bézier splines dynamically.
* `activity_2_matrix_implementation/`: An automated MATLAB function (`bezier_matrix.m`) designed to accept an n x 8 matrix, rendering the 21-piece lower-case letter 'f' in the Times-Roman font.
* `activity_3_pdf_stream_implementation/`: Manual vector-coding of the PDF stream. The letter 'f' is constructed using the `m` (moveto) command and consecutive `c` (curveto) commands for the splines directly within the file's binary stream.
* `activity_4_pdf_transformations_implementation/`: Advanced manipulation of the PDF coordinate system. This activity utilizes the `cm` command to apply linear affine transformations (scaling, translating, skewing) and implements RGB color styling (`RG`, `w`, `rg`).
* `activity_5_font_bezier`: Extraction of Bézier curve data from modern web fonts. This folder includes an SVG file containing the path data for the letter 'R' and the corresponding PDF output (`letterR.pdf`).
* `activity_6_creative_bezier_design/`: The design and implementation of an original typographical character. Includes the mandatory initial hand-drawn sketch on a coordinate grid, the theoretical calculation of control points, the numerical matrix, and the final PDF render.

### Project 2: Eigenvalues, Iteration, and PageRank
This project consists of repeated matrix multiplication through eigenvalues.
* `part_1_proof_thm/`: A theoretical presentation proving Theorem 2.10 from Sauer's *Numerical Analysis*. The proof demonstrates that strict diagonal dominance in a matrix implies the convergence of the Jacobi iterative method.
* `part_2_power_iteration_dominant_eigenpair/`: A Matlab implementation of the Power Iteration method to approximate the dominant eigenvalue and corresponding eigenvector of a square matrix. The scripts evaluates a $3 x 3$ test matrix, compares the approximated results with MATLAB's exact `eig` function, and empirically investigates the convergence speed against the theoretical rate $S = |\lambda_2/\lambda_1|$.
* `part_3_pagerank_wikipedia/`: Application of the power iteration code to compute the PageRank vector for a supplied network of Wikipedia pages, using a generated Google matrix.

### Project 3: Adaptive Quadrature and Motion Control in Animation
This project applies numerical integration and root-finding to a classic problem in computer animation: moving a marker along a parametric curve at a prescribed speed. The project relies on approximating arc-length integrals and solving nonlinear equations to control motion dynamics.
* `part_1_validating_adaptive_quadrature/`: Validation of an adaptive quadrature routine (`adapquad.m`). The algorithm numerically computes the arr-length of a circle, comparing the apporximated output against the known closed-form analytical length to verify accuracy and error tolerances.
* `part_2_equal_arclength_partition_newton_method/`: Implementation of Netwon's method to equipartition a custom parametric curve (a cubic Bézier spline). The script solves for parameter values $t^*(s)$ that divide the curve into $n$ segments of exactly equal arc-length, relying heavily on the Fundamental Theorem of Calculus for the derivative formulation.
* `part_3_...`: todo
* `part_4_...`: todo

## 🛠️ Technologies & Tools
* **MATLAB**: Used for mathematical simulations, interactive coordinate mapping, and numerical rendering.
* **PDF Stream Commands**: Direct text-editor manipulation of PDF object streams (`m`, `c`, `cm`, `S`, `b`) for low-level vector graphics generation.
* **LaTeX / Markdown**: Used for typesetting mathematical theorems and documenting project functionality.
