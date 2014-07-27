//
//  RPComFunction.h
//  LastHit
//
//  Created by 亓鑫 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;
@class RPCharacter;
@class RPFriendHero;
@class RPGameScene;
@interface RPComFunction : NSObject
+ (CGFloat)getDistanceWithYourPosition:(CGPoint)your
                      targetPosition:(CGPoint)target;

+ (CGFloat)getRadianWithYourPosition:(CGPoint)your
                    targetPosition:(CGPoint)target;

+ (CGFloat)getCurAtkDamageWithMax:(CGFloat)maxAtk Min:(CGFloat)minAtk;

+ (BOOL)isHpSafe:(RPCharacter*)character;

+ (SKEmitterNode*)getParticleWithName:(NSString*)particleName;

+ (RPCharacter*)getCharacterWithPoint:(CGPoint)point scene:(RPGameScene*)scene;

+ (RPFriendHero*)getHeroWithScene:(SKScene*)scene;

+ (NSInteger)getCharacterLevelWithExp:(NSInteger)exp;
@end
