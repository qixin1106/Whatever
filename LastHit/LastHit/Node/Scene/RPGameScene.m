//
//  RPGameScene.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPGameScene.h"
#import "RPFriendCharacter.h"
#import "RPEnemyCharacter.h"
#import "RPFriendHero.h"
#import "RPMapNode.h"

@implementation RPGameScene

#pragma mark - Init
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //map
        RPMapNode *map = [[RPMapNode alloc] init];
        [self addChild:map];
        
        //UI
        SKLabelNode *gold = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        gold.zPosition = UI_LAYER;
        gold.text = @"Gold 0";
        gold.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        gold.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        gold.position = CGPointMake(0, SCREEN_HEIGHT);
        gold.fontSize = 17.0;
        gold.fontColor = [SKColor whiteColor];
        [self addChild:gold];
        
        
        //Test
        RPFriendCharacter *friend = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
        [self addChild:friend];
        
        RPFriendCharacter *friend2 = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(220, 150, 50, 50)];
        [self addChild:friend2];

        RPFriendHero *fHero = [[RPFriendHero alloc] initWithFrame:CGRectMake(160, 100, 50, 50)];
        [self addChild:fHero];

        RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
        [self addChild:enemy];

        RPEnemyCharacter *enemy2 = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(220, 400, 50, 50)];
        [self addChild:enemy2];

        RPEnemyCharacter *enemy3 = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(160, 450, 50, 50)];
        [self addChild:enemy3];
    }
    return self;
}


#pragma mark - Touch Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TEST
    //move
    CGPoint point = [[touches anyObject] locationInNode:self];
    RPFriendHero *fHero = (RPFriendHero*)[self childNodeWithName:FRIEND_HERO_NAME];
    [fHero moveToPoint:point];
}


#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    [self enumerateChildNodesWithName:ENEMY_SOLDIER_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
    [self enumerateChildNodesWithName:FRIEND_SOLDIER_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
    [self enumerateChildNodesWithName:FRIEND_HERO_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
}

@end
