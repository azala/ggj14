//
//  CharacterSprite.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CharacterSprite.h"
#import "CharacterAnimationData.h"

@implementation CharacterSprite

@synthesize cad;

- (id)init
{
    if ((self = [super init]))
    {
        self.cad = [[CharacterAnimationData alloc] init];
    }
    return self;
}

- (void)update:(CCTime)delta
{
//    [self setTexture:[CCTexture textureWithFile:[self.cad currentFileName]]];
    CCTexture *texture = [CCTexture textureWithFile:@"Jamie_forward_1.png"];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTexture:texture];
    [self setTextureRect:rect];
    self.anchorPoint = ccp(.5,.5);
}

@end
