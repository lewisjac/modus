//
//  Weather.h
//  ModusProto
//
//  Created by Jack Simmons on 12/21/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

- (instancetype)init;
- (NSString *)strProviding;
- (NSString *)getLocation;

@end

NS_ASSUME_NONNULL_END
