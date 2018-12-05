//
//  MoodEntryVC.m
//  ModusProto
//
//  Created by Jack Simmons on 11/27/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import "MoodEntryVC.h"
#import "MoodObject.h"


@interface MoodEntryVC () {
    NSString *moodValue;
    NSString *motValue;
}

@end

@implementation MoodEntryVC

- (void)viewDidLoad {
        [super viewDidLoad];
        self.dbRef = [[[FIRDatabase database] reference] child:@"jasi2018"];
    }


    - (IBAction)oneMoodValue:(id)sender {
        printf("One\n");
        moodValue = @"1";
    }
    
    - (IBAction)twoMoodValue:(id)sender {
        printf("Two\n");
        moodValue = @"2";
    }
    
    - (IBAction)threeMoodValue:(id)sender {
        printf("Three\n");
        moodValue = @"3";
    }
    
    - (IBAction)fourMoodValue:(id)sender {
        printf("Four\n");
        moodValue = @"4";
    }
    
    - (void)fiveMoodValue:(id)sender {
        moodValue = @"5";
        printf("Five\n");      
    }

    - (IBAction)oneMotValue:(id)sender {
        printf("One\n");
        motValue = @"1";
    }

    - (IBAction)twoMotValue:(id)sender {
        printf("Two\n");
        motValue = @"2";
    }

    - (IBAction)threeMotValue:(id)sender {
        printf("Three\n");
        motValue = @"3";
    }

    - (IBAction)fourMotValue:(id)sender {
        printf("Four\n");
        motValue = @"4";
    }

    - (void)fiveMotValue:(id)sender {
        motValue = @"5";
        printf("Five\n");
    }



    - (void)quickEntry:(id)sender {
        NSDate *date= [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSLog(@"Current date is %@",dateString);
        NSDate *newDate = [dateFormatter dateFromString:dateString];
        NSLog(@"NewDate: %@",newDate);
        // self.dbRef = Database.database().reference().child(self.userID!)
        
        
        self.dbRef = [[FIRDatabase database] reference];
//        MoodObject *newMoodEntry = [MoodObject alloc] initWithKey: date:dateString moodValue:moodValue addedByUser:@"Nil";
        MoodObject *newMoodEntry = [[MoodObject alloc] init];
        [newMoodEntry setDate:dateString];
        [newMoodEntry setMotValue:motValue];
        [newMoodEntry setMoodValue:moodValue];
        [newMoodEntry setAddedByUser:@"nil"];
        FIRDatabaseReference *sweetRef = [[[self.dbRef child:@"jasi2018"] child:@"MoodEntries"] child:dateString];
        [sweetRef setValue:newMoodEntry.toAnyObject];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end