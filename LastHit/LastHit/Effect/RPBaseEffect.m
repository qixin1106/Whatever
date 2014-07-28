//
//  RPBaseEffect.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPBaseEffect.h"
#import "RPCharacter.h"

@interface RPBaseEffect ()
@property (strong, nonatomic) RPCharacter* fromNode;
@property (strong, nonatomic) RPCharacter* toTarget;
@end

@implementation RPBaseEffect

- (instancetype)initWithFromCharacter:(RPCharacter*)fromNode
                          toCharacter:(RPCharacter*)toTarget
{
    self = [super init];
    if (self)
    {
        self.fromNode = fromNode;
        self.toTarget = toTarget;
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.toTarget)
    {
        
    }
}
@end
