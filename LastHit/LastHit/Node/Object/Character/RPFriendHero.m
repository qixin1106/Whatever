//
//  RPFriendHero.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPFriendHero.h"
#import "RPHpBarNode.h"
#import "RPEnemyCharacter.h"
@implementation RPFriendHero

+ (NSString*)getNodeName
{
    return FRIEND_HERO_NAME;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.texture = [SKTexture textureWithImageNamed:@"xiaoqiang.png"];
        self.name = FRIEND_HERO_NAME;
        self.nickname = @"英雄小强";
        self.state = States_Find;
        self.lastTime = 0;
        
        self.atkInterval = 0.5;//攻击间隔
        self.viewRange = 200;//视野
        self.atkRange = 100;//攻击距离
        self.moveSpeed = 60;//移动速度
        self.maxHp = 2000;//最大血量
        self.curHp = self.maxHp;//当前血量
        self.maxAtk = 32;//最大攻击
        self.minAtk = 25;//最小攻击
        self.armor = 2;//护甲(暂时没用)
        
    }
    return self;
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    if (!self.hpBarNode)
    {
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Friend];
        [self.scene addChild:self.hpBarNode];
    }
    self.hpBarNode.position = CGPointMake(self.position.x-self.size.width*0.5,
                                          self.position.y+self.size.height*0.5+5);


    [super update:currentTime];
    [self findTargetWithName:[RPEnemyCharacter getNodeName]];
}



#pragma mark -----Override------
- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        //override attack effect here...
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)];
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
