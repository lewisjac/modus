//
//  Weather.m
//  ModusProto
//
//  Created by Jack Simmons on 12/21/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//


#import "Weather.h"

@implementation Weather {
    NSString *latitude;
    NSString *longitude;
}

@synthesize locationManager;


- (id)init {
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    [locationManager startUpdatingLocation];  //requesting location updates
    
    [self strProviding];
    return self;
}

- (NSString *)strProviding {
    return @"this is a returned string";
}
//- (NSString *)getLocation {
//    locationManager.delegate = self;
//    [locationManager requestAlwaysAuthorization];
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
//    [locationManager startUpdatingLocation];
//}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    latitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
   // self is to call a function, -> accesses the field directly
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    NSNumber *latitudeAsNum = [[NSNumber alloc] initWithDouble: locationManager.location.coordinate.latitude];
//    NSNumber *longitudeAsNum = [[NSNumber alloc] initWithDouble: locationManager.location.coordinate.longitude];
//    _latitude = [[NSString alloc] initWithFormat:@"%f", locationManager.location.coordinate.latitude];
//    _longitude = [[NSString alloc] initWithFormat:@"%f", locationManager.location.coordinate.longitude];
//    NSLog(@"latitude: %f", locationManager.location.coordinate.latitude);
//    NSLog(@"longitude: %f", locationManager.location.coordinate.longitude);
//    NSString *coordinates = [NSString stringWithFormat:@"https://api.darksky.net/forecast/b6e979e435abc5dc47b72de1b736bbae/%@,%@", _latitude, _longitude ];
//    NSLog(@"This is the new: %@", coordinates);
//    [self fetchCoursesUsingJSON:(coordinates)];
//    //    [self fetchCoursesUsingJSON];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"Failed");
//}



//- (instancetype)init:(FIRDataSnapshot *)snapshot {
//    _key = snapshot.key;
//    _itemReference = snapshot.ref;
//    NSDictionary *dict = snapshot.value;
//    _moodValue = dict[@"moodValue"];
//    _motValue = dict[@"motValue"];
//    _addedByUser = dict[@"user"];
//
//    return self;
//}


@end
