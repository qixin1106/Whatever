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

        self.atkInterval = 0.5;
        self.viewRange = 200;
        self.atkRange = 150;
        self.moveSpeed = 50;
        self.maxHp = 500;
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
                NSLog(@"呕哼~~(豺狼人)");
                break;
            }
            case States_Dead:
            {
                NSLog(@"猎人终有一天会成为猎物");
                break;
            }
            case States_Move:
            {
                NSLog(@"Go go go");
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
            NSLog(@"Fresh meat,Hahaha!");
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
            NSLog(@"要死了,要死了,要死了");
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
