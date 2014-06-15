GaussianElimination
===================

Objective-C implementation of Gaussian Elimination using Scaled Partial Pivoting.

Created by Blake Merryman on 10/4/13 at Middle Tennessee State University for MATH 4310: Numerical Analysis

Description of Program:
This is a command line tool designed to receive a n x n linear system of equations, Ax=b, from user
provided text file and solve the system using the method of Gaussian Elimination with Scaled
Partial Pivoting. There are built in safety checks to ensure that the matrix is invertible.
Error messages will display in the terminal if the matrix is singular. After solving, the
answer is saved to a text file on the desktop.
