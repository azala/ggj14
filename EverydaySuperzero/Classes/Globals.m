//
//  Globals.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "Globals.h"
#import "Utils.h"

@implementation Globals

@synthesize form, dialogue, interactionMap;

+ (id)sharedInstance
{
    static Globals *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if ((self = [super init]))
    {
        self.form = 0;
        self.interactionMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)parseDialogue
{
    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"dialogue" withExtension:@"json"];
    NSString *path = [pathURL path];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    NSError *e = nil;
    self.dialogue = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
}

- (NSString*)dialogueForForm:(int)myForm toForm:(int)otherForm mood:(int)mood
{
    NSString *key = [NSString stringWithFormat:@"As_%@", [Utils formIndexToName:myForm]];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSDictionary *dict = self.dialogue[key];
    if (dict)
    {
        key = [NSString stringWithFormat:@"To_%@", [Utils formIndexToName:otherForm]];
        key = [key stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        dict = dict[key];
        if (dict)
        {
            key = [NSString stringWithFormat:@"Mood_%d", mood];
            dict = dict[key];
            if (dict)
            {
                int index = [self.interactionMap[[NSString stringWithFormat:@"%d,%d", myForm, otherForm]] intValue];
                key = [NSString stringWithFormat:@"Phrase_%d", index];
                NSString *str = dict[key];
                return str;
            }
        }
    }
    return nil;
}

- (void)registerInteraction:(int)myForm npc:(int)npcForm
{
    NSString *key = [NSString stringWithFormat:@"%d,%d", myForm, npcForm];
    NSNumber *n = self.interactionMap[key];
    if (!n)
        self.interactionMap[key] = @1;
    else
        self.interactionMap[key] = [NSNumber numberWithInt:[n intValue] + 1];
}

@end
