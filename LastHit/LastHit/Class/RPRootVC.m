//
//  RPRootVC.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-21.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPRootVC.h"
#import "RPStartScene.h"
#import "RPGameScene.h"
@interface RPRootVC ()

@end

@implementation RPRootVC

- (void)loadView
{
    [super loadView];
    self.view = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
//    skView.showsPhysics = YES;

    // Create and configure the scene.
    RPGameScene * scene = [RPGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (void)didBecomeActive
{
    SKView * skView = (SKView *)self.view;
    skView.paused = NO;
}

- (void)willResignActive
{
    SKView * skView = (SKView *)self.view;
    skView.paused = YES;
}


@end
