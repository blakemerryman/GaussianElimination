//
//  main.m
//  GaussianElimination
//
//  Created by Blake Merryman on 9/25/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>   // Imports the Foundation Framework
#import "LinearSystem.h"            // Imports the LinearSystem Object

int main(int argc, const char * argv[])
{
    @autoreleasepool
    { // BEGIN MEMORY MANAGEMENT BLOCK.
    
    // Establishes the path to file & stores contents in a string.
    // TODO: Need to abstract the input method to be more versatile & userfriendly (add to -init as private method that requests user input).
    NSURL *dataFileURL = [NSURL fileURLWithPath:@"/Users/blakemerryman/Desktop/data2.txt"];
    NSString *dataFileContent = [NSString stringWithContentsOfURL:dataFileURL encoding:NSUTF8StringEncoding error:nil];
    
    // Creates new instance of LinearSystem object and initializes it with contents of the file.
    // TODO: Need to make -init the primary means of initializing.
    LinearSystem *MyLinearSystem = [[LinearSystem alloc] initWithContentsOfString:dataFileContent];
    
    //[MyLinearSystem PrintLinearSystem];   // DEBUGGING: Prints the BEFORE contents of the LinearSystem for debugging purposes.
    
    [MyLinearSystem SolveLinearSystem];     // Solve linear system by Gaussian elimination using scaled partial pivoting.
    
    //[MyLinearSystem PrintLinearSystem];   // DEBUGGING: Prints the AFTER contents of the LinearSystem for debugging purposes.
    
    [MyLinearSystem SaveSolutionToFile];    // Saves the solution to file.
    
    } // END MEMORY MANAGEMENT BLOCK.
    
    return 0; // END PROGRAM
}