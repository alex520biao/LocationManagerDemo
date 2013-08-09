//
//  CLLocation+GPSDictionary.h
//  TravelNote
//
//  Created by liu AISIDE on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CLLocation (GPSDictionary)

//CLLocation对象转换为图片的GPSDictionary
-(NSDictionary*)GPSDictionary;

@end
