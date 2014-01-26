//
//  Globals.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

@property (nonatomic) int form;
@property (nonatomic, strong) NSDictionary *dialogue;
@property (nonatomic, strong) NSMutableDictionary *interactionMap;

+ (Globals*)sharedInstance;
- (void)parseDialogue;
- (NSString*)dialogueForForm:(int)myForm toForm:(int)otherForm mood:(int)mood;
- (void)registerInteraction:(int)myForm npc:(int)npcForm;

@end
