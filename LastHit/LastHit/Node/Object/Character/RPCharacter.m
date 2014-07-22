//
//  RPCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPCharacter.h"


@implementation RPCharacter

- (void)update:(CFTimeInterval)currentTime
{
    if (currentTime-self.lastTime>self.atkInterval)
    {
        //fire
        if (self.state == States_Atk && self.target)
        {
            SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(3, 3)];
            bullet.position = self.position;
            [self.parent addChild:bullet];

            SKAction *move = [SKAction moveTo:self.target.position duration:0.25];
            SKAction *remove = [SKAction removeFromParent];
            [bullet runAction:[SKAction sequence:@[move,remove]]];
        }
        self.lastTime = currentTime;
    }
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
        float distance = [RPComFunction getDistanceWithYourPosition:self.position
                                                     targetPosition:character.position];
        //NSLog(@"distance:%f",distance);
        if (distance<=self.atkRange)
        {
            //Can fire
            self.state = States_Atk;
            self.target = character;
        }
        else
        {
            //Can't fire
            self.state = States_Move;
            self.target = nil;
        }
    }];
}


- (void)moveToTarget
{

}


- (void)attackTarget
{

}
@end

