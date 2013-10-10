//
//  main.m
//  GaussianElimination
//
//  Created by Blake Merryman on 9/25/13.
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


#import <Foundation/Foundation.h>   // Imports the Foundation Framework
#import "LinearSystem.h"            // Imports the LinearSystem Object

/*
 FUNCTION: displayIntroductionMessage
 This function displays the program introduction & any necessary starting instructions (if any) to the user.
 */
void displayIntroductionMessage(void)
{
    // Prints the introduction message that explains the program.
    printf("\nThis program takes a TXT file from user input & uses the method of");
    printf("\nGaussian Elimination (with Scaled Partial Pivoting) to solve the");
    printf("\ngiven linear system. It saves the result to a file.\n");
}

/*
 FUNCTION: debugPrintStatement
 This function displays the content of the linear system if the debugging feature of the project is turned on. Otherwise, nothing occurs.
 */
void debugPrintStatement(LinearSystem *MyLinearSystem)
{
    int dEBUG = 1;
    if (dEBUG == 1)
    {
        [MyLinearSystem PrintLinearSystem];
    }
}

/* ----------------------------------- *
 * ---------- MAIN FUNCTION ---------- *
 * ----------------------------------- */
int main(int argc, const char * argv[])
{
    @autoreleasepool
    { // BEGIN MEMORY MANAGEMENT BLOCK.
    
        displayIntroductionMessage();
        
        // Establishes the path to file & stores contents in a string.
        NSString *dataFileContents = [[NSString alloc] initWithContentsOfFile:@"/Users/blakemerryman/Desktop/data2.txt"
                                                                     encoding:NSUTF8StringEncoding
                                                                        error:nil];
        
        // Creates new instance of LinearSystem object and initializes it with contents of the file.
        LinearSystem *MyLinearSystem = [[LinearSystem alloc] initWithContentsOfString:dataFileContents];
        
        debugPrintStatement(MyLinearSystem);    // DEBUGGING: See function decription.
        
        [MyLinearSystem SolveLinearSystem];     // Solve linear system by Gaussian elimination using scaled partial pivoting.
        
        debugPrintStatement(MyLinearSystem);    // DEBUGGING: See function decription.
        
        [MyLinearSystem SaveSolutionToFile];    // Saves the solution to file.
    
    } // END MEMORY MANAGEMENT BLOCK.
    
    return 0; // END PROGRAM
}