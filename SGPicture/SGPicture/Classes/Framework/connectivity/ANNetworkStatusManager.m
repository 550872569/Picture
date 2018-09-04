//
//  ANNetworkStatusManager.m
//  AudioNote
//
//  Created by sogou-Yan on 17/5/3.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "ANNetworkStatusManager.h"
#import "AFNetworkReachabilityManager.h"
#import <UIKit/UIKit.h>
#import "DeviceConst.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#define AN_NETWORK_CHANGED @"AN_NETWORK_CHANGED"

enum{
    AN_NETWORK_STATUS_NO_NETWORK = 0,
    AN_NETWORK_STATUS_2G = 1,
    AN_NETWORK_STATUS_3G = 2,
    AN_NETWORK_STATUS_4G = 3,
    AN_NETWORK_STATUS_LTE = 4,
    AN_NETWORK_STATUS_WIFI = 5,
};

@interface ANNetworkStatus(){
    int _status;
}

-(instancetype)initWithNetStatus:(int)status;

@end

@implementation ANNetworkStatus

-(instancetype)initWithNetStatus:(int)status{
    if(self = [super init]){
        _status = status;
    }
    return self;
}

-(bool)networkAvailable {
    return _status != AN_NETWORK_STATUS_NO_NETWORK;
}

-(bool)wifiAvailale {
    return _status == AN_NETWORK_STATUS_WIFI;
}

-(bool)wwanAvailable {
    return _status == AN_NETWORK_STATUS_3G || _status == AN_NETWORK_STATUS_4G || _status == AN_NETWORK_STATUS_LTE;
}

@end

@implementation ANNetworkStatusManager

-(instancetype)init{
    if(self = [super init]){
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        typeof(self) __weak ws = self;
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus rs) {
            int netStatus = AN_NETWORK_STATUS_NO_NETWORK;
            if(rs == AFNetworkReachabilityStatusReachableViaWWAN){
                netStatus = AN_NETWORK_STATUS_3G;
            }else if(rs == AFNetworkReachabilityStatusReachableViaWiFi){
                netStatus = AN_NETWORK_STATUS_WIFI;
            }
            [ws _fireNetworkChangeEvent:netStatus];
        }];
        
        [manager startMonitoring];
    }
    return self;
}

+ (instancetype)manager {
    static ANNetworkStatusManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


+(int)networkingStatusFromStatebar {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    return type;
}

+(int)networkingStatusFromReachability {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    int netWorkState = AN_NETWORK_STATUS_NO_NETWORK;
    switch (internetStatus) {
        case ReachableViaWiFi:
            netWorkState = AN_NETWORK_STATUS_WIFI;
            break;
        case ReachableViaWWAN:
            netWorkState = AN_NETWORK_STATUS_3G;
            break;
        case NotReachable:
            netWorkState = AN_NETWORK_STATUS_NO_NETWORK;
        default:
            break;
    }
    return netWorkState;
}

-(ANNetworkStatus *)currentNetworkStatus{
    if ([UIScreen mainScreen].bounds.size.height>SCREEN_HEIGHT_IPHONE_6P) {
        return [[ANNetworkStatus alloc] initWithNetStatus:[self.class networkingStatusFromReachability]];
    } else {
        return [[ANNetworkStatus alloc] initWithNetStatus:[self.class networkingStatusFromStatebar]];
    }
}

-(void)registerNetworkChangeListener:(id)obj sel:(SEL)sel{
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:sel name:AN_NETWORK_CHANGED object:nil];
}

-(void)unRegisterNetworkChangeListener:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj name:AN_NETWORK_CHANGED object:nil];
}

-(void)_fireNetworkChangeEvent:(int)status{
    [[NSNotificationCenter defaultCenter] postNotificationName:AN_NETWORK_CHANGED object:
     [[ANNetworkStatus alloc] initWithNetStatus:status]];
}

@end
