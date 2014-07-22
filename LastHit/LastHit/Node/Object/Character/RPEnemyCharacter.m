//
//  RPEnemyCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPEnemyCharacter.h"

@implementation RPEnemyCharacter

+ (NSString*)getNodeName
{
    return ENEMY_NAME;
}


- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size
{
    self = [super initWithColor:color size:size];
    if (self)
    {
        self.name = ENEMY_NAME;
        self.lastTime = 0;
        self.atkInterval = 1.2;
        self.atkRange = 50;
    }
    return self;
}

@end
