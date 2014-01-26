//
//  MainLayer.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "cocos2d.h"

@class CharacterSprite;

@interface MainNode : CCNode

@property (nonatomic, strong) CharacterSprite *mainChar;

- (BOOL)doesCollide:(CGPoint)mapPoint;

@end
