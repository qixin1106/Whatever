//
//  RPCharacter.h
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import "RPGameScene.h"
typedef enum{
    States_Stop=0,
    States_Atk=1,
    States_Move=2,
    States_Dead=3
}States;

@interface RPCharacter : SKSpriteNode

@property (assign, nonatomic) NSTimeInterval lastTime;
@property (assign, nonatomic) NSTimeInterval atkInterval;
@property (assign, nonatomic) float atkRange;
@property (assign, nonatomic) States state;
@property (weak, nonatomic) RPCharacter *target;

- (void)update:(CFTimeInterval)currentTime;
- (float)getDistanceWithCharacter:(RPCharacter*)character;
- (void)findTargetWithName:(NSString*)name scene:(RPGameScene*)scene;
+ (NSString*)getNodeName;
@end
