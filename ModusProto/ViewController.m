//
//  ViewController.m
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//



#import "ViewController.h"
#import "MoodObject.h"
@import Firebase;
#pragma-mark TableView Datasource


@interface ViewController () {
    NSString *storyboardName;
    FIRDatabaseReference *posts;
    
}
    
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (strong, nonatomic) NSMutableArray *allSnapshots;

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
    [self startObservingBD];
    
}

- (void)startObservingBD {
    
    self.dbRef = [[FIRDatabase database] reference];
    posts = [[_dbRef child:@"jasi2018"] child:@"2018-12-04 08:17:00"];
    
    [posts observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allSnapshots = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
            NSLog(@"%@", snapshot);
            [self.allSnapshots addObject:snapshot];
        }
        
    }];
    
//    [[_dbRef queryLimitedToLast:10] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        NSUInteger myInt = snapshot.childrenCount;
//        NSLog(@"%lu", (unsigned long)myInt);
//    }];
//
//
//    [[[_dbRef child:@"jasi2018"] child:@"MoodEntries"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        // Get user value
//
//        FIRDataSnapshot *snap = [[FIRDataSnapshot alloc] init];
//        FIRDatabaseReference *sweetRef = [[self.dbRef child:@"jasi2018"] child:@"MoodEntries"];
//        MoodObject *new = [[MoodObject alloc] init];
//
//        //  snap = [snapshot childrenCount];
//
//        // NSString *val = [[NSString alloc] init];
//
//        // val = [snapshot.value[@"2018-12-04 07:47:05"]];
//        NSLog(@"%@", snap);
//        //User *user = [[User alloc] initWithUsername:snapshot.value[@"username"]];
//
//        // ...
//    } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text=@"text";
    cell.detailTextLabel.text=@"DetailedText";
    return cell;
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

