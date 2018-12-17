//
//  TableViewControllerTEST.m
//  ModusProto
//
//  Created by Jack Simmons on 12/10/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import "MoodTableVC.h"
#import "MoodObject.h"
#import "EntryCell.h"

@import Firebase;

@interface MoodTableVC () {
    NSString *storyboardName;
    FIRDatabaseReference *posts;
    FIRDatabaseReference *postsSub;
}

@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (strong, nonatomic) NSMutableArray *snapshotsArray;
@property (strong, nonatomic) NSMutableArray *dateKeys;

@end



@implementation MoodTableVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
    
    self.dbRef = [[FIRDatabase database] reference];
    storyboardName = @"Main";
    _dbRef = [[[FIRDatabase database] reference] child:@"sweet-items"];

    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self startDatabaseObservationVersionTwo];

}

- (void)startDatabaseObservationVersionTwo {
    self.dbRef = [[FIRDatabase database] reference];
    postsSub = [_dbRef child:@"entries"];
    
    [postsSub observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        self.snapshotsArray = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            MoodObject *newMoodEntry = [[MoodObject alloc] init:snapshot];
            [self.snapshotsArray addObject:newMoodEntry];
            NSLog(@"%@", newMoodEntry);
            [self.tableView reloadData];
            NSString *theDate = newMoodEntry.key;
            NSLog(@"%@", theDate);
            NSLog(@"%@", theDate);
        }
        
        [self.tableView reloadData];
        
        
    }];
    
    
    [self.tableView reloadData];
}
    
- (void)startDatabaseObservation {
    self.dbRef = [[FIRDatabase database] reference];
    postsSub = [[_dbRef child:@"jasi2018"] child:@"MoodEntries"];
    
    [postsSub observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.snapshotsArray = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            MoodObject *newMoodEntry = [[MoodObject alloc] init:snapshot];
            [self.snapshotsArray addObject:newMoodEntry];
            
        }
        
        [self.tableView reloadData];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
// //   UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    EntryCell *eCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    FIRDataSnapshot *snapshot = [self.allSnapshots objectAtIndex:indexPath.row];
//    MoodObject *moodObj = _allSnapshots[indexPath.row];
//    NSLog(@"%@", moodObj.key);
//    NSLog(@"%@", moodObj.key);
//
//    eCell.dateLabel.text = moodObj.key;
//    eCell.motLevel.text = @"WORDS"; // moodObj.motValue;
//
//    NSLog(@"\n\n\n\nHERE: ------> %@\n\n\n\n\n", moodObj.key);
//
//    // eCell.motLevel.text = motiLevel;
//    return eCell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self.tableView reloadData];
    EntryCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
   // FIRDataSnapshot *snapshot = [self.snapshotsArray objectAtIndex:indexPath.row];
//    if ([_snapshotsArray count] == 0) {
//    
//    } else {
//    MoodObject *moodObj = _snapshotsArray[indexPath.row];
//    NSLog(@"\n\n\n READ THIS %@ %@ \n\n\n", moodObj.motValue, moodObj.moodValue);
//    theCell.dateLabel.text = moodObj.motValue;
//    theCell.motLevel.text = moodObj.moodValue;
//    }
    

    theCell.dateLabel.text = @"here's some text";
    theCell.motLevel.text = @"more text";
    
    return theCell;
}
@end
