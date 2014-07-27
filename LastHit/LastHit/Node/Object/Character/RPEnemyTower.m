//
//  RPFriendHero.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPEnemyTower.h"
#import "RPHpBarNode.h"
#import "RPFriendCharacter.h"
#import "RPFriendHero.h"

@implementation RPEnemyTower

+ (NSString*)getNodeName
{
    return ENEMY_TOWER_NAME;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.texture = [SKTexture textureWithImageNamed:@"et.png"];
        self.name = ENEMY_TOWER_NAME;
        self.nickname = @"敌方塔";
        self.state = States_Find;
        self.lastTime = 0;
        
        self.atkInterval = 1.2;//攻击间隔
        self.viewRange = 150;//视野
        self.atkRange = 150;//攻击距离
        self.moveSpeed = 0;//移动速度
        self.maxHp = 1200;//最大血量
        self.curHp = self.maxHp;//当前血量
        self.maxAtk = 80;//最大攻击
        self.minAtk = 60;//最小攻击
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
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Eneny width:self.size.width];
        [self.scene addChild:self.hpBarNode];
    }
    self.hpBarNode.position = CGPointMake(self.position.x-self.size.width*0.5,
                                          self.position.y+self.size.height*0.5+5);
    
    
    [super update:currentTime];
    
    [self findTargetWithName:[RPFriendHero getNodeName]];
    [self findTargetWithName:[RPFriendCharacter getNodeName]];
}



#pragma mark -----Override------
- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        //override attack effect here...
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)];
        bullet.zPosition = BULLET_LAYER;
        bullet.position = self.position;
        [self.parent addChild:bullet];
        
        SKEmitterNode *rocketEmitter = [RPComFunction getParticleWithName:@"Rocket"];
        rocketEmitter.targetNode = self.scene;
        [bullet addChild:rocketEmitter];
        
        SKAction *move = [SKAction moveTo:self.target.position duration:0.49];
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
