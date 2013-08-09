//
//  LocationManager.m
//  TravelNote
//
//  Created by liu AISIDE on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()
@property(retain,nonatomic)CLLocationManager *locManager;
@property (retain,nonatomic)CLGeocoder *geocoder;
@property(retain,nonatomic)CLLocation *location;
@property(nonatomic,copy)DidStartToLocationBlcok didStartToLocationBlcok;//开始定位的回调块
@property(nonatomic,copy)DidUpdateToLocationBlcok didUpdateToLocationBlcok;//定位结束时的回调块
@property(nonatomic,copy)ReverseGeocodEndBlcok reverseGeocodEndBlcok;//反编译结束时回调块

-(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)didUpdateToLocationBlock reverseGeocodEndBlcok:(ReverseGeocodEndBlcok)reverseGeocodEndBlcok;
@end

@implementation LocationManager
@synthesize locManager=_locManager;
@synthesize geocoder=_geocoder;
@synthesize location=_location;
@synthesize didUpdateToLocationBlcok=_didUpdateToLocationBlcok;
@synthesize didStartToLocationBlcok=_didStartToLocationBlcok;
@synthesize reverseGeocodEndBlcok=_reverseGeocodEndBlcok;

static LocationManager *sharedLocationManager;
+(LocationManager*)sharedLocationManager;
{
	@synchronized(sharedLocationManager)
	{
		if (sharedLocationManager==nil) {            
            sharedLocationManager=[[LocationManager alloc] init];
		}
	}
	return sharedLocationManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        manager.delegate = self;//代理        
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.distanceFilter = 100;    
        self.locManager=manager;
        [manager release];
        
        CLGeocoder *geocoder=[[CLGeocoder alloc] init];
        self.geocoder=geocoder;
        [geocoder release];
    }
    
    return self;
}

- (void)dealloc {    
    if (_didStartToLocationBlcok) {
        Block_release(_didStartToLocationBlcok);
    }
    
    if (_didUpdateToLocationBlcok) {
        Block_release(_didUpdateToLocationBlcok);
    }
    
    if (_reverseGeocodEndBlcok) {
        Block_release(_reverseGeocodEndBlcok);
    }
    
    [_location release];
    _location=nil;
    
    [_locManager release];
    _locManager = nil;
    [super dealloc];
}


#pragma mark private
-(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)didUpdateToLocationBlock reverseGeocodEndBlcok:(ReverseGeocodEndBlcok)reverseGeocodEndBlcok{
    self.didStartToLocationBlcok=startBlock;
    self.didUpdateToLocationBlcok=didUpdateToLocationBlock;
    self.reverseGeocodEndBlcok=reverseGeocodEndBlcok;
    
    [self.locManager startUpdatingLocation];
    /*回调方法:开始编辑时的回调方法*/
    if (self.didStartToLocationBlcok!=nil) {
        self.didStartToLocationBlcok(self);
    }
}

#pragma mark custom
+(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)didUpdateToLocationBlock reverseGeocodEndBlcok:(ReverseGeocodEndBlcok)reverseGeocodEndBlcok{
    LocationManager *manager=[LocationManager sharedLocationManager];    
    [manager startUpdatingLocation:startBlock updateBlock:didUpdateToLocationBlock reverseGeocodEndBlcok:reverseGeocodEndBlcok];
}

+(void)startUpdatingLocation:(DidStartToLocationBlcok)startBlock updateBlock:(DidUpdateToLocationBlcok)updateBlock{
   LocationManager *manager=[LocationManager sharedLocationManager];
    [manager startUpdatingLocation:startBlock updateBlock:updateBlock reverseGeocodEndBlcok:nil];
}

+(void)startReverseGeocodeLocation:(CLLocation*)location endBlcok:(ReverseGeocodEndBlcok)endBlcok{
    LocationManager *manager=[LocationManager sharedLocationManager];
    [manager.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (error) {
            /*回调方法:反编译结束都回调方法*/
            endBlcok(placemark,error);
        }else{
            /*回调方法:反编译结束都回调方法*/
            endBlcok(placemark,error);
        }
    }];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [manager stopUpdatingLocation];
    self.location=newLocation;
    
    /*回调方法:定位结束时的回调块*/
    if (self.didUpdateToLocationBlcok!=nil) {
        self.didUpdateToLocationBlcok(newLocation,oldLocation,nil);
    }
    
    //反编译获取地点信息
    if (self.reverseGeocodEndBlcok!=nil) {
        [LocationManager startReverseGeocodeLocation:newLocation endBlcok:^(CLPlacemark *placemark,NSError *error) {
            if (self.reverseGeocodEndBlcok!=nil) {
                self.reverseGeocodEndBlcok(placemark,error);
            }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.location=nil;
    /*回调方法:定位结束时的回调块*/
    if (self.didUpdateToLocationBlcok!=nil) {
        self.didUpdateToLocationBlcok(nil,nil,error);
    }
}

@end
