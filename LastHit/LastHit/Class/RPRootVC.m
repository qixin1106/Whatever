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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    skView.showsPhysics = YES;

    // Create and configure the scene.
    RPGameScene * scene = [RPGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}


@end
