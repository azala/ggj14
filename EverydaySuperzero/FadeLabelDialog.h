//
//  FadeLabelDialog.h
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/26/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface FadeLabelDialog : CCSprite

@property (nonatomic, strong) CCLabelTTF *label;

- (id)initWithTime:(CCTime)time fadingAfter:(CCTime)fadingAfter;

@end
