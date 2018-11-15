//
//  LocationMoudule.h
//  MapModule
//
//  Created by zhou jianbang on 2018/11/14.
//  Copyright © 2018 zhou jianbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <BMKLocationKit/BMKLocationAuth.h>
#import <BMKLocationKit/BMKLocationManager.h>

//参数解释
/**
 * locationType 定位模式(持续定位、单次定位)
 * location 当前反geo的位置信息
 * latitude 经度
 * lontitude 纬度
 */
NS_ASSUME_NONNULL_BEGIN

/**
 * 定位组件
 */
@interface LocationMoudule : NSObject<RCTBridgeModule, BMKLocationManagerDelegate>

//定位注册key
+(void)initSDK:(NSString *)key;

@property (nonatomic, strong) BMKLocationManager * locationManager; 

@end

NS_ASSUME_NONNULL_END
