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

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size
{
    self = [super initWithColor:color size:size];
    if (self)
    {
        self.name = FRIEND_NAME;
        self.lastTime = 0;
        self.atkInterval = 1.2;
        self.atkRange = 200;
    }
    return self;
}

@end
