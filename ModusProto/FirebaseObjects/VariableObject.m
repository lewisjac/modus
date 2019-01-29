//
//  VariableObject.m
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import "VariableObject.h"

@implementation VariableObject

- (instancetype)initWithKey:(NSString *)key
                  varType:(NSString *)varType {
    if(self) {
        _key = key;
        _varType = varType;
        _itemReference = nil;
    }
    
    return self;
}


- (instancetype)init:(FIRDataSnapshot *)snapshot {
    _key = snapshot.key;
    _varType = snapshot.value;
    NSDictionary *dict = snapshot.value;
//    _varType = dict[@"moodValue"];
    
    return self;
}

// THESE ARE THE ACTUAL VALUES STORED IN THE DATABASE
- (id)toAnyObject {
    // Create a dictionary for Firebase
    NSDictionary *dict = @{@"varName":_key, @"variableType":_varType};
    NSLog(@"%@", dict); 
    return dict;
}

@end
