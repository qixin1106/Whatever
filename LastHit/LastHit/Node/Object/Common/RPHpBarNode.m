//
//  RPHpBarNode.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-24.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPHpBarNode.h"

#define HPBAR_WIDTH 50
#define HPBAR_HEIGHT 2


@interface RPHpBarNode ()
@property (strong, nonatomic) SKSpriteNode *curHpBar;
@end

@implementation RPHpBarNode

- (instancetype)initWithCamp:(Camp)camp
{
    self = [super init];
    if (self)
    {
        self.zPosition = HP_BAR_LAYER;
        self.size = CGSizeMake(HPBAR_WIDTH, HPBAR_HEIGHT);
        self.anchorPoint = CGPointMake(0, 1);
        self.color = RGB(255, 255, 255);
        
        
        self.curHpBar = [SKSpriteNode node];
        self.curHpBar.anchorPoint = CGPointMake(0, 1);
        self.curHpBar.size = CGSizeMake(HPBAR_WIDTH, HPBAR_HEIGHT);
        if (camp==Camp_Friend)
        {
            self.curHpBar.color = RGB(12, 233, 12);
        }
        else if (camp==Camp_Eneny)
        {
            self.curHpBar.color = RGB(233, 12, 12);
        }
        else
        {
            self.curHpBar.color = RGB(255, 12, 128);
        }
        [self addChild:self.curHpBar];
    }
    return self;
}

- (void)changeWidthWithHpRate:(CGFloat)hpRate;
{
    self.curHpBar.size = CGSizeMake(hpRate*HPBAR_WIDTH, 2);
}

@end
