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
#import "FadeLabelDialog.h"

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
        mm.texture = [CCTexture textureWithFile:@"0_inactive_buttons.png"];
        [mm anchorCenter];
        self.morphMenu = mm;
        [self addChild:mm z:3];
        mm.userInteractionEnabled = YES;
        self.morphMenu.visible = NO;
        
//        FadeLabelDialog *fld = [[FadeLabelDialog alloc] initWithTexture:mm.texture rect:CGRectMake(0,0,150,50)];
//        [fld anchorCenter];
//        fld.position = ccp(150, 50);
//        fld = [fld initWithTime:5 fadingAfter:2];
//        fld.label = [CCLabelTTF labelWithString:@"I’m new in town.\nI wonder what the people here are like." fontName:@"Arcadepix Plus.ttf" fontSize:20 dimensions:fld.boundingBox.size];
//        [fld.label anchorCenter];
//        fld.label.position = CGPointMake(10, 50);
//        [fld addChild:fld.label];
//        [self addChild:fld];
//        fld.label.set
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
            MainNode *mn = (MainNode*)self.parent.parent;
            CGPoint pos = ccpAdd(self.position, ccpMult(ccpNormalize(v), delta * self.velocity));
            NPCSprite *hit = [mn hitsNPC:pos];
            
            if ([mn doesCollide:pos])
            {
                self.destination = self.position;
            }
            else if (hit)
            {
                self.destination = self.position;
                [mn triggerInteraction:self npc:hit];
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
