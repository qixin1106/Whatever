//
//  RPCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPCharacter.h"


@implementation RPCharacter

#pragma mark - Update
- (void)update:(CFTimeInterval)currentTime
{
    if (currentTime-self.lastTime>self.atkInterval)
    {
        //fire
        [self attackTarget];
        self.lastTime = currentTime;
    }
    self.zRotation = [RPComFunction getRadianWithYourPosition:self.position
                                               targetPosition:self.target.position];
    [self moveToTarget];
}



#pragma mark - base function
+ (NSString*)getNodeName
{
    return nil;
}




- (void)findTargetWithName:(NSString*)name scene:(RPGameScene*)scene
{
    [scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                     targetPosition:character.position];
        //NSLog(@"distance:%f",distance);
        if (distance<=self.viewRange)
        {
            //discover target
            self.target = character;
            if (distance<=self.atkRange)
            {
                //can attack
                self.state = States_Atk;
            }
            else
            {
                //can move to target
                self.state = States_Move;
            }
        }
        else
        {
            //Can't attack
            self.state = States_Move;
            self.target = nil;
        }
    }];
}


- (void)moveToTarget
{
    if (self.state == States_Move && self.target)
    {
        CGFloat distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                       targetPosition:self.target.position];
        //[self removeActionForKey:@"Move"];
        SKAction *run = [SKAction moveTo:self.target.position duration:distance/self.moveSpeed];
        [self runAction:run];
    }
}


- (void)attackTarget
{
    if (self.state == States_Atk && self.target)
    {
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)];
        bullet.position = self.position;
        [self.parent addChild:bullet];

        SKAction *move = [SKAction moveTo:self.target.position duration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        [bullet runAction:[SKAction sequence:@[move,remove]]];
    }
}


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

