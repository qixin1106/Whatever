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
    if (self.target)
    {
        self.zRotation = [RPComFunction getRadianWithYourPosition:self.position
                                                   targetPosition:self.target.position];
    }
    [self moveToTarget];
}



#pragma mark - Base function
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
        if (distance<=self.viewRange)
        {
            //discover target
            if (self.target==nil)
            {
                [self changeTarget:character];
            }
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
    }
    if (self.state != States_Move)
    {
        [self removeAllActions];
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
        CGFloat damage = self.target.curHp-[RPComFunction getCurAtkDamageWithMax:self.maxAtk
                                                                             Min:self.minAtk];
        [self.target changeCurHp:damage];
    }
}





#pragma mark - The subclass implementation
- (void)changeState:(States)state{}
- (void)changeTarget:(RPCharacter *)target{}
- (void)changeCurHp:(CGFloat)curHp{}




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

