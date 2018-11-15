//
//  BaseModule.h
//  MapModule
//
//  Created by zhou jianbang on 2018/11/14.
//  Copyright © 2018 zhou jianbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

typedef NS_ENUM (NSInteger, EventEmmiter_Type)   {
    EventEmmiter_Type_Location = 0,
    EventEmmiter_Type_Geo,
};

/**
 * 事件触发管理类
 */
extern NSString * DidReceiveNotificationkey;
extern NSString * EventReminder;

@interface EmiterModule : RCTEventEmitter <RCTBridgeModule>

+(void)sendEventWithParam:(NSDictionary *)param andIsSuccess:(BOOL)isSuccess andType:(EventEmmiter_Type)emmiterType;

@end

