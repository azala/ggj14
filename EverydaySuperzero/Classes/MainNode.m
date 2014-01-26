//
//  MainLayer.m
//  EverydaySuperzero
//
//  Created by Michel D'Sa on 1/25/14.
//  Copyright (c) 2014 Michel D'Sa. All rights reserved.
//

#import "MainNode.h"
#import "cocos2d.h"
#import "Utils.h"
#import "CharacterSprite.h"
#import "CharacterAnimationData.h"

@interface MainNode ()

@property (nonatomic, strong) CCTiledMap *tileMap;
@property (nonatomic, strong) CCTiledMapLayer *background;
@property (nonatomic, strong) CCTiledMapLayer *meta;
@property (nonatomic, strong) CCTiledMapLayer *foreground;

@property (nonatomic) CGPoint cameraPos; //relative to map

@end

@implementation MainNode

@synthesize tileMap, background, meta, foreground;

- (id)init
{
	if((self = [super init]))
    {
        self.tileMap = [CCTiledMap tiledMapWithFile:@"desert.tmx"];
        self.background = [self.tileMap layerNamed:@"Background"];
        self.foreground = [self.tileMap layerNamed:@"Foreground"];
        self.meta = [self.tileMap layerNamed:@"Meta"];
        self.meta.visible = NO;
        
        self.anchorPoint = ccp(.5,.5);
        
        [self addChild:self.tileMap z:-1];
        self.tileMap.scale = 1;
        self.tileMap.anchorPoint = ccp(.5,.5);
        self.tileMap.position = ccp([Utils screenSize].width/2, [Utils screenSize].height/2);
        
//        [Utils logPoint:[Utils point:ccp(-[self mapWidth]/2, -[self mapHeight]/2) from:self.tileMap to:self]];
//        [Utils logPoint:[Utils point:ccp([Utils screenSize].width, [Utils screenSize].height) from:self to:self.tileMap]];
        
//        NSLog(@"[%f,%f,%f,%f]", [self cameraMinX], [self cameraMinY], [self cameraMaxX], [self cameraMaxY]);
//        
//        self.tileMap.position = ccp(-[self cameraMinX], -[self cameraMaxY]);
        
        CharacterSprite *cs = [[CharacterSprite alloc] init];
        [self.tileMap addChild:cs z:0];
        cs.position = ccp([self mapWidth]/2, [self mapHeight]/2);
    }
    return self;
}

- (double)mapWidth
{
    return self.tileMap.tileSize.width * self.tileMap.mapSize.width;
}

- (double)mapHeight
{
    return self.tileMap.tileSize.height * self.tileMap.mapSize.height;
}

- (double)cameraMinX
{
    CGPoint p = [Utils point:ccp([self mapWidth]/2, 0) from:self.tileMap to:self];
    p.x -= [Utils screenSize].width/2;
    //    return [Utils point:p from:self to:self.tileMap].x;
    return -p.x;
}

- (double)cameraMaxX
{
    CGPoint p = [Utils point:ccp(-[self mapWidth]/2, 0) from:self.tileMap to:self];
    p.x += [Utils screenSize].width/2;
    //    return [Utils point:p from:self to:self.tileMap].x;
    return -p.x;
}

- (double)cameraMinY
{
    CGPoint p = [Utils point:ccp(0, [self mapHeight]/2) from:self.tileMap to:self];
    p.y -= [Utils screenSize].height/2;
    //    return [Utils point:p from:self to:self.tileMap].y;
    return -p.y;
}

- (double)cameraMaxY
{
    CGPoint p = [Utils point:ccp(0, -[self mapHeight]/2) from:self.tileMap to:self];
    p.y += [Utils screenSize].height/2;
    //    return [Utils point:p from:self to:self.tileMap].y;
    return -p.y;
}

- (void)update:(CCTime)delta
{
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [self convertToNodeSpace:[[CCDirector sharedDirector] convertToGL:touchLocation]];
    [self moveCameraToScenePoint:touchLocation];
    
//    CGPoint q = [Utils point:p from:self to:self.tileMap];
//    [self moveCameraToMapPoint:q];
}

- (void)moveCameraToMapPoint:(CGPoint)point
{
    [self moveCameraToScenePoint:[Utils point:point from:self.tileMap to:self]];
}

- (void)moveCameraToScenePoint:(CGPoint)point
{
    double dx = point.x - [Utils screenSize].width/2;
    double dy = point.y - [Utils screenSize].height/2;
    self.tileMap.position = ccp(self.tileMap.position.x - dx, self.tileMap.position.y - dy);
}

@end
