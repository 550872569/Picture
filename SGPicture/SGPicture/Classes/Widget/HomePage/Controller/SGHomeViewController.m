//
//  HomeViewController.m
//  SGPicture
//
//  Created by sogou-Yan on 2018/2/7.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGHomeRefreshControl.h"
#import "SGHomeTableView.h"

@interface SGHomeViewController () {
    SGHomeTableView *_homeTableView;
}

@end

@implementation SGHomeViewController

#pragma mark - view cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self private_initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - ACTION
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"self:%@",self);
}



#pragma mark - INIT
- (void)private_initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _homeTableView = [[SGHomeTableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_homeTableView];
}

#pragma mark - SET

#pragma mark - LAZY

@end
