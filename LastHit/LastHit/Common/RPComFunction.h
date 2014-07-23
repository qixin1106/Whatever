//
//  RPComFunction.h
//  LastHit
//
//  Created by 亓鑫 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPComFunction : NSObject
+ (CGFloat)getDistanceWithYourPosition:(CGPoint)your
                      targetPosition:(CGPoint)target;
+ (CGFloat)getRadianWithYourPosition:(CGPoint)your
                    targetPosition:(CGPoint)target;
+ (CGFloat)getCurAtkWithMax:(CGFloat)maxAtk Min:(CGFloat)minAtk;
@end
