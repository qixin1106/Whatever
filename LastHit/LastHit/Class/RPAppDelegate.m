//
//  RPAppDelegate.m
//  LastHit
//
//  Created by 亓鑫 on 14-7-21.
//  Copyright (c) 2014年 Research&PS. All rights reserved.
//

#import "RPAppDelegate.h"
#import "RPRootVC.h"
@implementation RPAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.rootVC = [RPRootVC new];
    self.window.rootViewController = self.rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
