//
//  RPFriendCharacter.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPFriendCharacter.h"

@implementation RPFriendCharacter

+ (NSString*)getNodeName
{
    return FRIEND_NAME;
}

- (instancetype)init
{
    self = [super initWithImageNamed:@"f.png"];
    if (self)
    {
        self.size = CGSizeMake(50, 50);
        self.name = FRIEND_NAME;
        self.state = States_Move;
        self.lastTime = 0;
        self.atkInterval = 1.2;
        self.viewRange = 150;
        self.atkRange = 50;
        self.moveSpeed = 50;

#ifdef DEBUG
        [self showViewRangeLine];
        [self showAtkRangeLine];
#endif
    }
    return self;
}


@end
