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
#import "RPFriendHero.h"
#import "RPMapNode.h"
@implementation RPGameScene

#pragma mark - Init
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //map
        RPMapNode *map = [[RPMapNode alloc] init];
        [self addChild:map];
        
        
        //Test
        RPFriendCharacter *friend = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
        [self addChild:friend];
        
        RPFriendCharacter *friend2 = [[RPFriendCharacter alloc] initWithFrame:CGRectMake(220, 150, 50, 50)];
        [self addChild:friend2];

        RPFriendHero *fHero = [[RPFriendHero alloc] initWithFrame:CGRectMake(160, 100, 50, 50)];
        [self addChild:fHero];

    }
    return self;
}


#pragma mark - Touch Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TEST
    //add enemy node,just test.
    CGPoint point = [[touches anyObject] locationInNode:self];
    RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] initWithFrame:CGRectMake(point.x,point.y, 50, 50)];
    [self addChild:enemy];
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime
{
    [self enumerateChildNodesWithName:ENEMY_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];
    [self enumerateChildNodesWithName:FRIEND_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        RPCharacter *character = (RPCharacter*)node;
        [character update:currentTime];
    }];

//    NSDictionary *userInfo = @{@"kTime":[NSNumber numberWithDouble:currentTime]};
//    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_MSG object:nil userInfo:userInfo];
}

@end
