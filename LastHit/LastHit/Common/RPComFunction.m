//
//  RPComFunction.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPComFunction.h"

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

@end
