//
//  RPStartScene.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-21.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPStartScene.h"

@implementation RPStartScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"特别的小游戏,特别小的游戏";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}


@end
