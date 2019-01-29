//
//  VariableObject.h
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Firebase; 

NS_ASSUME_NONNULL_BEGIN

@interface VariableObject : NSObject


@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *varType;
@property (copy, nonatomic) FIRDatabaseReference *itemReference;


// designated initializer
- (instancetype)initWithKey:(NSString *)key
                  varType:(NSString *)varType;


- (instancetype)init:(FIRDataSnapshot *)snapshot;

- (id)toAnyObject;


@end

NS_ASSUME_NONNULL_END
