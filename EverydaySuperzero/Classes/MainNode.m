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
@property (nonatomic, strong) CCTiledMapLayer *collision;
@property (nonatomic, strong) CCTiledMapLayer *top;
@property (nonatomic, strong) CCTiledMapLayer *under;

@property (nonatomic) CGPoint cameraPos; //relative to map
@property (nonatomic) double minX;
@property (nonatomic) double minY;
@property (nonatomic) double maxX;
@property (nonatomic) double maxY;

@property (nonatomic, strong) CharacterSprite *mainChar;

@end

@implementation MainNode

@synthesize tileMap, background, collision, top, under, minX, minY, maxX, maxY, mainChar;

- (id)init
{
	if((self = [super init]))
    {
        self.tileMap = [CCTiledMap tiledMapWithFile:@"towne.tmx"];
        self.background = [self.tileMap layerNamed:@"Background"];
        self.collision = [self.tileMap layerNamed:@"Collision"];
        self.under = [self.tileMap layerNamed:@"Under"];
        self.top = [self.tileMap layerNamed:@"Top"];
        
        self.collision.visible = NO;
        
        self.anchorPoint = ccp(.5,.5);
        
        [self addChild:self.tileMap z:-1];
        self.tileMap.scale = 2;
        self.tileMap.anchorPoint = ccp(.5,.5);
        self.tileMap.position = ccp([Utils screenSize].width/2, [Utils screenSize].height/2);
        
//        [Utils logPoint:[Utils point:ccp(-[self mapWidth]/2, -[self mapHeight]/2) from:self.tileMap to:self]];
//        [Utils logPoint:[Utils point:ccp([Utils screenSize].width, [Utils screenSize].height) from:self to:self.tileMap]];
        
//        NSLog(@"[%f,%f,%f,%f]", [self cameraMinX], [self cameraMinY], [self cameraMaxX], [self cameraMaxY]);
        self.minX = [self cameraMinX];
        self.minY = [self cameraMinY];
        self.maxX = [self cameraMaxX];
        self.maxY = [self cameraMaxY];
//
//        self.tileMap.position = ccp(-[self cameraMinX], -[self cameraMaxY]);
        
        CharacterSprite *cs = [[CharacterSprite alloc] init];
        [self.tileMap addChild:cs z:0];
        cs.position = ccp([self mapWidth]/2, [self mapHeight]/2);
        cs.destination = cs.position;
        self.mainChar = cs;
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
    CGPoint p = [Utils point:ccp([self mapWidth], 0) from:self.tileMap to:self];
    p.x -= [Utils screenSize].width/2;
    //    return [Utils point:p from:self to:self.tileMap].x;
    return -p.x;
}

- (double)cameraMaxX
{
    CGPoint p = [Utils point:ccp(0, 0) from:self.tileMap to:self];
    p.x += [Utils screenSize].width/2;
    //    return [Utils point:p from:self to:self.tileMap].x;
    return -p.x;
}

- (double)cameraMinY
{
    CGPoint p = [Utils point:ccp(0, [self mapHeight]) from:self.tileMap to:self];
    p.y -= [Utils screenSize].height/2;
    //    return [Utils point:p from:self to:self.tileMap].y;
    return -p.y;
}

- (double)cameraMaxY
{
    CGPoint p = [Utils point:ccp(0, 0) from:self.tileMap to:self];
    p.y += [Utils screenSize].height/2;
    //    return [Utils point:p from:self to:self.tileMap].y;
    return -p.y;
}

- (void)update:(CCTime)delta
{
    [self moveCameraToMapPoint:self.mainChar.position];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGPoint dest = [Utils point:touchLocation from:self to:self.tileMap];
    if (dest.x >= 0 && dest.x <= [self mapWidth] && dest.y >= 0 && dest.y <= [self mapHeight])
    {
        self.mainChar.destination = dest;
//        [Utils logPoint:[self tileCoordForPosition:self.mainChar.destination]];
    }
}

- (BOOL)doesCollide:(CGPoint)mapPoint
{
    CGPoint tileCoord = [self tileCoordForPosition:self.mainChar.destination];
    int tileGid = [self.collision tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [self.tileMap propertiesForGID:tileGid];
        if (properties) {
            
            NSString *collision1 = properties[@"Collidable"];
            if (collision1 && [collision1 isEqualToString:@"True"]) {
                return YES;
            }
            
//            NSString *collectible = properties[@"Collectable"];
//            if (collectible && [collectible isEqualToString:@"True"]) {
//                [[SimpleAudioEngine sharedEngine] playEffect:@"pickup.caf"];
//                self.numCollected++;
//                [_hud numCollectedChanged:_numCollected];
//                
//                [_meta removeTileAt:tileCoord];
//                [_foreground removeTileAt:tileCoord];
//            }
        }
    }
    return NO;
}



- (void)moveCameraToMapPoint:(CGPoint)point
{
    [self moveCameraToScenePoint:[Utils point:point from:self.tileMap to:self]];
}

- (void)moveCameraToScenePoint:(CGPoint)point
{
    double dx = point.x - [Utils screenSize].width/2;
    double dy = point.y - [Utils screenSize].height/2;
    
    double px = MAX(MIN(self.tileMap.position.x - dx, -self.minX), -self.maxX);
    double py = MAX(MIN(self.tileMap.position.y - dy, -self.minY), -self.maxY);
    
    self.tileMap.position = ccp(px, py);
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / self.tileMap.tileSize.width;
    int y = ((self.tileMap.mapSize.height * self.tileMap.tileSize.height) - position.y) / self.tileMap.tileSize.height;
    return ccp(x, y);
}

@end
