//
//  RPComFunction.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPComFunction.h"
#import "RPCharacter.h"
#import "RPGameScene.h"
#import "RPEnemyCharacter.h"
#import "RPEnemyTower.h"

@implementation RPComFunction


+ (CGFloat)getDistanceWithYourPosition:(CGPoint)your
                      targetPosition:(CGPoint)target
{
    CGFloat absWidth = abs(your.x)-abs(target.x);
    CGFloat absHeight = abs(your.y)-abs(target.y);
    return sqrtf(absWidth*absWidth+absHeight*absHeight);
}


+ (CGFloat)getRadianWithYourPosition:(CGPoint)your
                    targetPosition:(CGPoint)target
{
    return atan2((target.y-your.y), (target.x-your.x))-M_PI_2;
}


+ (CGFloat)getCurAtkDamageWithMax:(CGFloat)maxAtk Min:(CGFloat)minAtk
{
    return (rand()%((NSInteger)maxAtk-(NSInteger)minAtk))+minAtk;
}

+ (BOOL)isHpSafe:(RPCharacter*)character
{
    return (character.curHp/character.maxHp)>0.2?YES:NO;
}

+ (SKEmitterNode*)getParticleWithName:(NSString*)particleName
{
    NSString *particlePath = [[NSBundle mainBundle] pathForResource:particleName ofType:@"sks"];
    SKEmitterNode *particle = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
    return particle;
}

+ (RPCharacter*)getCharacterWithPoint:(CGPoint)point scene:(RPGameScene*)scene
{
    NSArray *nodes = [scene nodesAtPoint:point];
    __block RPCharacter *character;
    [nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (!character)
        {
            if ([obj isKindOfClass:[RPEnemyCharacter class]])
            {
                character = (RPEnemyCharacter*)obj;
            }
            if ([obj isKindOfClass:[RPEnemyTower class]])
            {
                character = (RPEnemyTower*)obj;
            }
        }
    }];
    return character;
}

@end
