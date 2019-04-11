//
//  SDLocationManager.h
//  SuperDeer
//
//  Created by liulei on 2018/10/26.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDLocationManager : NSObject

+ (SDLocationManager *)sharedManager;

/** 1.纬度 */
@property (strong, nonatomic) NSString *currentLatitude;
/** 2.经度 */
@property (strong, nonatomic) NSString *currentLongitude;
/** 3.获取成功后回调 */
@property (nonatomic, copy) void (^locationSuccess)(NSString *latitude, NSString *longitude);

/**
 1.获取当前位置
 */
- (void)getLocation;

/**
 2.获取距离

 @param lat 纬度
 @param lng 经度
 @return 当前位置到这个经纬度的距离 当小于0时，表示无法定位
 */
- (float)getDistanceWithLat:(float)lat lng:(float)lng;

@end

NS_ASSUME_NONNULL_END
