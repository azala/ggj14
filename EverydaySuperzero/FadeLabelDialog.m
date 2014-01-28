//
//  FadeLabelDialog.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/26/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "FadeLabelDialog.h"

@implementation FadeLabelDialog {
    CCTime initTime_;
    CCTime fadeAfter_;
    CCTime t;
}

@synthesize label;

- (id)initWithTime:(CCTime)time fadingAfter:(CCTime)fadingAfter
{
    if ((self = [super init]))
    {
        initTime_ = time;
        fadeAfter_ = fadingAfter;
        t = 0;
    }
    return self;
}

- (void)update:(CCTime)delta
{
    t += delta;
    if (t >= fadeAfter_)
    {
        if (t <= initTime_)
            self.label.opacity = (initTime_ - t) / (initTime_ - fadeAfter_);
        else
            self.label.opacity = 0;
    }
}

@end
