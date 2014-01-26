//
//  CharacterSprite.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CCSprite.h"

@class CharacterAnimationData;

@interface CharacterSprite : CCSprite

@property (nonatomic, strong) CharacterAnimationData *cad;
@property (nonatomic) double velocity;

@property (nonatomic) CGPoint destination;

@end
