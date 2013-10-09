//
//  LinearSystem.m
//  GaussianElimination
//
//  Created by Blake Merryman on 10/4/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import "LinearSystem.h"

#pragma mark - Private Interface Methods
@interface LinearSystem (PrivateMethods)

-(void) ScaleRowByLargestValueAt:(int)rowIndex;  // Scales a row based upon the largest value in row.
-(int)  FindPivotElementForStep:(int)step;       // Finds the location of the largest possible pivot element.
-(void) ReduceRowsForStep:(int)step;             // Reduces the rows at step n.
-(void) BackSubstitution;                        // Back substitutes to find the values of Matrix X.

@end

#pragma mark - Public Interface Method Implementations
@implementation LinearSystem

/*
 METHOD: init
 This is the default initializater mandated by Objective C objects that inherit from 
 the NSObject (foundation object).
 */
-(id)init
{
    self = [super init];
    if (self) { /* Implementation stub of mandatory default constructor. */ }
    return self;
}

/*
 METHOD: initWithContentsOfString
 This is a custom initializer that takes the contents of a string and initializes the 
 values for n, MatrixA, & MatrixB into LinearSystem object's instance variables.
 */
-(id)initWithContentsOfString:(NSString *) stringContents
{
    self = [super init];
    
    if (self)
    {
        // Allocates memory & initializes the matrices A, B, & X.
        _matrixA = [[NSMutableArray alloc] init];
        _matrixB = [[NSMutableArray alloc] init];
        _matrixX = [[NSMutableArray alloc] initWithCapacity:0];
        
        // Initializes the n-value for the linear system from the first line of the string.
        _n = [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:0] intValue];
        
        // Initializes the Matrix A for the linear system from the next n-rows of the string.
        for (int i = 1; i <= _n; i++)
        {
            // Allocates & initializes (default value) a NSArray of rowValues.
            NSArray *rowOfValues = [[NSArray alloc] init];
            
            // Parses & extracts string values at ith row of stringContents and converts them to doubles. Stores in array of row values.
            // TODO: Need to convert to doubles.
            rowOfValues = [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:i] componentsSeparatedByString:@" "];
            
            // Adds row of doubles to the MatrixA.
            [_matrixA addObject:[rowOfValues mutableCopy]];
        }
        
        // Initializes the Matrix B for the linear system from the n+1st row of the string.
        _matrixB = [[[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:_n+1] componentsSeparatedByString:@" "] mutableCopy];
    }
    
    return self;
}

/*
 METHOD: SolveLinearSystem
 This method solves the linear system of equations using the method of Gaussian Elimination 
 with scaled partial pivoting.
 */
-(void)SolveLinearSystem
{
    // Scales the each row of Matrix A by the largest value in that row.
    for (int rowIndex = 0; rowIndex < _n; rowIndex++)   {
        [self ScaleRowByLargestValueAt:rowIndex];
    }
    
    // For each step, this block will enact partial pivoting & row reduction to set up for solving by back substition.
    for (int step = 0; step < _n-1; step++) // TODO: Should step < (_n-1) OR _n ???
    {
        int newPivotLocation = [self FindPivotElementForStep:step];                 // Returns the row index of best possible pivot location.
        
        [_matrixA exchangeObjectAtIndex:step withObjectAtIndex:newPivotLocation];   // Framework provided method that swaps the object indices (instead of contents).
        
        [self ReduceRowsForStep:step];                                              // Reduce rows at current step.
    }
    
    [self BackSubstitution];                                                        // Calls for back substitution.
}

/*
 METHOD SaveSolutionToFile
 This method saves the solution stored in Matrix X to a plain txt file.
 */
// TODO: Need to format the output better.
-(void)SaveSolutionToFile
{
    [_matrixX writeToFile:@"/Users/blakemerryman/Desktop/solution.txt" atomically:NO];
}

/*
 METHOD: PrintLinearSystem
 This method prints the contents of the linear system (n, matrix A, & matrix B) to the command line.
 */
-(void)PrintLinearSystem
{
    // Prints the value of N.
    printf("\nN is %i\n", _n);
    
    // Prints the content of MatrixA.
    printf("\nMatrix A:\n");
    
    for (int row = 0; row < _n; row++)
    {
        for (int col = 0; col < _n; col++)
        {
            printf(" %.4f", [[[_matrixA objectAtIndex:row] objectAtIndex:col] doubleValue] );
        }
        printf("\n");
    }
    
    // Prints the content of MatrixB.
    printf("\nMatrix B:\n");
    for (int row = 0; row < _n; row++)
    {
        printf(" %.4f\n", [[_matrixB objectAtIndex:row] doubleValue]);
    }
    
    // Checks to make sure the Matrix X has objects inside before printing results.
    if ([_matrixX count] > 0) {
        // Prints the content of MatrixX.
        printf("\nMatrix X:\n");
        for (int row = 0; row < _n; row++)
        {
            printf(" %.4f\n", [[_matrixX objectAtIndex:row] doubleValue]);
        }
        
        printf("\n");
    }
}

#pragma mark - Private Interface Method Implementations

/*
 METHOD: ScaleLinearSystem
 This method scales the linear system to assist in reducing progation of round off error.
 */
