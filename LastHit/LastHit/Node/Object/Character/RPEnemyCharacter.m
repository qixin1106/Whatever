//
//  RPEnemyCharacter.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPEnemyCharacter.h"
#import "RPFriendCharacter.h"
#import "RPHpBarNode.h"

@implementation RPEnemyCharacter

+ (NSString*)getNodeName
{
    return ENEMY_NAME;
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
        self.texture = [SKTexture textureWithImageNamed:@"e.png"];
        self.name = ENEMY_NAME;
        self.state = States_Move;
        self.zRotation = M_PI;

        self.lastTime = 0;
        self.atkInterval = 1.3;
        self.viewRange = 300;
        self.atkRange = 100;
        self.moveSpeed = 30;

        self.maxHp = 500;
        self.curHp = self.maxHp;
        self.maxAtk = 23;
        self.minAtk = 19;
        self.armor = 2;

        [self showViewRangeLine];
        [self showAtkRangeLine];
        
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Eneny];
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
    
    [self findTargetWithName:[RPFriendCharacter getNodeName] scene:scene];
    
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
        //atk animation
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)];
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
