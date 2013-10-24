//
//  LinearSystem.m
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

#import "LinearSystem.h"

#pragma mark - Private Interface Method Declarations
@interface LinearSystem (PrivateMethods)                   // This is the private method interface for LinearSystem object.

-(void)ScaleRowsByLargestAbsoluteValueInRow;               // Scales a row based upon the largest value in row.
-(NSUInteger)FindPivotElementForStep:(NSUInteger)step;     // Finds the location of the largest possible pivot element.
-(void)ReduceRowsForStep:(NSUInteger)step;                 // Reduces the rows at step n.
-(void)BackSubstitution;                                   // Back substitutes to find the values of Matrix X.

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
    if (self){ /* Default init stub. */ }
    return self;
}

/*
 METHOD: initWithContentsOfStrings
 This is a custom initializer that takes the contents of a string and initializes the values
 for n, LS_ZERO_THRESHOLD, MatrixA, & MatrixB into LinearSystem object's instance variables.
 */
-(id)initWithContentsOfString:(NSString *) stringContents
{
    self = [super init];    // Call default initializer method.
    
    // If the object initializes properly...
    if (self)
    {
        _matrixA = [[NSMutableArray alloc] init];   // Allocates memory & initializes the matrix A
        _matrixB = [[NSMutableArray alloc] init];   // Allocates memory & initializes the matrix B
        _LS_ZERO_THRESHOLD = 1 * pow(10, -10);       // Sets the linear system's "zero" threshold value.
        
        // SAFETY: If the first character of the file is not a valid positive integer, the message will return a value < 1...
        if ( [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:0] intValue] < 1 )
        {
            // Display error message to terminal and terminate the program.
            NSLog(@"ERROR: The n value in the data file was not a valid entry."); exit(0);
        }

        // Initialize the n-value for the linear system from the first line of the string.
        _n = [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:0] intValue];
        
        // Fills the Matrix A with arrays of row values (after finding them, of course).
        for (NSUInteger row = 1; row <= _n; row++)
        {
            // Allocates & initializes an empty array of rowValues.
            NSMutableArray *rowOfValues = [[NSMutableArray alloc] initWithCapacity:0];
            
            // Creates & initializes value to hold parsed row elements.
            double rowElement = 0.0;
            
            // Parses & extracts values down the length of each row.
            for (NSUInteger col = 0; col < _n; col++)
            {
                /*  DESCRIPTION:
                 *  This line of code does quite a bit. Reading from the inner brackets out:
                 *      1. Creates an array where each element is a line of the data file string (from index 1 to n).
                 *      2. Returns the element (line of data file) held at the index "row".
                 *      3. Creates a new array where each element is a single entry/number from the line of data.
                 *      4. Returns the element (entry from line) held at the index "col".
                 *      5. Returns the double value of the element at the index.
                 */
                rowElement = [[[[[stringContents componentsSeparatedByString:@"\n"]objectAtIndex:row]componentsSeparatedByString:@" "]objectAtIndex:col] doubleValue];
                
                // Wraps double value in NSNumber object wrapper & adds it to the end of the array A.
                [rowOfValues addObject: [NSNumber numberWithDouble:rowElement]];
            }
            // Adds row of values to the matrix B.
            [_matrixA insertObject:rowOfValues atIndex:(row-1)];
            
            // Repurposes rowElement to retrieve & store the values for B in the same manner as for the rowOfValues array.
            rowElement = [[[[[stringContents componentsSeparatedByString:@"\n"]objectAtIndex:(_n+1)]componentsSeparatedByString:@" "]objectAtIndex:(row-1)]doubleValue];
            
            // Wraps double value in NSNumber object wrapper & adds it to the end of the array B.
            [_matrixB addObject:[NSNumber numberWithDouble:rowElement]];
        }
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
    // Scales the rows of the linear system by the largest absolute value in each row.
    [self ScaleRowsByLargestAbsoluteValueInRow];
    
    // Creates & initializes value to hold current pivot element row index location.
    NSUInteger pivotElementRowIndexForCurrentStep = 0;
    
    // Loops through the steps of the matrix in the solving process...
    for (NSUInteger step = 0; step < _n; step++)
    {
        // Returns the row index of best possible pivot location.
        pivotElementRowIndexForCurrentStep = [self FindPivotElementForStep:step];
        
        // Framework provided method that swaps the object indices (instead of object contents).
        [_matrixA exchangeObjectAtIndex:step withObjectAtIndex:pivotElementRowIndexForCurrentStep];
        
        // Reduce rows at current step.
        [self ReduceRowsForStep:step];
    }
    
    // Calls for back substitution.
    [self BackSubstitution];
}

