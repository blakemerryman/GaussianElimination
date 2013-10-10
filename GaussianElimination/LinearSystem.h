//
//  LinearSystem.h
//  GaussianElimination
//
//  Created by Blake Merryman on 10/4/13.
//  Middle Tennessee State University, MATH 4310, Programming Assignment 1
//  Due by Thursday, 10 October 2013.
//
//  Description of Program:
//  This is a command line tool designed to receive a nxn linear system of equations, Ax=b, from user
//  provided text file and solve the system using the method of Gaussian Elimination with Scaled
//  Partial Pivoting. There are built in safety checks to ensure that the matrix is invertible.
//  Error messages will display in the terminal if the matrix is singular. After solving, the
//  answer is saved to a text file on the desktop.
//

#import <Foundation/Foundation.h>

@interface LinearSystem : NSObject

#pragma mark - Properties
@property(nonatomic)double LS_ZERO_THRESHOLD;   // Stores the defined threshold value for which values below will be considered zero.
@property(nonatomic)NSUInteger n;               // The value of n will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixA;    // The values of Matrix A will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixB;    // The values of Matrix B will be stored here to be accessible by the rest of the object.

/* NOTE: Properties are used in Objective C to automatically create the getters & setters for instance variables to be used within objects. */

#pragma  mark - Public Interface Methods
-(id)init;                                              // Default initializer required by objective c.
-(id)initWithContentsOfString:(NSString *)fileContents; // Custom initializer that inits with content of string.
-(void)SolveLinearSystem;                               // Solves the linear system of equations.
-(void)SaveSolutionToFile;                              // Saves the solution, replaced contents of matrixB, to a file.

@end
