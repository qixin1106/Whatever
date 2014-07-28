//
//  RPBulletNode.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-28.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPBulletNode.h"

@interface RPBulletNode ()
@property (strong, nonatomic) SKEmitterNode *rocketEmitter;
@end
@implementation RPBulletNode

- (instancetype)initWithFromCharacter:(RPCharacter*)fromNode
                          toCharacter:(RPCharacter*)toTarget
{
    self = [super initWithFromCharacter:fromNode toCharacter:toTarget];
    if (self)
    {
        self.name = SKILL_NAME;
        self.size = CGSizeMake(3, 3);
        self.color = RGB(200, 30, 100);
        self.moveSpeed = 300;
        self.skillDamge = 200;
        self.rocketEmitter = [RPComFunction getParticleWithName:@"Rocket"];
        [self addChild:self.rocketEmitter];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
    self.rocketEmitter.targetNode = self.scene;    
}

@end
