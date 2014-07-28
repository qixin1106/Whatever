//
//  RPFriendCharacter.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPFriendCharacter.h"
#import "RPEnemyCharacter.h"
#import "RPHpBarNode.h"
#import "RPEnemyTower.h"
#import "RPEnemyHero.h"
@implementation RPFriendCharacter

+ (NSString*)getNodeName
{
    return FRIEND_SOLDIER_NAME;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.texture = [SKTexture textureWithImageNamed:@"f.png"];
        self.name = FRIEND_SOLDIER_NAME;
        self.nickname = @"友方战士";
        self.state = States_Find;
        self.lastTime = 0;

        self.atkInterval = 1.0;
        self.viewRange = VIEW_RANGE;
        self.atkRange = 50;
        self.moveSpeed = 30;
        self.maxHp = 500;
        self.curHp = self.maxHp;
        self.maxAtk = 23;
        self.minAtk = 19;
        self.armor = 2;
//        [self showViewRangeLine];
//        [self showAtkRangeLine];
        int rand = arc4random()%100-50;
        [self moveToPoint:CGPointMake(SCREEN_WIDTH*0.5+rand, SCREEN_HEIGHT*0.5-50)];

    }
    return self;
}



#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    if (!self.hpBarNode)
    {
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Friend width:self.size.width];
        [self.scene addChild:self.hpBarNode];
    }
    self.hpBarNode.position = CGPointMake(self.position.x-self.size.width*0.5,
                                          self.position.y+self.size.height*0.5+5);

    [super update:currentTime];
    [self findTargetWithName:[RPEnemyCharacter getNodeName]];
    [self findTargetWithName:[RPEnemyHero getNodeName]];
    [self findTargetWithName:[RPEnemyTower getNodeName]];
}



#pragma mark -----Override------
- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        //override attack effect here...
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(3, 3)];
        bullet.zPosition = BULLET_LAYER;
        bullet.position = self.position;
        [self.parent addChild:bullet];

        SKAction *move = [SKAction moveTo:self.target.position duration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        [bullet runAction:[SKAction sequence:@[move,remove]] completion:^{
            //logic
            CGFloat damage = [RPComFunction getCurAtkDamageWithMax:self.maxAtk
                                                               Min:self.minAtk];
            [self.target changeCurHp:self.target.curHp-damage byObj:self];
        }];

    }
}

@end
