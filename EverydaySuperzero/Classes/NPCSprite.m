//
//  NPCSprite.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "NPCSprite.h"
#import "Globals.h"
#import "Utils.h"

@implementation NPCSprite

@synthesize relationship, currentDialogNumber, form;

- (id)init
{
    if ((self = [super init]))
    {
        self.form = 0;
        self.relationship = 0;
        self.currentDialogNumber = 1;
    }
    return self;
}

- (void)update:(CCTime)delta
{
    //can we see this NPC?
    int gform = [Globals sharedInstance].form;
//    if (self.form == gform)
//    {
        self.visible = (self.form != gform);
//    }
    if (self.form == 3)
    {
        self.visible = (gform == 0 || gform == 6);
    }
    
    [self doSecretStuff];
}

- (BOOL)canInteractWithMain
{
//    int gform = [Globals sharedInstance].form;
    if (!self.visible)
        return NO;
//    if (self.form == 13)
//    {
//        return (gform == 2);
//    }
    return YES;
}

- (NSString*)specialImageWithMain
{
    int gform = [Globals sharedInstance].form;
    if (!self.visible)
        return nil;
    if (gform == 6 && self.form == 15)
        return @"Steak.png";
    if (gform == 7)
        return @"Target.png";
    if (gform == 1 && self.form == 3)
        return @"Scary Hobo.png";
    return nil;
}

- (void)applyTextureFromFile:(NSString*)file
{
    CCTexture *texture = [CCTexture textureWithFile:file];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTexture:texture];
    [self setTextureRect:rect];
}

- (void)doSecretStuff
{
    NSString *s = [self specialImageWithMain];
    if (s)
    {
        [self applyTextureFromFile:s];
    }
    else
    {
        NSString *fn = [NSString stringWithFormat:@"%@.png", [Utils formIndexToName:self.form]];
        [self applyTextureFromFile:fn];
    }
}

@end
