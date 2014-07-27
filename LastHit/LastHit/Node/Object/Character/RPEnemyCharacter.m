//
//  RPEnemyCharacter.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPEnemyCharacter.h"
#import "RPFriendCharacter.h"
#import "RPFriendHero.h"
#import "RPHpBarNode.h"
#import "RPFriendTower.h"
@implementation RPEnemyCharacter

+ (NSString*)getNodeName
{
    return ENEMY_SOLDIER_NAME;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.texture = [SKTexture textureWithImageNamed:@"e.png"];
        self.name = ENEMY_SOLDIER_NAME;
        self.nickname = @"敌方战士";
        self.state = States_Find;
        self.zRotation = M_PI;

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
    }
    return self;
}



#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    if (!self.hpBarNode)
    {
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Eneny width:self.size.width];
        [self.scene addChild:self.hpBarNode];
    }
    self.hpBarNode.position = CGPointMake(self.position.x-self.size.width*0.5,
                                          self.position.y+self.size.height*0.5+5);
    [super update:currentTime];
    
    [self findTargetWithName:[RPFriendCharacter getNodeName]];
    [self findTargetWithName:[RPFriendTower getNodeName]];
    [self findTargetWithName:[RPFriendHero getNodeName]];
}



#pragma mark -----Override------
- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        //atk animation
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(3, 3)];
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