/*
 METHOD SaveSolutionToFile
 This method saves the solution stored in Matrix X to a plain txt file.
 */
-(void)SaveSolutionToFile
{
    //[_matrixB writeToFile:@"/Users/blakemerryman/Desktop/solution.txt" atomically:NO];
    NSString* writeContentsToFileName = @"/Users/blakemerryman/Desktop/solution.txt";
    
    // Allocates & initializes a string that will hold our solution values.
    NSString* stringToSave = [[NSString alloc] init];
    
    // Loops through the solution values...
    for (NSUInteger colIndex = 0; colIndex < _n; colIndex++)
    {
        // Converts each solution's double value to formatted string values. Decimal places are given by the .# in the string.
        [_matrixB replaceObjectAtIndex:colIndex withObject:[NSString stringWithFormat:@"%.4f",[[_matrixB objectAtIndex:colIndex] doubleValue]]];
        
        // Appends the formatted solution value to the string to string to be saved. Seperates each by a newline character.
        stringToSave = [stringToSave stringByAppendingFormat:@"%@\n",[_matrixB objectAtIndex:colIndex]];
    }
    
    // Writes content of string to plain text file. Checks to ensure that file exists; creates it if needed.
    [stringToSave writeToFile:writeContentsToFileName
                   atomically:YES
                     encoding:NSASCIIStringEncoding
                        error:nil];
}

#pragma mark - Private Interface Method Implementations

/*
 METHOD: ScaleRowsByLargestValueAtInRow
 This method scales the linear system to assist in reducing progation of round off error.
 */
-(void)ScaleRowsByLargestAbsoluteValueInRow
{
    for (NSUInteger rowIndex = 0; rowIndex < _n; rowIndex++)
    {
        // Creates & intializes the largest abs.val. to be the first value in the row.
        double largestAbsoluteValueForRow = fabs([[[_matrixA objectAtIndex:rowIndex] objectAtIndex:0] doubleValue]);
        
        // Create & initialize the largest abs.val.'s row col.index to be the first element in row.
        NSUInteger largestAbsValColIndex = 0;
        
        // Create & initialize the value to hold the temporary values to be used for comparisons & calculations.
        double temporaryValueInRow = 0;
        
        // Loops through all of the elements of the row.
        for (NSUInteger colIndex = 1; colIndex < _n; colIndex++)
        {
            // Calculates the absolue value of the current column term in the row.
            temporaryValueInRow = fabs( [[[_matrixA objectAtIndex:rowIndex] objectAtIndex:colIndex] doubleValue] );
            
            if (temporaryValueInRow > largestAbsoluteValueForRow)   // Checks if the temporary is larger than the largest. If so...
            {
                largestAbsoluteValueForRow = temporaryValueInRow;   // Update the largest value to be the temp. value.
                largestAbsValColIndex = colIndex;                   // Update the largest's col index to be that of the temp value.
            }
        }
        
        // SAFETY: If the largest value in the row is less than our defined "zero"...
        if (largestAbsoluteValueForRow < _LS_ZERO_THRESHOLD)
        {
            // Display error message to terminal & terminate program.
            NSLog(@"ERROR: In Matrix A, Row %lu contains all zeros (as defined by the program). Matrix is singular.",(unsigned long)rowIndex+1); exit(0);
        }
        
        // Calculates the row scaling factor.
        double scalingFactor = fabs( 1 / [[[_matrixA objectAtIndex:rowIndex] objectAtIndex:largestAbsValColIndex] doubleValue] );
        
        // Loops through all values in the row...
        for (NSUInteger colIndex = 0; colIndex < _n; colIndex++)
        {
            /* FOR MATRIX A (current row) */
            // Calculates the newly scaled value at current column index for row.
            temporaryValueInRow = [[[_matrixA objectAtIndex:rowIndex] objectAtIndex:colIndex] doubleValue] * scalingFactor;
            // Replaces the original value with newly scaled value at given current column index for row.
            [[_matrixA objectAtIndex:rowIndex] replaceObjectAtIndex:colIndex withObject:[NSNumber numberWithDouble:temporaryValueInRow]];
        }

        /* FOR MATRIX B (current row) */
        // Calculates the newly scaled value at current row index.
        temporaryValueInRow = [[_matrixB objectAtIndex:rowIndex] doubleValue] * scalingFactor;
        
        // Replaces the original value with newly scaled value at current row index for row.
        [_matrixB replaceObjectAtIndex:rowIndex withObject:[NSNumber numberWithDouble:temporaryValueInRow]];
    }
    
}

