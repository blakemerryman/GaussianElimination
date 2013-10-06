//
//  LinearSystem.m
//  GaussianElimination
//
//  Created by Blake Merryman on 10/4/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import "LinearSystem.h"

#pragma mark - Private Methods Interface
@interface LinearSystem (PrivateMethods)
-(NSMutableArray *)ConvertArrayOfStringsToArrayOfDoubles:(NSArray*)arrayOfStrings;


@end

#pragma mark - Public Methods Implementation

@implementation LinearSystem

#pragma mark - Object Initializers

/*
 METHOD: init
 This is the default initializater mandated by Objective C objects that inherit from the NSObject (foundation object).
 */
-(id)init
{
    self = [super init];
    if (self) { /* Implementation stub of mandatory default constructor. */ }
    return self;
}

/*
 METHOD: initWithContentsOfString
 This is a custom initializer that takes the contents of a string and inputs the values for n, MatrixA, & MatrixB into LinearSystem object's instance variables.
 */
-(id)initWithContentsOfString:(NSString *) stringContents
{
    self = [super init];
    
    if (self)
    {
        // Allocates memory & initializes the matrices A & B.
        _matrixA = [[NSMutableArray alloc] init];
        _matrixB = [[NSMutableArray alloc] init];
        
        // Initializes the n-value for the linear system from the first line of the string.
        _n = [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:0] intValue];
        
        // Initializes the Matrix A for the linear system from the next n-rows of the string.
        for (int i = 1; i <= _n; i++)
        {
            // Gets the ith row of string values from the data string.
            NSArray *rowOfValues = [[NSArray alloc] init];
            rowOfValues = [[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:i] componentsSeparatedByString:@" "];
            
            // Converts that row of string values to doubles.
            rowOfValues = [self ConvertArrayOfStringsToArrayOfDoubles:rowOfValues];
            
            // Adds row of doubles to the MatrixA.
            [_matrixA addObject:[rowOfValues mutableCopy]];
        
        }
        
        // Initializes the Matrix B for the linear system from the n+1st row of the string.
        _matrixB = [[[[stringContents componentsSeparatedByString:@"\n"] objectAtIndex:_n+1] componentsSeparatedByString:@" "] mutableCopy];
        // Converts the matrix elements from strings to doubles.
        _matrixB = [self ConvertArrayOfStringsToArrayOfDoubles:_matrixB];
    
    }
    return self;
}

#pragma mark - Output Methods

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
            printf(" %.3f", [[[_matrixA objectAtIndex:row] objectAtIndex:col] doubleValue] );
        }
        printf("\n");
    }
    
    // Prints the content of MatrixB.
    printf("\nMatrix B:\n");
    for (int row = 0; row < _n; row++)
    {
        printf(" %.3f\n", [[_matrixB objectAtIndex:row] doubleValue]);
    }
    
    printf("\n");
}

#pragma mark - Private Method Implementations

/*
 METHOD: ConvertArrayOfStringsToArrayOfDoubles
 This private method takes an array of string values (obtained from the input data file), converts them to double precision float values,
 stores them in a new array, and returns that new array of doubles.
 */
-(NSMutableArray *)ConvertArrayOfStringsToArrayOfDoubles:(NSArray*)arrayOfStrings
{
    NSMutableArray* arrayOfDoubles = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Gets the number of elements in arrayOfStrings
    NSUInteger elementCount = [arrayOfStrings count];
    
    for (int element = 0; element < elementCount; element++)
    {
        // Converts element of type string to type double.
        double elementValue = [[arrayOfStrings objectAtIndex:element] doubleValue];
        //NSLog(@" %.2f ", elementValue);
        
        // Adds element value to array.
        [arrayOfDoubles addObject: [NSNumber numberWithDouble:elementValue] ];
    }
    
    //NSLog(@"Array Element Count: %lu", (unsigned long)[arrayOfDoubles count]);
    
    return arrayOfDoubles;
}

@end








