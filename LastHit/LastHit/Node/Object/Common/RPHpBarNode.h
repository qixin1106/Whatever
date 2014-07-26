//
//  RPHpBarNode.h
//  LastHit
//
//  Created by 亓鑫 on 14-7-24.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface RPHpBarNode : SKSpriteNode
- (instancetype)initWithCamp:(Camp)camp width:(CGFloat)width;
- (void)changeWidthWithHpRate:(CGFloat)hpRate;
@end
