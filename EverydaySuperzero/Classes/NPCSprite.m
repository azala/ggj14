//
//  NPCSprite.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "NPCSprite.h"

@implementation NPCSprite

@synthesize relationship, currentDialogNumber;

- (id)init
{
    if ((self = [super init]))
    {
        self.relationship = 0;
        self.currentDialogNumber = 1;
    }
    return self;
}

@end
