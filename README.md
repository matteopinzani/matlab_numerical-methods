# MATLAB Numerical Methods - Computer Assignments
This repository contains the computer assignmnents, code implementations, and generated vector graphics for different projects of the **Numerical Methods (1MA930)** course at Linnaeus University.

This repository is structured to house all three main projects for the VT2026 semester. The projects focus on implementing numerical algorithms, mathematical simulations, and computational problem-solving using **MATLAB**.

## 📚 Reference Material
The assignmnets, theoretical foundations, and mathematical algorithms implemented in this repository are based on the core textbook for the course:
* **Timothy Sauer**, *Numerical Analysis* (2nd Editon, Pearson).

## 📁 Repository Structure
The repository is divided into main directories for each project to keep the source code, numerical data, and visual outputs organized:
* `projects/1_bezier_curves`: Contains the implementation for drawing and manipulating cubic Bézier splines.
* `projects/2_...`: todo
* `projects/3_...`: todo

## 🚀 Projects Overview

### Project 1: Bézier Curves
This project explores the mathematical explores the mathematical construction, simulation, and manual vector-coding of cubic Bézier splines to render complex typographical characters. The projects is divided into specific activities on Reality Check 3 (Sauer, pp. 183-187):
* `activity_1_ginput_implementation/`: Implementation of an interactive freehand drawing tool `bezier_interactive.m`). Using MATLAB's `ginput` function, this script allows the user to manually select spline points (also known as endpoints) and control points to construct cubic Bézier splines dynamically.
* `activity_2_matrix_implementation/`: An automated MATLAB function (`bezier_matrix.m`) designed to accept an n x 8 matrix, rendering the 21-piece lower-case letter 'f' in the Times-Roman font.
* `activity_3_pdf_stream_implementation/`: Manual vector-coding of the PDF stream. The letter 'f' is constructed using the `m` (moveto) command and consecutive `c` (curveto) commands for the splines directly within the file's binary stream.
* `activity_4_pdf_transformations_implementation/`: Advanced manipulation of the PDF coordinate system. This activity utilizes the `cm` command to apply linear affine transformations (scaling, translating, skewing) and implements RGB color styling (`RG`, `w`, `rg`).
* `activity_6_creative_bezier_design/`: The design and implementation of an original typographical character. Includes the mandatory initial hand-drawn sketch on a coordinate grid, the theoretical calculation of control points, the numerical matrix, and the final PDF render.

### Project 2: ... (todo)

### Project 3: ... (todo)

## 🛠️ Technologies & Tools
* **MATLAB**: Used for mathematical simulations, interactive coordinate mapping, and numerical rendering.
* **PDF Stream Commands**: Direct text-editor manipulation of PDF object streams (`m`, `c`, `cm`, `S`, `b`) for low-level vector graphics generation.
