//
//  Utils.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCNode;

@interface Utils : NSObject

+ (CGSize)screenSize;
+ (void)logPoint:(CGPoint)point;
+ (CGPoint)point:(CGPoint)point from:(CCNode*)a to:(CCNode*)b;

@end
