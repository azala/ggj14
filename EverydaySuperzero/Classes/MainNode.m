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
#import "DialogBox.h"
#import "NPCSprite.h"
#import "Globals.h"

@interface MainNode ()

@property (nonatomic, strong) CCTiledMap *tileMap;
@property (nonatomic, strong) CCTiledMapLayer *background;
@property (nonatomic, strong) CCTiledMapLayer *collision;
@property (nonatomic, strong) CCTiledMapLayer *top;
@property (nonatomic, strong) CCTiledMapLayer *under;
@property (nonatomic, strong) CCTiledMapObjectGroup *og;

@property (nonatomic) CGPoint cameraPos; //relative to map
@property (nonatomic) double minX;
@property (nonatomic) double minY;
@property (nonatomic) double maxX;
@property (nonatomic) double maxY;

@property (nonatomic, strong) DialogBox *dialogBox;
@property (nonatomic, strong) NSMutableArray *npcs;
//@property (nonatomic, strong) MorphMenu *morphMenu;

@end

@implementation MainNode

@synthesize tileMap, background, collision, top, under, minX, minY, maxX, maxY, mainChar, dialogBox, og, npcs;

- (id)init
{
	if((self = [super init]))
    {
        self.tileMap = [CCTiledMap tiledMapWithFile:@"towne.tmx"];
        
        //tile layers
        self.background = [self.tileMap layerNamed:@"Background"];
        self.collision = [self.tileMap layerNamed:@"Meta"];
        self.under = [self.tileMap layerNamed:@"Under"];
        self.top = [self.tileMap layerNamed:@"Top"];
        self.collision.visible = NO;
        self.og = [self.tileMap objectGroupNamed:@"Object Layer 1"];
        
        [self.tileMap anchorCenter];
        [self anchorCenter];
        
        [self addChild:self.tileMap z:-1];
        self.tileMap.scale = 2;
        
        self.tileMap.position = ccp([Utils screenSize].width/2, [Utils screenSize].height/2);
        self.minX = [self cameraMinX];
        self.minY = [self cameraMinY];
        self.maxX = [self cameraMaxX];
        self.maxY = [self cameraMaxY];
        
        CharacterSprite *cs = [[CharacterSprite alloc] init];
        [self.tileMap addChild:cs z:0];
        cs.position = ccp([self mapWidth]/2, [self mapHeight]/2);
        cs.destination = cs.position;
        self.mainChar = cs;
        
        //NPC population
        self.npcs = [NSMutableArray array];
        for (NSDictionary *d in self.og.objects)
        {
            double x = [d[@"x"] intValue];
            double y = [d[@"y"] intValue];
            NSString *name = [d[@"name"] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            
            NPCSprite *npc = [[NPCSprite alloc] init];
            npc.form = [Utils nameToFormIndex:name];
            npc.position = ccp(x, y);
            [self.tileMap addChild:npc];
            [self.npcs addObject:npc];
        }
        //end
        
        // dialog box
        DialogBox *db = [[DialogBox alloc] initWithTexture:[CCTexture textureWithFile:@"brown.png"] rect:CGRectMake(0,0,[Utils screenSize].width - 20,76)];
        [self addChild:db z:2];
        CGPoint p = ccp(10, 10);
        db.anchorPoint = ccp(0, 1);
        db.userInteractionEnabled = YES;
        db.visible = NO;
        p = [[CCDirector sharedDirector] convertToGL:p];
        db.position = p;
        self.dialogBox = db;
        
        db.label = [CCLabelTTF labelWithString:@"" fontName:@"Arcadepix Plus.ttf" fontSize:20 dimensions:db.boundingBox.size];
        db.label.fontColor = [CCColor whiteColor];
        db.label.anchorPoint = ccp(0,1);
        db.label.position = ccp(0, db.boundingBox.size.height);
        [db addChild:db.label];
        
        //need to add all the npcs
        
        //test
        [[Globals sharedInstance] parseDialogue];
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
    return -p.x;
}

- (double)cameraMaxX
{
    CGPoint p = [Utils point:ccp(0, 0) from:self.tileMap to:self];
    p.x += [Utils screenSize].width/2;
    return -p.x;
}

- (double)cameraMinY
{
    CGPoint p = [Utils point:ccp(0, [self mapHeight]) from:self.tileMap to:self];
    p.y -= [Utils screenSize].height/2;
    return -p.y;
}

- (double)cameraMaxY
{
    CGPoint p = [Utils point:ccp(0, 0) from:self.tileMap to:self];
    p.y += [Utils screenSize].height/2;
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
    if (dest.x >= 0 && dest.x <= [self mapWidth] && dest.y >= 0 && dest.y <= [self mapHeight] && ![self doesCollide:dest])
    {
        self.mainChar.destination = dest;
//        [Utils logPoint:[self tileCoordForPosition:self.mainChar.destination]];
    }
}

- (BOOL)doesCollide:(CGPoint)mapPoint
{
    CGPoint tileCoord = [self tileCoordForPosition:mapPoint];
    int tileGid = [self.collision tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [self.tileMap propertiesForGID:tileGid];
        if (properties) {
            
            NSString *collision1 = properties[@"Collide"];
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

//returns npc if it hit, otherwise nil
- (NPCSprite*)hitsNPC:(CGPoint)mapPoint
{
    double minDist = 1000000;
    NPCSprite *winner = nil;
    for (NPCSprite *npc in self.npcs)
    {
        double curDist = ccpDistance(npc.position, mapPoint);
        if (curDist < minDist && [npc canInteractWithMain])
        {
            minDist = curDist;
            winner = npc;
        }
    }
    if (minDist <= 10)
        return winner;
    return nil;
}

- (void)triggerInteraction:(CharacterSprite*)cs npc:(NPCSprite*)npc
{
    int a = [Globals sharedInstance].form;
    int b = npc.form;
    [[Globals sharedInstance] registerInteraction:a npc:b];
    NSString *dialogue = [[Globals sharedInstance] dialogueForForm:a toForm:b mood:1];
    if (dialogue)
    {
        [self openDialogBox];
        ((CCLabelTTF*)self.dialogBox.label).string = dialogue;
    }
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

- (void)openDialogBox
{
    self.dialogBox.visible = YES;
}

- (void)hideDialogBox
{
    self.dialogBox.visible = NO;
}

@end
