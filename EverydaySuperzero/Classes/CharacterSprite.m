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

@synthesize cad, velocity, destination;

- (id)init
{
    if ((self = [super init]))
    {
        self.cad = [[CharacterAnimationData alloc] init];
        self.anchorPoint = ccp(.5,.5);
        self.velocity = 150;
    }
    return self;
}

- (void)update:(CCTime)delta
{
    CCTexture *texture = [CCTexture textureWithFile:[self.cad currentFileName]];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTexture:texture];
    [self setTextureRect:rect];
    
    CGPoint v = ccpSub(self.destination, self.position);
    double len = ccpLength(v);
    
    if (v.x == 0 && v.y == 0)
    {
        
    }
    else
    {
        if (len <= delta * self.velocity)
        {
            self.position = self.destination;
        }
        else
        {
            self.position = ccpAdd(self.position, ccpMult(ccpNormalize(v), delta * self.velocity));
        }
    }
    
}

@end
