//
//  RPCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPCharacter.h"


@implementation RPCharacter


- (void)findTargetWithName:(NSString*)name scene:(RPGameScene*)scene
{
    if (!self.target)
    {
        [scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
            RPCharacter *character = (RPCharacter*)node;
            CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                           targetPosition:character.position];
            if (distance<=self.viewRange)
            {
                    //discover target
                [self changeTarget:character];
                return;
            }
            else
            {
                //Can't attack
                [self changeState:States_Move];
                [self changeTarget:nil];
            }
        }];
    }
}



- (void)moveToTarget
{
    if (self.state == States_Move && self.target)
    {
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                       targetPosition:self.target.position];
        SKAction *run = [SKAction moveTo:self.target.position duration:distance/self.moveSpeed];
        [self runAction:run];

        if (distance<=self.atkRange)
        {
            //can attack
            [self changeState:States_Atk];
        }
        else
        {
            //can move to target
            [self changeState:States_Move];
        }
    }
    if (self.state != States_Move)
    {
        [self removeAllActions];
    }
}







#pragma mark - The subclass implementation
+ (NSString*)getNodeName{return nil;}
- (void)attackTarget{}



#pragma mark -
- (void)changeState:(States)state
{
    if (self.state!=state)
    {
        self.state=state;
        switch (self.state)
        {
            case States_Atk:
            {
                NSLog(@"[%@]呕哼~~(豺狼人)",self.name);
                break;
            }
            case States_Dead:
            {
                NSLog(@"[%@]祖国万岁",self.name);
                self.target = nil;
                [self removeAllActions];
                [self removeFromParent];
                break;
            }
            case States_Move:
            {
                NSLog(@"[%@]为了部落",self.name);
                break;
            }
            case States_Stop:
            {
                NSLog(@"[%@]Stop",self.name);
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
            NSLog(@"[%@]要死了,要死了,要死了",self.name);
        }
        if (self.curHp<=0)
        {
            //Dead
            [self changeState:States_Dead];
            //change sender state
            [sender changeTarget:nil];
            [sender changeState:States_Move];
        }
    }
}



#pragma mark - Debug
- (void)showViewRangeLine
{
    SKShapeNode *viewRangeLine = [SKShapeNode node];
    viewRangeLine.strokeColor = RGB(0, 0, 0);
    viewRangeLine.lineWidth = 1.0f;

    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                            radius:self.viewRange
                                                        startAngle:M_PI
                                                          endAngle:-M_PI
                                                         clockwise:YES];
    viewRangeLine.path = ovalPath.CGPath;
    [self addChild:viewRangeLine];
}

- (void)showAtkRangeLine
{
    SKShapeNode *viewRangeLine = [SKShapeNode node];
    viewRangeLine.strokeColor = RGB(255, 0, 0);
    viewRangeLine.lineWidth = 1.0f;

    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                            radius:self.atkRange
                                                        startAngle:M_PI
                                                          endAngle:-M_PI
                                                         clockwise:YES];
    viewRangeLine.path = ovalPath.CGPath;
    [self addChild:viewRangeLine];
}
@end

