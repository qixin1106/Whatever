//
//  RPCharacter.h
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>

typedef enum{
    States_Stop=0,
    States_Atk=1,
    States_Move=2,
    States_Dead=3
}States;

@class RPHpBarNode;
@interface RPCharacter : SKSpriteNode
@property (assign, nonatomic) NSTimeInterval lastTime;

@property (assign, nonatomic) NSTimeInterval atkInterval;
@property (assign, nonatomic) CGFloat atkRange;
@property (assign, nonatomic) CGFloat viewRange;
@property (assign, nonatomic) CGFloat moveSpeed;

@property (copy, nonatomic) NSString *nickname;
@property (assign, nonatomic) CGFloat maxHp;
@property (assign, nonatomic) CGFloat curHp;
@property (assign, nonatomic) CGFloat maxAtk;
@property (assign, nonatomic) CGFloat minAtk;
@property (assign, nonatomic) CGFloat armor;

@property (assign, nonatomic) States state;
@property (weak, nonatomic) RPCharacter *target;

@property (strong, nonatomic) RPHpBarNode *hpBarNode;


- (instancetype)initWithFrame:(CGRect)frame;

+ (NSString*)getNodeName;

- (void)findTargetWithName:(NSString*)name;
- (void)moveToTarget;

- (void)changeState:(States)state;
- (void)changeTarget:(RPCharacter *)target;
- (void)changeCurHp:(CGFloat)curHp byObj:(RPCharacter*)sender;

- (void)showViewRangeLine;
- (void)showAtkRangeLine;
@end

