//
//  Globals.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

@property (nonatomic) int form;

+ (Globals*)sharedInstance;

@end
