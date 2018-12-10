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
    FIRDatabaseReference *posts;
    FIRDatabaseReference *postsSub;
    
}
    
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (strong, nonatomic) NSMutableArray *allSnapshots;
@property (strong, nonatomic) NSMutableArray *snapshotsArray;
@property (strong, nonatomic) NSMutableArray *dateKeys;

@end

@implementation ViewController 




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
    
    self.dbRef = [[FIRDatabase database] reference];
    storyboardName = @"Main";
    _dbRef = [[[FIRDatabase database] reference] child:@"sweet-items"];
    
    
    [self startDatabaseObservation];
    [self runArray];
}

- (void)startDatabaseObservation {
   self.dbRef = [[FIRDatabase database] reference];
    postsSub = [[_dbRef child:@"jasi2018"] child:@"MoodEntries"];
    
    [postsSub observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.snapshotsArray = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            MoodObject *newMoodEntry = [[MoodObject alloc] init:snapshot];
            [self.snapshotsArray addObject:newMoodEntry];
            NSLog(@"%@", newMoodEntry); 
        }
    }];
}
    
- (void)startObservingBD {
    
    // DATES ARE KEYS: Pull keys and use those to reference values.
    // Pull mood and motivation values out and put them in their own array.
    
    posts = [[_dbRef child:@"jasi2018"] child:@"MoodEntries"];
   
    [posts observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allSnapshots = [NSMutableArray array];
        self.dateKeys = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            MoodObject *newMoodEntry = [[MoodObject alloc] init:snapshot];
            
            NSString *date = snapshot.key;
            NSLog(@"%@", date);
            
            if (date != nil) {
                [self.dateKeys addObject:date];
            }
          
            [self.allSnapshots addObject:newMoodEntry];
            NSLog(@"\n\n\n\n HERE: %@ \n\n\n\n", newMoodEntry);
            NSLog(@"\n\n\n\n HERE: %@ \n\n\n\n", _allSnapshots);
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];

}

- (void)runArray {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *dates = [defaults objectForKey:@"dateKeys"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    EntryCell *eCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    FIRDataSnapshot *snapshot = [self.allSnapshots objectAtIndex:indexPath.row];

    MoodObject *moodObj = _allSnapshots[indexPath.row];
    
    /* from swift:
     let entry = userEntries[indexPath.row]
     cell.calories?.text = entry.calories
     */
    
    eCell.dateLabel.text = moodObj.key;
    eCell.motLevel.text = moodObj.motValue;
    
    NSLog(@"\n\n\n\nHERE: ------> %@\n\n\n\n\n", moodObj.key);
   // eCell.motLevel.text = motiLevel;
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
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
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
