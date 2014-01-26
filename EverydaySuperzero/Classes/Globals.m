//
//  Globals.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "Globals.h"

@implementation Globals

@synthesize form;
//Jamie 0
//Melissa 1
//Augustus 2
//Hobo 3
//Average Joe 4
//Marjane 5
//Dog 6
//Pigeon 7
//Phil 8

+ (id)sharedInstance
{
    static Globals *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
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
