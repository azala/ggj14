//
//  MainLayer.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "cocos2d.h"

@class CharacterSprite, NPCSprite;

@interface MainNode : CCNode

@property (nonatomic, strong) CharacterSprite *mainChar;

- (BOOL)doesCollide:(CGPoint)mapPoint;
- (NPCSprite*)hitsNPC:(CGPoint)mapPoint;
- (void)triggerInteraction:(CharacterSprite*)cs npc:(NPCSprite*)npc;
- (void)hideDialogBox;

@end
