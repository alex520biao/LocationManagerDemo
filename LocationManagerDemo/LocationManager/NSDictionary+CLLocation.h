//
//  NSDictionary+CLLocation.h
//  TravelNote
//
//  Created by liu AISIDE on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface NSDictionary (CLLocation)

//图片的GPSDictionary转化为CLLocation对象
-(CLLocation*)locationFromGPSDictionary;


@end
