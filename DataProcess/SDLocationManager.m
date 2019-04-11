//
//  SDLocationManager.m
//  SuperDeer
//
//  Created by liulei on 2018/10/26.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDLocationManager.h"
#import <CoreLocation/CoreLocation.h>

static SDLocationManager *kSDLocationManager = nil;

@interface SDLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *checkinLocation;
@property (strong, nonatomic) CLGeocoder *geocoder;//初始化地理编码器

@end

@implementation SDLocationManager

+ (SDLocationManager *)sharedManager
{
    @synchronized(self)
    {
        if (kSDLocationManager == nil)
        {
            kSDLocationManager = [[SDLocationManager alloc] init];
        }
    }
    return kSDLocationManager;
}

- (void)getLocation {
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            _locationManager.distanceFilter = MAXFLOAT;
            [_locationManager requestWhenInUseAuthorization];
            _locationManager.delegate = self;
        }
        
        if (!_geocoder) {
            _geocoder = [[CLGeocoder alloc] init];
        }
        [_locationManager startUpdatingLocation];
        
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    _checkinLocation = [locations lastObject];
    CLLocationCoordinate2D cool = self.checkinLocation.coordinate;
    _currentLatitude  = [NSString stringWithFormat:@"%.4f",cool.latitude];
    _currentLongitude = [NSString stringWithFormat:@"%.4f",cool.longitude];
    
    NSLog(@"%@,%@",self.currentLatitude,self.currentLongitude);
    
    typeof(self) __weak weakSelf = self;
    [_geocoder reverseGeocodeLocation:_checkinLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            // 获取城市
            NSString *city = placemark.locality;
            if (!city) {
                // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }

            // 获取详细地址
            NSString *address= @"";
            if (placemark.addressDictionary && [placemark.addressDictionary isKindOfClass:[NSDictionary class]]) {
                NSArray *array = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
                if (array && [array isKindOfClass:[NSArray class]]&& array.count > 0) {
                    address = array[0];
                }
            }
            
            typeof(self) __strong strongSelf = weakSelf;
            if (strongSelf.locationSuccess) {
                strongSelf.locationSuccess(strongSelf.currentLatitude, strongSelf.currentLongitude);
            }
            
        }else if (error == nil && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
        
    }];
    
    // 不用的时候关闭更新位置服务
    [manager stopUpdatingLocation];
}

// 定位失败错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

- (float)getDistanceWithLat:(float)lat lng:(float)lng {
    
    if ([CLLocationManager locationServicesEnabled]
        && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        && (lat != 0 || lng != 0)) {
        
        CLLocation *lastLocation = [[CLLocation alloc] initWithLatitude:[self.currentLatitude floatValue] longitude:[self.currentLongitude floatValue]];
        CLLocation *nowLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        float distanceMeters = [lastLocation distanceFromLocation:nowLocation];
        
        return distanceMeters;
    }
    else {
        return -1;
    }
}

@end
