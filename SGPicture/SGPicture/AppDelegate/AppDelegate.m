//
//  AppDelegate.m
//  SGPicture
//
//  Created by sogou-Yan on 2018/2/7.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "AppDelegate.h"
#import "SGNavigationController.h"
#import "SGHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initRootVCAndMakeKeyWindowVisible];
    return YES;
}

- (void)initRootVCAndMakeKeyWindowVisible {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[SGNavigationController alloc] initWithRootViewController:[[SGHomeViewController alloc] init]];
}

@end
