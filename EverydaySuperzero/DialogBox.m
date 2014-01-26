//
//  DialogBox.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/26/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "DialogBox.h"

@implementation DialogBox

@synthesize label;

//- (id)init
//{
//    if ((self = [super init]))
//    {
//        self.userInteractionEnabled = YES;
//        self.exclusiveTouch = YES;
//    }
//    return self;
//}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.visible = NO;
}

@end
