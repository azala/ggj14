//
//  Utils.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "Utils.h"
#import "cocos2d.h"
#import "Globals.h"

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

//todo
+ (int)morphSelectionToActualForm:(int)morphSel
{
    switch (morphSel) {
        case 0:
            return 0;
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 4;
        case 5:
            return 5;
        case 6:
            return 6;
        case 7:
            return 7;
        case 8:
            return 8;
        default:
            return 0;
    }
}

+ (NSString*)formIndexToName:(int)formIndex
{
    switch (formIndex) {
        case 0:
            return @"Jamie";
        case 1:
            return @"Melissa";
        case 2:
            return @"Augustus";
        case 3:
            return @"Hobo";
        case 4:
            return @"Average Joe";
        case 5:
            return @"Marjane";
        case 6:
            return @"Russell";
        case 7:
            return @"Pigeon";
        case 8:
            return @"Phil";
        //nonmorphables
        case 9:
            return @"Carl";
        case 10:
            return @"Mae";
        case 11:
            return @"Martha";
        case 12:
            return @"Mario";
        case 13:
            return @"Giovani";
        case 14:
            return @"James";
        case 15:
            return @"Paulo";
        case 16:
            return @"Betty";
        case 17:
            return @"Saki";
        default:
            return @"";
    }
}

+ (BOOL)canInteractWithTreasureTree
{
    int gform = [Globals sharedInstance].form;
    return (gform == 6);
}

@end

@implementation CCNode (CCNode_foo)

- (void)anchorCenter
{
    self.anchorPoint = ccp(.5,.5);
}

@end