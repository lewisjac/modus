//
//  ViewController.m
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//



#import "ViewController.h"
#import "MoodObject.h"
#import "EntryCell.h"
@import Firebase;
#pragma-mark TableView Datasource


@interface ViewController () {
    NSString *storyboardName;
    FIRDatabaseReference *postsSub;
    
}
    
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (strong, nonatomic) NSMutableArray *snapshotsArray;

@end

@implementation ViewController 


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    [self presentViewController:vc
//                       animated:YES
//                     completion:nil];
    
    self.dbRef = [[FIRDatabase database] reference];
    storyboardName = @"Main";
    _dbRef = [[[FIRDatabase database] reference] child:@"sweet-items"];
    [self.tableView setDataSource: self];
    [self.tableView setDelegate: self];

    [self startDatabaseObservation];
    
}

    

    
- (void)startDatabaseObservation {
    self.dbRef = [[FIRDatabase database] reference];
    postsSub = [[_dbRef child:@"jasi2018"] child:@"MoodEntries"];
    
    [postsSub observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {

        self.snapshotsArray = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            MoodObject *newMoodEntry = [[MoodObject alloc] init:snapshot];
            [self.snapshotsArray addObject:newMoodEntry];
            [self.tableView reloadData];
           
            NSString *theDate = newMoodEntry.key;
            NSLog(@"\n\n\n The Date:%@ \n\n\n", theDate);
        }
    }withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}
    
- (void) tocLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _snapshotsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // DATE CONVERSION CODE
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSMutableArray *dates = [defaults objectForKey:@"dateKeys"];
    //    NSMutableArray *datesFormatted = [NSMutableArray array];
    //
    //    NSString *dateStr = [[NSString alloc] init];
    //    // convert dates to this format: DEC 12 08:01 AM
    //
    //    for (dateStr in dates) {

    //    }
    //         NSString *date = datesFormatted[indexPath.row];
    
    
    NSLog(@"\n\n Array: %@ \n\n", _snapshotsArray);
    EntryCell *eCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    MoodObject *moodObj = _snapshotsArray[indexPath.row];
    
    
    
    NSLog(@"\n\n\n READ THIS %@ %@ \n\n\n", moodObj.motValue, moodObj.moodValue);

    NSString *inputDateFormat = @"2018-12-04 07:47:05";
    NSDate *dateVar = [NSDate date];
    NSDateFormatter *formatterCurrent = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterUpdated = [[NSDateFormatter alloc] init];
    [formatterCurrent setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [formatterUpdated setDateFormat:@"MMM d, h:mm a"];
    NSDate *dateAsDate = [formatterCurrent dateFromString:moodObj.key];
    NSString *formattedDateString = [formatterUpdated stringFromDate:dateAsDate];
    
    
    eCell.dateLabel.text =  formattedDateString;
    eCell.motLevel.text = moodObj.moodValue;
    
    return eCell;
}


- (IBAction)newTrackerBtn:(id)sender {
   // NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NewTrackerVC"];
    [self presentViewController:vc animated:YES completion:nil];
    printf("The button has been clicked\n");
   
}
    
- (IBAction)newMoodBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MoodEntryVC"];
    [self presentViewController:vc animated:YES completion:nil];
        
}
    
    - (void)settingsBtn:(id)sender {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MoodTableVC"];
        [self presentViewController:vc animated:YES completion:nil];
    }

@end


// DATE CONVERSION CODE

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *dates = [defaults objectForKey:@"dateKeys"];
//    NSMutableArray *datesFormatted = [NSMutableArray array];
//
//    NSString *dateStr = [[NSString alloc] init];
//    // convert dates to this format: DEC 12 08:01 AM
//
//    for (dateStr in dates) {
//        NSString *dateStrStr = @"2018-12-04 07:47:05";
//        NSDate *dateVar = [NSDate date];
//        NSDateFormatter *formatterCurrent = [[NSDateFormatter alloc] init];
//        NSDateFormatter *formatterUpdated = [[NSDateFormatter alloc] init];
//        [formatterCurrent setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//        [formatterUpdated setDateFormat:@"MMM d, h:mm a"];
////        formatter.dateFormat = @"MMM d, h:mm a";
////        formatterTwo.dateFormat = @"EEEE, MMM d, yyyy";
//        NSDate *dateAsDate = [formatterCurrent dateFromString:dateStrStr];
//        NSString *formattedDateString = [formatterUpdated stringFromDate:dateAsDate];
//        [datesFormatted addObject:formattedDateString];
//    }
//         NSString *date = datesFormatted[indexPath.row];
