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
                       date:(NSString *)date
                  moodValue:(NSString *)moodValue
                   motValue:(NSString *)motValue
                addedByUser:(NSString *)user {
    if(self) {
        _key = key;
        _date = date;
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
    NSDictionary *dict = @{@"moodValue":_moodValue, @"motValue":_motValue, @"user":_addedByUser};
    return dict;
}





/*
 
 
 let pulledCalorieLimit = UserDefaults.standard.string(forKey: userDefaultsCalorieLimitKey) ?? "0"
 let sweet = UserEntry(calories: userEntry, description: food, dateTime: calEntryDate, calorieLimit: pulledCalorieLimit, newDay: "") // this creates a sweet object we can pass along to firebase
 let sweetRef = self.dbRef.child(calEntryDate) // creates a reference for the sweet
 sweetRef.setValue(sweet.toAnyObject())
 
 
 */










//- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snap {
//    _key = snap.key;
//    _itemReference = snap.ref;
//    
//    FIRDataSnapshot *sweetCont = [[FIRDataSnapshot alloc] init];
//  
//    
//}

@end
