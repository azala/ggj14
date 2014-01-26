//
//  CharacterAnimationData.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CharacterAnimationData.h"
#import "Utils.h"

@implementation CharacterAnimationData

@synthesize form;

- (NSString*)currentFileName
{
    return [NSString stringWithFormat:@"%@.png", [Utils formIndexToName:self.form]];
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
