//
//  RPCharacter.h
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//


#import "RPBaseObjNode.h"
#import "RPGameScene.h"

typedef enum{
    States_Stop=0,
    States_Atk=1,
    States_Move=2,
    States_Dead=3
}States;

@interface RPCharacter : RPBaseObjNode
@property (assign, nonatomic) NSTimeInterval lastTime;
@property (assign, nonatomic) NSTimeInterval atkInterval;

@property (assign, nonatomic) CGFloat atkRange;
@property (assign, nonatomic) CGFloat viewRange;
@property (assign, nonatomic) CGFloat moveSpeed;

@property (assign, nonatomic) CGFloat maxHp;
@property (assign, nonatomic) CGFloat curHp;
@property (assign, nonatomic) CGFloat maxAtk;
@property (assign, nonatomic) CGFloat minAtk;
@property (assign, nonatomic) CGFloat armor;

@property (assign, nonatomic) States state;
@property (weak, nonatomic) RPCharacter *target;

+ (NSString*)getNodeName;

- (void)update:(CFTimeInterval)currentTime;
- (void)findTargetWithName:(NSString*)name scene:(RPGameScene*)scene;

- (void)changeState:(States)state;
- (void)changeTarget:(RPCharacter *)target;
- (void)changeCurHp:(CGFloat)curHp;

- (void)showViewRangeLine;
- (void)showAtkRangeLine;
@end
