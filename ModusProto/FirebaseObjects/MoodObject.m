//
//  TrackedObject.m
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import "MoodObject.h"

@implementation MoodObject

- (instancetype)initWithKey:(NSString *)key
                  moodValue:(NSString *)moodValue
                   motValue:(NSString *)motValue
                addedByUser:(NSString *)user {
    if(self) {
        _key = key;
    //    _date = date;
        _moodValue = moodValue;
        _motValue = motValue;
        _addedByUser = user;
        _itemReference = nil; 
    }
    
    return self;
}


- (instancetype)init:(FIRDataSnapshot *)snapshot {
    _key = snapshot.key;
    _itemReference = snapshot.ref;
    NSDictionary *dict = snapshot.value;
    _moodValue = dict[@"moodValue"];
    _motValue = dict[@"motValue"];
    _addedByUser = dict[@"user"];
   
    return self;
}

// THESE ARE THE ACTUAL VALUES STORED IN THE DATABASE
- (id)toAnyObject {
    // Create a dictionary for Firebase
    NSDictionary *dict = @{@"moodValue":_moodValue, @"motValue":_motValue};
    return dict;
}


@end
