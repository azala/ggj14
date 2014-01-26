//
//  Utils.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "Utils.h"
#import "cocos2d.h"

@implementation Utils

+ (CGSize)screenSize
{
    return [[CCDirector sharedDirector] designSize];
}

+ (void)logPoint:(CGPoint)point
{
    NSLog(@"(%f,%f)", point.x, point.y);
}

+(CGPoint)point:(CGPoint)point from:(CCNode*)a to:(CCNode*)b
{
    return [b convertToNodeSpace:[a convertToWorldSpace:point]];
}

@end

@implementation CCNode (CCNode_foo)

- (void)anchorCenter
{
    self.anchorPoint = ccp(.5,.5);
}

@end