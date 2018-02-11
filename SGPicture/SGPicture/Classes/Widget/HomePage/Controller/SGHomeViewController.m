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

@interface SGHomeViewController ()

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

- (void)private_refreshControlAction:(id)sender {
    NSLog(@"self:%@",self);
}

#pragma mark - INIT
- (void)private_initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIRefreshControl *homeRefreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    [homeRefreshControl addTarget:self action:@selector(private_refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = homeRefreshControl;
    SGHomeTableView *homeTableView = [[SGHomeTableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView = homeTableView;
}

#pragma mark - SET

#pragma mark - LAZY

@end
