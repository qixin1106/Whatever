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



- (instancetype)init
{
    self = [super initWithImageNamed:@"e.png"];
    if (self)
    {
        self.size = CGSizeMake(50, 50);
        self.name = ENEMY_NAME;
        self.state = States_Move;
        self.lastTime = 0;
        self.atkInterval = 1.2;
        self.viewRange = 200;
        self.atkRange = 50;
        self.moveSpeed = 30;
        
#ifdef DEBUG
        [self showViewRangeLine];
        [self showAtkRangeLine];
#endif

    }
    return self;
}

@end
