//
//  MoodEntryVC.h
//  ModusProto
//
//  Created by Jack Simmons on 11/27/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface MoodEntryVC : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRDatabaseReference *dbRef; 

    // Mood Buttons
- (IBAction)oneMoodValue:(id)sender;
- (IBAction)twoMoodValue:(id)sender;
- (IBAction)threeMoodValue:(id)sender;
- (IBAction)fourMoodValue:(id)sender;
- (IBAction)fiveMoodValue:(id)sender;

    // Motivation Buttons
- (IBAction)oneMotValue:(id)sender;
- (IBAction)twoMotValue:(id)sender;
- (IBAction)threeMotValue:(id)sender;
- (IBAction)fourMotValue:(id)sender;
- (IBAction)fiveMotValue:(id)sender;


- (IBAction)quickEntry:(id)sender;
- (IBAction)addDetail:(id)sender;
    
@end

NS_ASSUME_NONNULL_END
