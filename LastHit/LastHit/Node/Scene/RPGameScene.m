//
//  RPGameScene.m
//  LastHit
//
//  Created by Qixin on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPGameScene.h"
#import "RPFriendCharacter.h"
#import "RPEnemyCharacter.h"
#import "RPMapNode.h"
@implementation RPGameScene

#pragma mark - Init
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        RPMapNode *map = [[RPMapNode alloc] init];
        [self addChild:map];
        //Test
        RPFriendCharacter *friend = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        [self addChild:friend];
    }
    return self;
}


#pragma mark - Touch Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TEST
    //you can touch the enemy node move to change position,just test.
    CGPoint point = [[touches anyObject] locationInNode:self];
    RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(point.x,point.y, 50, 50)];
    [self addChild:enemy];
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    NSDictionary *userInfo = @{@"kScene": self,
                               @"kTime":[NSNumber numberWithDouble:currentTime]};
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_MSG object:nil userInfo:userInfo];
}

@end
