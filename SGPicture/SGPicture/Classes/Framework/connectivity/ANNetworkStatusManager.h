//
//  ANNetworkStatusManager.h
//  AudioNote
//
//  Created by sogou-Yan on 17/5/3.
//  Copyright © 2017年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANNetworkStatus: NSObject

-(bool)networkAvailable;

-(bool)wifiAvailale;

-(bool)wwanAvailable;

@end


@interface ANNetworkStatusManager : NSObject

+(ANNetworkStatusManager *)manager;

-(void)registerNetworkChangeListener:(id)obj sel:(SEL)sel;
-(void)unRegisterNetworkChangeListener:(id)obj;

-(ANNetworkStatus *)currentNetworkStatus;

@end
