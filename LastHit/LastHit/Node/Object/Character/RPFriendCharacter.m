//
//  RPFriendCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPFriendCharacter.h"
#import "RPEnemyCharacter.h"

@implementation RPFriendCharacter

+ (NSString*)getNodeName
{
    return FRIEND_NAME;
}

- (instancetype)init
{
    self = [super initWithImageNamed:@"f.png"];
    if (self)
    {
        self.size = CGSizeMake(50, 50);
        self.name = FRIEND_NAME;
        self.state = States_Move;
        self.lastTime = 0;

        self.atkInterval = 0.1;
        self.viewRange = 300;
        self.atkRange = 100;
        self.moveSpeed = 30;
        self.maxHp = 2000;
        self.curHp = self.maxHp;
        self.maxAtk = 32;
        self.minAtk = 25;
        self.armor = 2;

#ifdef DEBUG
        [self showViewRangeLine];
        [self showAtkRangeLine];
#endif
    }
    return self;
}


#pragma mark -----Override------
#pragma mark - Change states
- (void)update:(CFTimeInterval)currentTime scene:(RPGameScene *)scene
{
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


- (void)changeState:(States)state
{
    if (self.state!=state)
    {
        self.state=state;
        switch (self.state)
        {
            case States_Atk:
            {
                //NSLog(@"呕哼~~(豺狼人)");
                break;
            }
            case States_Dead:
            {
                NSLog(@"猎人终有一天会成为猎物");
                break;
            }
            case States_Move:
            {
                //NSLog(@"Go go go");
                break;
            }
            case States_Stop:
            {
                //NSLog(@"Stop");
                break;
            }
            default:
                break;
        }
    }
}


#pragma mark - Change target
- (void)changeTarget:(RPCharacter *)target
{
    if (self.target != target)
    {
        self.target = target;
        //Miss target
        if (!self.target)
        {
            [self removeAllActions];
        }
        else
        {
            //Find a Target
            //NSLog(@"Fresh meat,Hahaha!");
        }
    }
}


#pragma mark - Change HP
- (void)changeCurHp:(CGFloat)curHp byObj:(RPCharacter *)sender
{
    if (self.curHp != curHp && self.curHp>0)
    {
        self.curHp = (curHp<0)?0:curHp;
        NSLog(@"[%@] HP:%.0f/%.0f(%.2f%%)",self.name,self.curHp,self.maxHp,(self.curHp/self.maxHp)*100);
        if (![RPComFunction isHpSafe:self])
        {
            NSLog(@"要死了,要死了,要死了");
        }
        if (self.curHp<=0)
        {
            //Dead
            [self changeState:States_Dead];
            [self removeAllActions];
            [self removeFromParent];
            //change sender state
            [sender changeState:States_Move];
        }
    }
}


- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        //override attack effect here...
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)];
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
