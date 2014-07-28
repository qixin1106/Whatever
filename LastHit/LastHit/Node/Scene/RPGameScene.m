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
#import "RPFriendTower.h"
#import "RPEnemyTower.h"
#import "RPEnemyHero.h"

@interface RPGameScene ()
@property (strong, nonatomic) SKLabelNode *goldText;
@property (strong, nonatomic) SKLabelNode *lvText;
@property (strong, nonatomic) SKLabelNode *expText;
@property (strong, nonatomic) SKLabelNode *powerText;
@end

@implementation RPGameScene

int rand()
{
    return (arc4random()%50)-25;
}
- (void)creatSoldier
{
    //friend
    RPFriendCharacter *friend = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(50+rand(), 100+rand(), 25, 25)];
    [self addChild:friend];
    
    RPFriendCharacter *friend2 = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(100+rand(), 100+rand(), 25, 25)];
    [self addChild:friend2];
    
    RPFriendCharacter *friend3 = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(150+rand(), 100+rand(), 25, 25)];
    [self addChild:friend3];


    
    //enemy
    RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50+rand(), SCREEN_HEIGHT-100+rand(), 25, 25)];
    [self addChild:enemy];

    RPEnemyCharacter *enemy2 = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100+rand(), SCREEN_HEIGHT-100+rand(), 25, 25)];
    [self addChild:enemy2];

    RPEnemyCharacter *enemy3 = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150+rand(), SCREEN_HEIGHT-100+rand(), 25, 25)];
    [self addChild:enemy3];

}


#pragma mark - Init
- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //map
        RPMapNode *map = [[RPMapNode alloc] init];
        [self addChild:map];

        //造兵
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(creatSoldier) userInfo:nil repeats:YES];
        [self creatSoldier];
        
        //造塔
        RPFriendTower *ftower = [[RPFriendTower alloc] initWithFrame:CGRectMake(60, 60, 40, 40)];
        [self addChild:ftower];
        
        RPEnemyTower *etower = [[RPEnemyTower alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60,SCREEN_HEIGHT-60, 40, 40)];
        [self addChild:etower];
        
        //英雄
        RPFriendHero *fHero = [[RPFriendHero alloc] initWithFrame:CGRectMake(160, 50, 25, 25)];
        [self addChild:fHero];

        RPEnemyHero *eHero = [[RPEnemyHero alloc] initWithFrame:CGRectMake(160, SCREEN_HEIGHT-50, 25, 25)];
        [self addChild:eHero];

        
        
        //UI
        self.lvText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.lvText.zPosition = UI_LAYER;
        self.lvText.text = @"Level:1";
        self.lvText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.lvText.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.lvText.position = CGPointMake(0, SCREEN_HEIGHT);
        self.lvText.fontSize = 17.0;
        self.lvText.fontColor = [SKColor whiteColor];
        [self addChild:self.lvText];
        
        self.expText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.expText.zPosition = UI_LAYER;
        self.expText.text = @"Exp:0";
        self.expText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.expText.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.expText.position = CGPointMake(0, SCREEN_HEIGHT-20);
        self.expText.fontSize = 17.0;
        self.expText.fontColor = [SKColor whiteColor];
        [self addChild:self.expText];

        self.goldText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.goldText.zPosition = UI_LAYER;
        self.goldText.text = @"Gold:0";
        self.goldText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.goldText.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.goldText.position = CGPointMake(0, SCREEN_HEIGHT-40);
        self.goldText.fontSize = 17.0;
        self.goldText.fontColor = [SKColor whiteColor];
        [self addChild:self.goldText];

        self.powerText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.powerText.zPosition = UI_LAYER;
        self.powerText.text = @"Power:0";
        self.powerText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.powerText.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.powerText.position = CGPointMake(0, SCREEN_HEIGHT-60);
        self.powerText.fontSize = 17.0;
        self.powerText.fontColor = [SKColor whiteColor];
        [self addChild:self.powerText];

        //skill button
        SKSpriteNode *skillButton = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor]
                                                                 size:CGSizeMake(30, 30)];
        skillButton.name = SKILL_BUTTON;
        skillButton.position = CGPointMake(SCREEN_WIDTH-30, 30);
        skillButton.anchorPoint = CGPointMake(0, 0);
        [self addChild:skillButton];
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
    
    RPCharacter *enemy = [RPComFunction getCharacterWithPoint:point
                                                        scene:self];
    fHero.target = enemy;


    //OnClick
    NSArray *nodes = [self nodesAtPoint:point];
    [nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[SKSpriteNode class]])
        {
            SKSpriteNode *node = (SKSpriteNode*)obj;
            if ([node.name isEqualToString:SKILL_BUTTON])
            {
                //onClick Skill Button
            }
        }
    }];
}


#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    [self enumerateChildNodesWithName:FRIEND_TOWER_NAME usingBlock:^(SKNode *node, BOOL *stop) {
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
    
    
    
    [self enumerateChildNodesWithName:ENEMY_TOWER_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
    [self enumerateChildNodesWithName:ENEMY_SOLDIER_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
    [self enumerateChildNodesWithName:ENEMY_HERO_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];

}


#pragma mark - change Gold
- (void)refreshUIWithCharacter:(RPCharacter*)character
{
    self.lvText.text = [NSString stringWithFormat:@"Level:%ld",(long)character.lv];
    self.expText.text = [NSString stringWithFormat:@"Exp:%ld/%d",(long)character.exp,3*character.lv];
    self.goldText.text = [NSString stringWithFormat:@"Gold:%ld",(long)character.gold];
    self.powerText.text = [NSString stringWithFormat:@"Power:%ld/3",(long)character.power];
}

@end
