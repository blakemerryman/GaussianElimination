//
//  LinearSystem.h
//  GaussianElimination
//
//  Created by Blake Merryman on 10/4/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinearSystem : NSObject

#pragma mark - Properties
@property(nonatomic)double LS_ZERO_THRES;       // Stores the defined threshold value for which values below will be considered zero.
@property(nonatomic)int n;                      // The value of n will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixA;    // The values of Matrix A will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixB;    // The values of Matrix B will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixX;    // The values of Matrix X will be stored here to be accessible by the rest of the object.

/* NOTE: Properties are used in Objective C to automatically create the getters & setters for instance variables to be used within objects. */

#pragma  mark - Public Interface Methods
-(id)init;                                              // Default initializer required by objective c.
-(id)initWithContentsOfString:(NSString *)fileContents; // Custom initializer that inits with content of string.
-(void)SolveLinearSystem;                               // Solves the linear system of equations.
-(void)PrintLinearSystem;                               // Prints the linear system of equations.
-(void)SaveSolutionToFile;                              // Saves the solution, contents of matrixX, to a file.

@end
