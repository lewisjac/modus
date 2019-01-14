//
//  NewTrackerVC.h
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTrackerVC : UIViewController
@property (strong, nonatomic) IBOutlet UIPickerView *dataTypePicker;
@property (strong, nonatomic) IBOutlet UITextField *trackerName; 

@end

NS_ASSUME_NONNULL_END
