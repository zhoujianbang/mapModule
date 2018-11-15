//
//  LocationMoudule.m
//  MapModule
//
//  Created by zhou jianbang on 2018/11/14.
//  Copyright © 2018 zhou jianbang. All rights reserved.
//

#import "LocationMoudule.h"
#import "EmiterModule.h"

@implementation LocationMoudule

RCT_EXPORT_MODULE();

//开始单次定位
RCT_EXPORT_METHOD(startOnceLocation)
{
    [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        
        if (location.rgcData.locationDescribe) {
            [paramDict setObject:location.rgcData.locationDescribe forKey:@"location"];
        }
        [paramDict setObject:@"onceLocation" forKey:@"locationType"];
        [paramDict setObject:@(location.location.coordinate.latitude) forKey:@"latitude"];
        [paramDict setObject:@(location.location.coordinate.longitude) forKey:@"longitude"];
        [EmiterModule sendEventWithParam:paramDict andIsSuccess:YES andType:EventEmmiter_Type_Location];
    }];
}
//持续定位
RCT_EXPORT_METHOD(startContinueLocation)
{
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

//关闭定位
RCT_EXPORT_METHOD(stopContinueLocation)
{
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - locationDelegate
-(void)BMKLocationManager:(BMKLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    [paramDict setObject:@"continueLocation" forKey:@"locationType"];
    [EmiterModule sendEventWithParam:paramDict andIsSuccess:NO andType:EventEmmiter_Type_Location];
}
-(void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error
{
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    [paramDict setObject:@"continueLocation" forKey:@"locationType"];
    
    if (error) {
        [EmiterModule sendEventWithParam:paramDict andIsSuccess:NO andType:EventEmmiter_Type_Location];
    }else{
        if (location.rgcData.locationDescribe) {
            [paramDict setObject:location.rgcData.locationDescribe forKey:@"location"];
        }
        [paramDict setObject:@"onceLocation" forKey:@"locationType"];
        [paramDict setObject:@(location.location.coordinate.latitude) forKey:@"latitude"];
        [paramDict setObject:@(location.location.coordinate.longitude) forKey:@"longitude"];
        [EmiterModule sendEventWithParam:paramDict andIsSuccess:YES andType:EventEmmiter_Type_Location];
    }
}

-(BMKLocationManager *)locationManager
{
    if (_locationManager) {
        _locationManager = [LocationMoudule createLocationManager:kCLLocationAccuracyBest];
    }
    return _locationManager;
}


+(void)initSDK:(NSString *)key
{
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:key authDelegate:nil];
}
+(BMKLocationManager *)createLocationManager:(CLLocationAccuracy)locationAccuracy{
    BMKLocationManager * locationManager = [[BMKLocationManager alloc] init];
    locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = locationAccuracy;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.pausesLocationUpdatesAutomatically = YES;
    locationManager.locationTimeout = 10;
    locationManager.reGeocodeTimeout = 10;
    return locationManager;
}
@end
