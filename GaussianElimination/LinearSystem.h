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
@property(nonatomic)int n;
@property(nonatomic)NSMutableArray* matrixA;
@property(nonatomic)NSMutableArray* matrixB;
@property(nonatomic)NSMutableArray* matrixX;

// Public Methods:
#pragma mark - Object Initializers
-(id)init;
-(id)initWithContentsOfString:(NSString *) fileContents;

#pragma mark - Utility Methods
-(void)SolveLinearSystem;
-(void)PrintLinearSystem;

@end
