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
        self.lastTime = 0;
        self.atkInterval = 1.3;
        self.viewRange = 200;
        self.atkRange = 50;
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
                NSLog(@"为了部落!!");
                break;
            }
            case States_Dead:
            {
                NSLog(@"祖国万岁!!");
                break;
            }
            case States_Move:
            {
                NSLog(@"力量与荣耀!");
                break;
            }
            case States_Stop:
            {
                NSLog(@"Stop");
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
            NSLog(@"兄弟们搞死他!");
        }
    }
}


#pragma mark - Change HP
- (void)changeCurHp:(CGFloat)curHp
{
    if (self.curHp != curHp)
    {
        self.curHp = curHp;
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
        }
    }
}


@end