/*
 METHOD: FindPivotForStep
 This private method returns the location of the largest absolute value element in the column at or below the current pivot element.
 */
-(NSUInteger)FindPivotElementForStep:(NSUInteger)step
{
    // Creates & initializes the value to be the abs.val. of the current pivot element.
    double largestAbsoluteValueForColumn = fabs( [[[_matrixA objectAtIndex:step] objectAtIndex:step] doubleValue] );
    
    double temporaryColumnValue = 0;    // Creates & initializes the value to hold temporary values for comparisons & calculations.
    NSUInteger pivotIndex = step;       // Creates & initializes (with step) the value to hold the current column's best pivot row-index.
    
    // Loops through all values in the column beneath the starting pivot index.
    for (NSUInteger rowIndex = step+1; rowIndex < _n; rowIndex++)
    {
        // Finds the absolute value of the next element in the column below the pivot element.
        temporaryColumnValue = fabs( [[[_matrixA objectAtIndex:rowIndex] objectAtIndex:step] doubleValue] );
        
        if (temporaryColumnValue > largestAbsoluteValueForColumn)   // Checks if the temporary is larger than the largest. If so...
        {
            largestAbsoluteValueForColumn = temporaryColumnValue;   // Update the largest value to be the temp. value.
            pivotIndex = rowIndex;                                  // Update the largest's row index to be that of the temp value.
        }
    }
    
    // SAFETY: If the largest value in the column is less than our defined "zero"...
    if (largestAbsoluteValueForColumn < _LS_ZERO_THRESHOLD)
    {
        // Display error message to terminal & terminate program.
        NSLog(@"ERROR: In Matrix A, Column %lu contains all zeros (as defined by the program) at or below pivot. Matrix A is singular.",(unsigned long)pivotIndex+1); exit(0);
    }
    
    return pivotIndex;
}

/*
 METHOD: ReduceRowForStep
 This method performs the row reduction for each step.
 */
