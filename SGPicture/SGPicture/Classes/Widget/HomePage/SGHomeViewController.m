//
//  HomeViewController.m
//  SGPicture
//
//  Created by sogou-Yan on 2018/2/7.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "SGHomeViewController.h"

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

#pragma mark - INIT
- (void)private_initUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - SET

#pragma mark - LAZY

@end