// TODO: Need to rework this so that it scales the row based upon the largest element in the ROW, not the whole matrix.
-(void)ScaleRowByLargestValueAt:(int)rowIndex
{
    
    
    

    
    
    
    
//    double maxAbsoluteValue = 0.0;
//    double tempAbsoluteValue;
//    
//    for (int row = 0; row < _n; row++)
//    {
//        for (int col = 0; col < _n; col++)
//        {
//            // Finds the absolute value of the next element in the column below the pivot element.
//            tempAbsoluteValue = fabs([[[_matrixA objectAtIndex:row]objectAtIndex:col]doubleValue]);
//            
//            // Compares the current largestAbs.Val. with the current indexed value.
//            if (tempAbsoluteValue > maxAbsoluteValue)
//            {
//                maxAbsoluteValue = tempAbsoluteValue;  // Assigns new largest absolute value.
//            }
//            
//        }
//    }
//    
//    // Error code prints if row max-value is less than 0.000001.
//    if (maxAbsoluteValue > pow(1, -6) ) { printf("ERROR: ROW CONTAINS ONLY ZEROS!"); }
//    
//    // Calculates the matrix scaling factor.
//    double scalingFactor = fabs(1/maxAbsoluteValue);
//    
//    // Scales the matrices A & B.
//    for (int row = 0; row < _n; row++)
//    {
//        for (int col = 0; col < _n; col++)
//        {
//            // Scales the indexed element of matrix A.
//            [[_matrixA objectAtIndex:row]replaceObjectAtIndex:col withObject:[NSNumber numberWithDouble:([[[_matrixA objectAtIndex:row]objectAtIndex:col]doubleValue] * scalingFactor)]];
//        }
//        
//        // Scales the indexed element of matrix B.
//        [_matrixB replaceObjectAtIndex:row withObject:[NSNumber numberWithDouble:([[_matrixB objectAtIndex:row]doubleValue]*scalingFactor)]];
//    }

}

/*
 METHOD: FindPivotForStep
 This private method returns the location of the largest absolute value element in the column at or below the current pivot element.
 */
-(int)FindPivotElementForStep:(int)step
{
    // Creates pivot location & inits with step count.
    int pivotLocation = step;
    
    // Creates largest value & inits with current value at step.
    double largestPivotValue = fabs( [[[_matrixA objectAtIndex:step] objectAtIndex:step] doubleValue] );
    
    for (int row = step+1; row < _n; row++)
    {
        // Finds the absolute value of the next element in the column below the pivot element.
        double temporaryAbsoluteValue = fabs( [[[_matrixA objectAtIndex:row] objectAtIndex:step] doubleValue] );
        
        // Compares the next element & the current largest element.
        if (temporaryAbsoluteValue > largestPivotValue)
        {
            largestPivotValue = temporaryAbsoluteValue; // Assigns new largest absolute value.
            pivotLocation = row;                        // Assigns new largest abs.val. location.
        }
    }
    
    return pivotLocation;
}

/*
 METHOD: ReduceRowForStep
 This method performs the row reduction for each step.
 */
-(void)ReduceRowForStep:(int)step
{
    double newValue; // To be used for temporary storage of newly calculate values.
    
    for (int row = step+1; row < _n; row ++)
    {
        // Calculates the multiplier value.
        double multiplier = [[[_matrixA objectAtIndex:row]objectAtIndex:step]doubleValue] / [[[_matrixA objectAtIndex:step]objectAtIndex:step]doubleValue];
        
        for (int col = step; col < _n; col++)
        {
            // Calculates new row-reduced value for current element.
            newValue = [[[_matrixA objectAtIndex:row]objectAtIndex:col]doubleValue] - multiplier * [[[_matrixA objectAtIndex:step]objectAtIndex:col]doubleValue];
            // Replaces the current element with the new value.
            [[_matrixA objectAtIndex:row]replaceObjectAtIndex:col withObject:[NSNumber numberWithDouble:newValue]];
        }
        
        // Calculates the new row value of matrix B.
        newValue = [[_matrixB objectAtIndex:row]doubleValue] - multiplier * [[_matrixB objectAtIndex:step]doubleValue];
        // Replaces the current element with the new value.
        [_matrixB replaceObjectAtIndex:row withObject:[NSNumber numberWithDouble:newValue]];
    }
}

/*
 METHOD: BackSubstitution
 This method performs back substitution to find the solutions and stores values in matrix X.
 */
-(void)BackSubstitution
{
    double xValue;      // X value to be used throughout for calculations.
    
    // Calculates & stores the last X-value in the matrix X.
    xValue = [[_matrixB objectAtIndex:(_n-1)]doubleValue] / [[[_matrixA objectAtIndex:(_n-1)]objectAtIndex:(_n-1)]doubleValue];
    [_matrixX addObject:[NSNumber numberWithDouble:xValue]];
    
    // Loops backward through the rest of the linear system to solve for the remain X-values.
    for (int row = (_n-2); row >= 0; --row)
    {
        // Stores the sum of values for each row.
        double rowSum = 0.0;
        
        for (int col = (row+1); col < _n; col++)
        {
            // Calculates value using x-value obtained in previous step/loop.
            rowSum += [[[_matrixA objectAtIndex:row]objectAtIndex:col]doubleValue] * xValue;
        }
        
        // Calculates & stores new x-value for this row.
        xValue = ([[_matrixB objectAtIndex:row]doubleValue] - rowSum) / [[[_matrixA objectAtIndex:row]objectAtIndex:row]doubleValue];
        [_matrixX insertObject:[NSNumber numberWithDouble:xValue]atIndex:0];
    }
}

@end








