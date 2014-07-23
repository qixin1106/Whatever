//
//  RPEnemyCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPEnemyCharacter.h"
#import "RPFriendCharacter.h"

@implementation RPEnemyCharacter

+ (NSString*)getNodeName
{
    return ENEMY_NAME;
}



- (instancetype)init
{
    self = [super initWithImageNamed:@"e.png"];
    if (self)
    {
        self.size = CGSizeMake(50, 50);
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

#ifdef DEBUG
        [self showViewRangeLine];
        [self showAtkRangeLine];
#endif

    }
    return self;
}




#pragma mark -----Override------
- (void)update:(CFTimeInterval)currentTime scene:(RPGameScene *)scene
{
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


#pragma mark - Change states
- (void)changeState:(States)state
{
    if (self.state!=state)
    {
        self.state=state;
        switch (self.state)
        {
            case States_Atk:
            {
                //NSLog(@"为了部落!!");
                break;
            }
            case States_Dead:
            {
                NSLog(@"祖国万岁!!");
                break;
            }
            case States_Move:
            {
                //NSLog(@"力量与荣耀!");
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
            //NSLog(@"兄弟们搞死他!");
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
            NSLog(@"锁哥强!");
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
        //atk animation
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
