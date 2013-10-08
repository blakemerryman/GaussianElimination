//
//  LinearSystem.h
//  GaussianElimination
//
//  Created by Blake Merryman on 10/4/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinearSystem : NSObject

#pragma mark - Object Properties
// Properties are used in Objective C to automatically create the getters & setters for instance variables to be used within objects.
@property(nonatomic)int n;                      // The value of n will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixA;    // The values of Matrix A will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixB;    // The values of Matrix B will be stored here to be accessible by the rest of the object.
@property(nonatomic)NSMutableArray* matrixX;    // The values of Matrix X will be stored here to be accessible by the rest of the object.

// Public Method Interface:
/********************************/
// TODO: Come up (i.e. remove?) with better pragma scheme after code changes.
#pragma mark - Object Initializers
// These methods initialize the LinearSystem object.
// TODO: Need to make -init the only initializer (encapsulate -initWithContents into a private method.
-(id)init;
-(id)initWithContentsOfString:(NSString *) fileContents;

#pragma mark - Utility Methods
-(void)SolveLinearSystem;
-(void)PrintLinearSystem;
-(void)SaveSolutionToFile;

@end
