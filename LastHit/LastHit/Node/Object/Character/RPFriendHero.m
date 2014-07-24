//
//  RPFriendHero.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-25.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPFriendHero.h"
#import "RPHpBarNode.h"

@implementation RPFriendHero

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNode:) name:UPDATE_MSG object:nil];
        self.texture = [SKTexture textureWithImageNamed:@"f.png"];
        self.name = FRIEND_NAME;
        self.state = States_Move;
        self.lastTime = 0;
        
        self.atkInterval = 0.1;
        self.viewRange = 300;
        self.atkRange = 50;
        self.moveSpeed = 30;
        self.maxHp = 2000;
        self.curHp = self.maxHp;
        self.maxAtk = 32;
        self.minAtk = 25;
        self.armor = 2;
        
        [self showViewRangeLine];
        [self showAtkRangeLine];
        
        //血条
        self.hpBarNode = [[RPHpBarNode alloc] initWithCamp:Camp_Friend];
        self.hpBarNode.position = CGPointMake(-self.size.width*0.5,
                                              self.size.height*0.5+5);
        [self addChild:self.hpBarNode];
        
    }
    return self;
}


@end
