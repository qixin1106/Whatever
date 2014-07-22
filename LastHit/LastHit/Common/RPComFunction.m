//
//  RPComFunction.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPComFunction.h"

@implementation RPComFunction

+ (float)getDistanceWithYourPosition:(CGPoint)your
                      targetPosition:(CGPoint)target
{
    float absWidth = abs(your.x)-abs(target.x);
    float absHeight = abs(your.y)-abs(target.y);
    return sqrtf(absWidth*absWidth+absHeight*absHeight);
}


@end
