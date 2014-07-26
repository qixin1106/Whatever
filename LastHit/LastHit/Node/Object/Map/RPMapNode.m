//
//  RPMapNode.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPMapNode.h"

@implementation RPMapNode
- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        self.color = RGB(12, 12, 50);
        self.texture = [SKTexture textureWithImageNamed:@"bg.png"];
        self.anchorPoint = CGPointMake(0, 0);
        self.size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        self.zPosition = MAP_LAYER;
    }
    return self;
}
@end
