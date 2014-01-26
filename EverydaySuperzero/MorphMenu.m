//
//  MorphMenu.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "MorphMenu.h"
#import "cocos2d.h"
#import "Utils.h"
#import "Globals.h"
#import "CharacterSprite.h"
#import "CharacterAnimationData.h"

@implementation MorphMenu

+ (MorphMenu*)menu
{
    return [MorphMenu spriteWithImageNamed:@"power_select.png"];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [Utils point:touchLocation from:self.parent.parent.parent to:self];
    
    int xTile = (int)((touchLocation.x - 1) / (self.boundingBox.size.width / 3));
    int yTile = (int)((touchLocation.y - 1) / (self.boundingBox.size.height / 3));
    
    [Globals sharedInstance].form = [Utils morphSelectionToActualForm:3 * yTile + xTile];
    
    ((CharacterSprite*)self.parent).cad.form = [Globals sharedInstance].form;
    
    self.visible = NO;
}

@end
