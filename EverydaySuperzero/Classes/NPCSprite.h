//
//  NPCSprite.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CCSprite.h"

@interface NPCSprite : CCSprite

@property (nonatomic) int relationship;
@property (nonatomic) int currentDialogNumber;
@property (nonatomic) int form;

- (BOOL)canInteractWithMain;

@end
