//
//  main.m
//  GaussianElimination
//
//  Created by Blake Merryman on 9/25/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinearSystem.h"

// FUNCTION PROTOTYPES

// MAIN FUNCTION
int main(int argc, const char * argv[]) // BEGIN PROGRAM
{   @autoreleasepool { // BEGIN MEMORY MANAGEMENT BLOCK.
    
    // Establishes the path to file & stores contents in a string.
    NSURL *dataFileURL = [NSURL fileURLWithPath:@"/Users/blakemerryman/Desktop/data.txt"];
    NSString *dataFileContent = [NSString stringWithContentsOfURL:dataFileURL
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    
    // Creates new instance of LinearSystem object and initializes it with contents of the file.
    LinearSystem *MyLinearSystem = [[LinearSystem alloc] initWithContentsOfString:dataFileContent];
    
    // Prints the BEFORE contents of the LinearSystem for debugging purposes.
    // [MyLinearSystem PrintLinearSystem];
    
    // Solve linear system by Gaussian elimination using scaled partial pivoting.
    [MyLinearSystem SolveLinearSystem];
    
    
    
    
    
    // Prints the AFTER contents of the LinearSystem for debugging purposes.
    // [MyLinearSystem PrintLinearSystem];
    
    } // END MEMORY MANAGEMENT BLOCK.
    
    return 0; // END PROGRAM
}