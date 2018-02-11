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
#import "SGHomeTableView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initRootVCAndMakeKeyWindowVisible];
    return YES;
}

- (void)initRootVCAndMakeKeyWindowVisible {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    SGHomeViewController *homeVC = [[SGHomeViewController alloc] init];
    homeVC.tableView = [[SGHomeTableView alloc] init];
    self.window.rootViewController = [[SGNavigationController alloc]initWithRootViewController:homeVC];
}


@end
