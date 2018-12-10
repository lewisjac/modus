//
//  TrackedObject.h
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN


@interface MoodObject : NSObject


@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *moodValue;
@property (copy, nonatomic) NSString *motValue; 
@property (copy, nonatomic) NSString *addedByUser;
@property (copy, nonatomic) FIRDatabaseReference *itemReference;

// designated initializer
- (instancetype)initWithKey:(NSString *)key
                   moodValue:(NSString *)moodValue
                   motValue:(NSString *)motValue
               addedByUser:(NSString *)user;


- (instancetype)init:(FIRDataSnapshot *)snapshot;

- (id)toAnyObject;


@end

NS_ASSUME_NONNULL_END
