//
//  NewTrackerVC.m
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

/*
 The User enter's their new tracker name - whatever they want to trac eg did user drink or not
 - enter the type: bool, number, scale (1 to 3, 1 to 7, 1 to 10);
 
 Bool values:
    - switch yes/no
    - other values are not recorded if
 
 
 */


#import "NewTrackerVC.h"

@import Firebase;

@interface NewTrackerVC ()

@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (nonatomic, assign) NSInteger selectedRowNum;
@property (strong, nonatomic) NSString *valueFromPicker;

@end

@implementation NewTrackerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // change color of status bar
    UIView *statusBarView = [[UIView alloc] initWithFrame:UIApplication.sharedApplication.statusBarFrame];
    UIColor *appColor = [UIColor colorWithRed:(46/255.0) green:(69/255.0) blue:(100/255.0) alpha:1];
    statusBarView.backgroundColor = appColor;
    [self.view addSubview:statusBarView];
    
    // set up navbar
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 20, self.view.frame.size.width, 100)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"new tracker"];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancel:)];
    navItem.leftBarButtonItem = cancelBtn;
    navBar.barTintColor = appColor;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    navBar.titleTextAttributes = attributes;
    [navBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"helvetica" size:21]}];
    
    [navBar setItems:@[navItem]];
    [self.view addSubview:navBar];
    navBar.translucent = NO;
    
    [self.dataTypePicker selectRow:0 inComponent:0 animated:YES];
    
    
    
}

- (void)onTapCancel:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:^{
        //nah
    }];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"pressed the canx button");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  
    NSString *title = nil;
    switch(row) {
        case 0:
            title = @"yes/no";
            break;
        case 1:
            title = @"number";
            break;
        case 2:
            title = @"1 to 3";
            break;
        case 3:
            title = @"1 to 5";
            break;
        case 4:
            title = @"1 to 7";
            break;
        default:
            break;
    }
    
    return title;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _selectedRowNum = row;
}



- (IBAction)createTracker:(id)sender {

    // pull value based of number selection
    NSString *title = nil;
    switch(_selectedRowNum) {
        case 0:
            _valueFromPicker = @"yes/no";
            break;
        case 1:
            _valueFromPicker = @"number";
            break;
        case 2:
            _valueFromPicker = @"1 to 3";
            break;
        case 3:
            _valueFromPicker = @"1 to 5";
            break;
        case 4:
            _valueFromPicker = @"1 to 7";
            break;
        default:
            break;
    }
    
    
    
    
    
    
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

    // Needs to be broken down to "name": trackerName varType: valueFromPicker
    [[[[self.dbRef child:@"jasi2018"] child:@"Trackers"] child:_trackerName.text] setValue: _valueFromPicker];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



@end
