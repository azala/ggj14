//
//  ShellScene.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "ShellScene.h"
#import "MainNode.h"
#import "CharacterSprite.h"
#import "MorphMenu.h"

@interface ShellScene ()

@property (nonatomic, strong) MainNode *mainNode;

@end

@implementation ShellScene

@synthesize mainNode;

+ (ShellScene*)scene
{
    ShellScene *scene = [[ShellScene alloc] init];
    scene.mainNode = [MainNode node];
    [scene addChild:scene.mainNode];
    
    scene.userInteractionEnabled = YES;    
    
    return scene;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self.mainNode touchBegan:touch withEvent:event];
    
    self.mainNode.mainChar.morphMenu.visible = NO;
    [self.mainNode hideDialogBox];
}

@end
