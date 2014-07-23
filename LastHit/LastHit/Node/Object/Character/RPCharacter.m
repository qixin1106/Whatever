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
    [scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                       targetPosition:character.position];
        if (distance<=self.viewRange)
        {
            if (self.target==nil)
            {
                //discover target
                [self changeTarget:character];
            }
        }
        else
        {
            //Can't attack
            [self changeState:States_Move];
            [self changeTarget:nil];
        }
    }];
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
#warning 这里的方法是子类必须实现的
- (void)update:(CFTimeInterval)currentTime scene:(RPGameScene *)scene{}
+ (NSString*)getNodeName{return nil;}
- (void)changeState:(States)state{}
- (void)changeTarget:(RPCharacter *)target{}
- (void)changeCurHp:(CGFloat)curHp byObj:(RPCharacter*)sender{}
- (void)attackTarget{}



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

