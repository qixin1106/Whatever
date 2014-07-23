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

//        RPFriendCharacter *friend2 = [[RPFriendCharacter alloc] init];
//        friend2.position = CGPointMake(200, 100);
//        [self addChild:friend2];


//        RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] init];
//        enemy.position = CGPointMake(150, 350);
//        [self addChild:enemy];
//
//        RPEnemyCharacter *enemy2 = [[RPEnemyCharacter alloc] init];
//        enemy2.position = CGPointMake(200, 200);
//        [self addChild:enemy2];
//
//        RPEnemyCharacter *enemy3 = [[RPEnemyCharacter alloc] init];
//        enemy3.position = CGPointMake(50, 250);
//        [self addChild:enemy3];
//
//        RPEnemyCharacter *enemy4 = [[RPEnemyCharacter alloc] init];
//        enemy4.position = CGPointMake(250, 300);
//        [self addChild:enemy4];

    }
    return self;
}


#pragma mark - Touch Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TEST
    //you can touch the enemy node move to change position,just test.
    CGPoint point = [[touches anyObject] locationInNode:self];
    RPEnemyCharacter *enemy = [[RPEnemyCharacter alloc] init];
    enemy.position = point;
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
