//
//  BaseModule.m
//  MapModule
//
//  Created by zhou jianbang on 2018/11/14.
//  Copyright © 2018 zhou jianbang. All rights reserved.
//

#import "EmiterModule.h"
#import <React/RCTEventDispatcher.h>
#import <React/RCTConvert.h>

NSString * DidReceiveNotificationkey = @"DidReceiveNotificationkey";
NSString * Location = @"Location";
NSString * Geo = @"Geo";


@implementation EmiterModule
{
    bool hasListeners;
}
RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
    return @[Location, Geo];
}
//添加通知
- (void)startObserving
{
    hasListeners = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emitEventInternal:)
                                                 name:DidReceiveNotificationkey
                                               object:nil];
}
+(void)sendEventWithParam:(NSDictionary *)param andIsSuccess:(BOOL)isSuccess andType:(EventEmmiter_Type)emmiterType
{
    NSMutableDictionary * mulDict = [NSMutableDictionary dictionary];
    if (param) {
        [mulDict setObject:param forKey:@"param"];
    }else{
        [mulDict setObject:@{} forKey:@"param"];
    }
    [mulDict setObject:isSuccess?@1:@0 forKey:@"ret"];
    [mulDict setObject:@(emmiterType) forKey:@"type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:DidReceiveNotificationkey object:mulDict];
}

//移除通知
- (void)stopObserving
{
    hasListeners = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emitEventInternal:(NSNotification *)notification
{
    NSDictionary * object = [notification object];
    NSNumber * type = [object objectForKey:@"type"];
    switch (type.integerValue) {
        case EventEmmiter_Type_Location:
        {
            if (hasListeners) {
                [self sendEventWithName:Location
                                   body:notification.object];
            }
        }
            break;
        case EventEmmiter_Type_Geo:
        {
            if (hasListeners) {
                [self sendEventWithName:Geo
                                   body:notification.object];
            }
        }
            break;
        default:
            break;
    }
}
@end
