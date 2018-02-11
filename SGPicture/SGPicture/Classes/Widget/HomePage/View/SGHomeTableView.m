//
//  SGHomeTableView.m
//  SGPicture
//
//  Created by sogou-Yan on 2018/2/11.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "SGHomeTableView.h"
#import "SGHomeRefreshControl.h"

@implementation SGHomeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initRefreshControl];
    }
    return self;
}

- (void)initRefreshControl {
    SGHomeRefreshControl *homeRefreshControl = [[SGHomeRefreshControl alloc] initWithFrame:CGRectZero];
    [homeRefreshControl addTarget:self action:@selector(private_refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.refreshControl = homeRefreshControl;
    } else {
        // Fallback on earlier versions
    }
}

- (void)private_refreshControlAction:(id)sender {
    NSLog(@"self:%@",self);
    if (@available(iOS 10.0, *)) {
        [self.refreshControl endRefreshing];
    }
}

@end
