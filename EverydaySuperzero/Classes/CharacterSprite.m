//
//  CharacterSprite.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CharacterSprite.h"
#import "CharacterAnimationData.h"
#import "Utils.h"
#import "MorphMenu.h"
#import "MainNode.h"

@implementation CharacterSprite

@synthesize cad, velocity, destination, morphMenu;

- (id)init
{
    if ((self = [super init]))
    {
        self.cad = [[CharacterAnimationData alloc] init];
        [self anchorCenter];
        self.velocity = 150;
        
        self.userInteractionEnabled = YES;
        
        //morph menu
        MorphMenu *mm = [MorphMenu menu];
        mm.texture = [CCTexture textureWithFile:@"power_select.png"];
        [mm anchorCenter];
        self.morphMenu = mm;
        [self addChild:mm z:3];
        mm.userInteractionEnabled = YES;
        self.morphMenu.visible = NO;
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
            CGPoint pos = ccpAdd(self.position, ccpMult(ccpNormalize(v), delta * self.velocity));
            if ([(MainNode*)self.parent.parent doesCollide:pos])
            {
                self.destination = self.position;
            }
            else
            {
                self.position = pos;
            }
        }
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    self.morphMenu.position = ccp(self.boundingBox.size.width/2,
                                  self.boundingBox.size.height/2);
    self.morphMenu.visible = YES;
    
}



@end