-(void)ReduceRowsForStep:(NSUInteger)step
{
    double newValue = 0;            // The temporary storage of newly calculate values.
    double currentRowElement = 0;   // The temporary storage of current row element values.
    double pivotRowElement = 0;     // The temporary storage of pivot row element values.
    
    for (NSUInteger row = (step+1); row < _n; row ++)
    {
        currentRowElement = [[[_matrixA objectAtIndex:row]objectAtIndex:step]doubleValue];      // The current row's value beneath the pivot.
        pivotRowElement   = [[[_matrixA objectAtIndex:step]objectAtIndex:step]doubleValue];     // The current step's value for the pivot element.
        double multiplier = currentRowElement / pivotRowElement;                                // Calculates multiplier for row reduction.
        [[_matrixA objectAtIndex:row] replaceObjectAtIndex:step
                                                withObject:[NSNumber numberWithDouble:0.0]];    // Fill in value below pivot with zero for current row.
        
        // Loops through the remaining elements in the row...
        for (NSUInteger col = (step+1); col < _n; col++)
        {
            double currentRowElement = [[[_matrixA objectAtIndex:row]objectAtIndex:col]doubleValue];    // The current row's element for current column
            double pivotRowElement   = [[[_matrixA objectAtIndex:step]objectAtIndex:col]doubleValue];   // The pivot row's element for current column.
            newValue = currentRowElement - multiplier * pivotRowElement;                                // Calculates new row-reduced value for current element.
            [[_matrixA objectAtIndex:row]replaceObjectAtIndex:col
                                                   withObject:[NSNumber numberWithDouble:newValue]];    // Replaces the current element with the new value.
        }
        
        currentRowElement = [[_matrixB objectAtIndex:row]doubleValue];           // The current row's b value.
        pivotRowElement   = [[_matrixB objectAtIndex:step]doubleValue];          // The pivot row's b value.
        newValue = currentRowElement - multiplier * pivotRowElement;             // Calculates new b value for current row.
        [_matrixB replaceObjectAtIndex:row
                            withObject:[NSNumber numberWithDouble:newValue]];    // Replaces the current element with the new value.
    }
}

/*
 METHOD: BackSubstitution
 This method performs back substitution to find the solutions and stores values in matrix X.
 */
-(void)BackSubstitution
{
    // SAFETY: If the diagonal term for this row is considered "zero"
    double nXnTerm = fabs( [[[_matrixA objectAtIndex:(_n-1)]objectAtIndex:(_n-1)]doubleValue] );
    if ( nXnTerm < _LS_ZERO_THRESHOLD)
    {
        // Display error message to terminal and terminate the program.
        NSLog(@"ERROR: Attempted to divide by zero during back substitution on the initial back-step"); exit(0);
    }
    
    // Creates & initializes the X value to be used throughout for calculations.
    double xValue = [[_matrixB objectAtIndex:(_n-1)]doubleValue] / [[[_matrixA objectAtIndex:(_n-1)]objectAtIndex:(_n-1)]doubleValue];
    
    // Wraps double value in NSNumber object wrapper & begins replacing the values in matrix B starting with the last value.
    [_matrixB replaceObjectAtIndex:(_n-1) withObject:[NSNumber numberWithDouble:xValue]];
    
    // Loops backward through the rest of the linear system to solve for the remain X-values.
    for (NSInteger rowIndex = (_n-2); rowIndex >= 0; rowIndex--)
    {
        double rowSum = 0.0;    // Creates & initializes the row's running sum to zero.
        
        // Loops through the values in the row to the right of the current step.
        for (NSUInteger colIndex = (rowIndex+1); colIndex < _n; colIndex++)
        {
            // Calculates sum value using x-value obtained in previous step/loop.
            rowSum += [[[_matrixA objectAtIndex:rowIndex]objectAtIndex:colIndex]doubleValue] * xValue;
        }
        
        // SAFETY: If the diagonal term for this row is considered "zero"
        double nXnTerm = fabs( [[[_matrixA objectAtIndex:rowIndex]objectAtIndex:rowIndex]doubleValue] );

        if ( nXnTerm < _LS_ZERO_THRESHOLD )
        {
            // Display error message to terminal and terminate the program.
            NSLog(@"ERROR: Attempted to divide by zero during back substitution on the %lith step!",(long)rowIndex+1); exit(0);
        }
        
        // Calculates new x value for this row.
        xValue = ([[_matrixB objectAtIndex:rowIndex]doubleValue] - rowSum) / [[[_matrixA objectAtIndex:rowIndex]objectAtIndex:rowIndex]doubleValue];
        
        // Wraps double value in NSNumber object wrapper & continues replacing the values of matrix B from last to first.
        [_matrixB replaceObjectAtIndex:rowIndex withObject:[NSNumber numberWithDouble:xValue]];
    }
}

@end