//
//  ViewController.m
//  LocationManagerDemo
//
//  Created by alex on 13-8-9.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [LocationManager startUpdatingLocation:^(LocationManager *locationManager) {
        
    } updateBlock:^(CLLocation *newLocation, CLLocation *oldLocation, NSError *error) {
        
    } reverseGeocodEndBlcok:^(CLPlacemark *placemark, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"经纬度:%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude]
                                                          message:[NSString stringWithFormat:@"地理信息:%@",placemark.description]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil];
        [alertView show];
        
//        NSLog(@"name:%@",placemark.name);
//        NSLog(@"thoroughfare:%@",placemark.thoroughfare);
//        NSLog(@"subThoroughfare:%@",placemark.subThoroughfare);
//        NSLog(@"locality:%@",placemark.locality);
//        NSLog(@"subLocality:%@",placemark.subLocality);
//        NSLog(@"adminstrativeArea:%@",placemark.administrativeArea);
//        NSLog(@"subAdministrativeArea:%@",placemark.subAdministrativeArea);
//        NSLog(@"postalCode:%@",placemark.postalCode);
//        NSLog(@"ISOcountryCode:%@",placemark.ISOcountryCode);
//        NSLog(@"countr:%@",placemark.country);
//        NSLog(@"inlandWater:%@",placemark.inlandWater);
//        NSLog(@"ocean:%@",placemark.ocean);
//        NSLog(@"areasOfInterest:%@",placemark.areasOfInterest);
//        
//        NSLog(@"%@",placemark.description);
//        /* CLPlacemark ---> NSString(siteCity) */
//        if (![placemark.ISOcountryCode isEqualToString:@"CN"]) {
//            if (placemark.country!=nil) {
//                siteCity=[NSString stringWithFormat:@"%@",placemark.country];//国家
//            }
//            else{
//                siteCity=@"无地理信息";
//            }
//        }
//        else{
//            if (placemark.administrativeArea!=nil) {
//                siteCity=[NSString stringWithFormat:@"%@/%@",placemark.administrativeArea,placemark.locality];// 省/城市
//            }
//            else
//                if (placemark.locality!=nil) {
//                    siteCity=[NSString stringWithFormat:@"%@",placemark.locality];// 城市
//                }
//                else{
//                    siteCity=@"无地理信息";
//                }
//        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
