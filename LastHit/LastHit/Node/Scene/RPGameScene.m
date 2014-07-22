//
//  RPGameScene.m
//  LastHit
//
//  Created by gm-iMac-iOS-03 on 14-7-22.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPGameScene.h"
#import "RPFriendCharacter.h"
#import "RPEnemyCharacter.h"

@implementation RPGameScene

#pragma mark - Init
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        //Test
        RPFriendCharacter *friend = [[RPFriendCharacter alloc] init];
        friend.position = CGPointMake(100, 100);
        [self addChild:friend];

        RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] init];
        enemy.position = CGPointMake(100, 400);
        [self addChild:enemy];

    }
    return self;
}


#pragma mark - Touch Event
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TEST
    //you can touch the enemy node move to change position,just test.
    RPEnemyCharacter *e = (RPEnemyCharacter*)[self childNodeWithName:[RPEnemyCharacter getNodeName]];
    CGPoint point = [[touches anyObject] locationInNode:self];
    e.position = point;
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    [self enumerateChildNodesWithName:[RPFriendCharacter getNodeName] usingBlock:^(SKNode *node, BOOL *stop) {
        if ([node isKindOfClass:[RPFriendCharacter class]])
        {
            RPFriendCharacter *f = (RPFriendCharacter*)node;
            [f update:currentTime];
            [f findTargetWithName:[RPEnemyCharacter getNodeName] scene:self];
        }
    }];
    [self enumerateChildNodesWithName:[RPEnemyCharacter getNodeName] usingBlock:^(SKNode *node, BOOL *stop) {
        if ([node isKindOfClass:[RPEnemyCharacter class]])
        {
            RPEnemyCharacter *e = (RPEnemyCharacter*)node;
            [e update:currentTime];
        }
    }];

}

@end
