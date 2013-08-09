//
//  LocationManager.h
//  TravelNote
//
//  Created by liu AISIDE on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import "CLLocation+GPSDictionary.h"
#import "NSDictionary+CLLocation.h"

@class LocationManager;
typedef void (^DidStartToLocationBlcok)(LocationManager *locationManager);//开始定位回调块
typedef void (^DidUpdateToLocationBlcok)(CLLocation *newLocation,CLLocation *oldLocation,NSError *error);//定位结束时的回调块
typedef void (^ReverseGeocodEndBlcok)(CLPlacemark *placemark,NSError *error);//地理信息反编译完成回调块

@interface LocationManager : NSObject<CLLocationManagerDelegate>

#pragma mark Class Methed
+(CLLocation*)currentLocation;
//开启GPS获取当前GPS经纬度
+(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)updateBlock;

//开启GPS获取当前经纬度和地点信息
+(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)didUpdateToLocationBlock reverseGeocodEndBlcok:(ReverseGeocodEndBlcok)reverseGeocodEndBlcok;

//根据CLLocation(GPS经纬度),反编译获取地点信息
+(void)startReverseGeocodeLocation:(CLLocation*)location endBlcok:(ReverseGeocodEndBlcok)endBlcok;

#pragma mark Other Methed
@property(retain,nonatomic,readonly)CLLocation *location;
-(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)updateBlock;

-(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)didUpdateToLocationBlock reverseGeocodEndBlcok:(ReverseGeocodEndBlcok)reverseGeocodEndBlcok;

-(void)startReverseGeocodeLocation:(CLLocation*)location endBlcok:(ReverseGeocodEndBlcok)endBlcok;

@end
