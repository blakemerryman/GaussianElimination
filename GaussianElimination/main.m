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


#import <Foundation/Foundation.h>   // Imports the Objective C Foundation Framework
#import "LinearSystem.h"            // Imports the LinearSystem Object

/*
 FUNCTION: displayIntroductionMessage
 This function displays the program introduction & any necessary starting instructions (if any) to the user.
 */
void displayIntroductionMessage(void)
{
    // Prints title & author of program.
    printf("\nGAUSSIAN ELIMINATION by BLAKE MERRYMAN\n");
    
    // Prints the introduction message that explains the program.
    printf("\nThis is a command line tool designed to receive a nxn linear system of equations, Ax=b, from user\nprovided text file and solve the system using the method of Gaussian Elimination with Scaled\nPartial Pivoting. There are built in safety checks to ensure that the matrix is invertible.\nError messages will display below if the matrix is singular. After solving, the\nanswer is saved to a text file on the desktop.\n\n");
}

/* ----------------------------------- *
 * ---------- MAIN FUNCTION ---------- *
 * ----------------------------------- */
int main(int argc, const char * argv[])
{
    @autoreleasepool
    { // BEGIN MEMORY MANAGEMENT BLOCK.
    
        displayIntroductionMessage();           // Displays the introduction message.
        
        // Allocates & initializes a string with the contents of plain text file found at specified path. Default is "data.txt" on the desktop.
        NSString *dataFileContents = [[NSString alloc] initWithContentsOfFile:@"/Users/blakemerryman/Desktop/TestData/hil3.txt"
                                                                     encoding:NSUTF8StringEncoding
                                                                        error:nil];
        
        // Creates new instance of LinearSystem object and initializes it with contents of the file.
        LinearSystem *MyLinearSystem = [[LinearSystem alloc] initWithContentsOfString:dataFileContents];
        
        [MyLinearSystem SolveLinearSystem];     // Solve linear system by Gaussian elimination using scaled partial pivoting.
        
        [MyLinearSystem SaveSolutionToFile];    // Saves the solution to file.
    
    } // END MEMORY MANAGEMENT BLOCK.
    
    return 0; // END PROGRAM
}

