//
//  MainLayer.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "MainNode.h"
#import "cocos2d.h"

@interface MainNode ()

@property (nonatomic, strong) CCTiledMap *tileMap;
@property (nonatomic, strong) CCTiledMapLayer *background;
@property (nonatomic, strong) CCTiledMapLayer *meta;
@property (nonatomic, strong) CCTiledMapLayer *foreground;

@end

@implementation MainNode

@synthesize tileMap;

@end
