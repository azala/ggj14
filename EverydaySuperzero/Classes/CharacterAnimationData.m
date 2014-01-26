//
//  CharacterAnimationData.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CharacterAnimationData.h"

@implementation CharacterAnimationData

@synthesize form;

- (NSString*)currentFileName
{
    return (self.form == 0) ? @"Jamie_forward_1.png" : @"Jamie_backward_1.png";
}

- (id)init
{
    if ((self = [super init]))
    {
        self.form = 0;
    }
    return self;
}

@end
