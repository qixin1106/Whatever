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

@implementation RPFriendCharacter

+ (NSString*)getNodeName
{
    return FRIEND_NAME;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNode:) name:UPDATE_MSG object:nil];
        self.texture = [SKTexture textureWithImageNamed:@"f.png"];
        self.name = FRIEND_NAME;
        self.state = States_Move;
        self.lastTime = 0;

        self.atkInterval = 0.1;
        self.viewRange = 300;
        self.atkRange = 50;
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
- (void)updateNode:(NSNotification*)notification
{
    
    RPGameScene *scene = [notification.userInfo objectForKey:@"kScene"];
    NSTimeInterval currentTime = [[notification.userInfo objectForKey:@"kTime"] doubleValue];
    
    [self findTargetWithName:[RPEnemyCharacter getNodeName] scene:scene];

    //contrl atk
    if (currentTime-self.lastTime>self.atkInterval)
    {
        //fire
        [self attackTarget];
        self.lastTime = currentTime;
    }
    //control direction
    if (self.target)
    {
        self.zRotation = [RPComFunction getRadianWithYourPosition:self.position
                                                   targetPosition:self.target.position];
    }
    //move
    [self moveToTarget];
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
        [bullet runAction:[SKAction sequence:@[move,remove]]];

        //logic
        CGFloat damage = [RPComFunction getCurAtkDamageWithMax:self.maxAtk
                                                           Min:self.minAtk];
        [self.target changeCurHp:self.target.curHp-damage byObj:self];
    }
}

@end
