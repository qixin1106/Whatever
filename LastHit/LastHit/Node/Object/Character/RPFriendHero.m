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
    return FRIEND_NAME;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.texture = [SKTexture textureWithImageNamed:@"xiaoqiang.png"];
        self.name = FRIEND_NAME;
        self.nickname = @"英雄小强";
        self.state = States_Move;
        self.lastTime = 0;
        
        self.atkInterval = 0.5;
        self.viewRange = 300;
        self.atkRange = 100;
        self.moveSpeed = 30;
        self.maxHp = 2000;
        self.curHp = self.maxHp;
        self.maxAtk = 32;
        self.minAtk = 25;
        self.armor = 2;
        
        [self showViewRangeLine];
        [self showAtkRangeLine];
        
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Friend];
        self.hpBarNode.position = CGPointMake(-self.size.width*0.5,
                                              self.size.height*0.5+5);
        [self addChild:self.hpBarNode];
        
    }
    return self;
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
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
