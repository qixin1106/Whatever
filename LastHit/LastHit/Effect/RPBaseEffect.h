//
//  RPBaseEffect.h
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class RPCharacter;
@interface RPBaseEffect : SKSpriteNode
@property (assign, nonatomic) CGFloat moveSpeed;
- (instancetype)initWithFromCharacter:(RPCharacter*)fromNode
                          toCharacter:(RPCharacter*)toTarget;
- (void)update:(NSTimeInterval)currentTime;
@end
