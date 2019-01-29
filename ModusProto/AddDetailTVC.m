//
//  AddDetailTVC.m
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

/* The addDetail view must do the following:
 - pull variable type and name from FIREBASE under "trackers"
 - populate variables based off the user's preference
 - cells must have dynamic layout based on the variable type
 - remove cell dividers after there are no more populated cells
 - change color of header to match scheme
 */

#import "AddDetailTVC.h"
#import "VariableObject.h"
#import "VariableCell.h"
#import "binaryCell.h"

@import Firebase;

@interface AddDetailTVC () {
    FIRDatabaseReference *postsSub;
}

@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (strong, nonatomic) NSMutableArray *snapshotAray;

@end


@implementation AddDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startDatabaseObservation]; 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)startDatabaseObservation {
    self.dbRef = [[FIRDatabase database] reference];
    postsSub = [[_dbRef child:@"jasi2018"] child:@"Trackers"];
    
    [postsSub observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.snapshotAray = [NSMutableArray array];
        
        for (snapshot in snapshot.children) {
//            NSLog(@"%@", snapshot.key);
//            NSLog(@"%@", snapshot.value);
            
            // From here we could  either create our own little dictionary or use VariableObject.
            // We need to use these data in this file to populate the array
            // The name needs to be displayed but the type of variable is only used to select the correction functionality.
            
            VariableObject *newVariableObj = [[VariableObject alloc] init:snapshot];
           
            [self.snapshotAray addObject:newVariableObj];
            [self.tableView reloadData];
            
            NSString *theKey = newVariableObj.key;
            NSString *theName = newVariableObj.varType;
            NSLog(@" %@: %@", theKey, theName);
             [self.tableView reloadData];
        }
        
        
        
        NSArray* reversedArray = [[self->_snapshotAray reverseObjectEnumerator] allObjects];
        NSLog(@"%@", reversedArray);
        
        
    }withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void) tocLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}






- (IBAction)onTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //nah
    }];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"pressed the canx button");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _snapshotAray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSString *cellIdentifierOne = @"binaryCell";
    binaryCell *binaryCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne forIndexPath:indexPath];
    VariableCell *varCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne forIndexPath:indexPath];
//    VariableCell *varCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *reversedArray = [[self->_snapshotAray reverseObjectEnumerator] allObjects];
    
    VariableObject *varObj = reversedArray[indexPath.row];
    int varTypeAsInt = 0;
    
     NSString *varType = varObj.varType;
    NSLog(@"%@", varType); 
 
    
    if([varType isEqualToString:@"yes/no"]) {
        varTypeAsInt = 0;
        UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [varCell addSubview:theSwitch];
        varCell.accessoryView = theSwitch;
        NSLog(@"yes, it is a yes");
    } else if([varType isEqualToString:@"number"]){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textAlignment = NSTextAlignmentCenter; 
        textField.font = [UIFont systemFontOfSize:15];
        textField.placeholder = @"number";
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = self;
        [varCell addSubview:textField];
        varCell.accessoryView = textField;
   
        varTypeAsInt = 1;
        NSLog(@"Alas, a number");
    } else if([varType isEqualToString:@"1 to 3"]) {
        
        UIView *superView = varCell.containerView;
        
        // Add buttons 1 through 3
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"1" forState:UIControlStateNormal];
         [button setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 10, 40);
//        button.backgroundColor = [UIColor redColor];
        [varCell.containerView addSubview:button];
        
        
        
      

        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonTwo addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [buttonTwo setTitle:@"2" forState:UIControlStateNormal];
        [buttonTwo setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonTwo.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonTwo];

        UIButton *buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonThree addTarget:self
                      action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
        [buttonThree setTitle:@"3" forState:UIControlStateNormal];
        [buttonThree setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonThree.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonThree];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        buttonTwo.translatesAutoresizingMaskIntoConstraints = NO;
        buttonThree.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat tracking = -35.0;
        
        
        // Constraint to position LeftButton's X value
        NSLayoutConstraint *buttonConstraint = [NSLayoutConstraint constraintWithItem:buttonThree
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:varCell.containerView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1.0
                                                                                  constant:0];
        
        NSLayoutConstraint *buttonTwoConstraint = [NSLayoutConstraint constraintWithItem:buttonTwo
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                            toItem:buttonThree // varCell.containerView
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:tracking];
       
        NSLayoutConstraint *buttonThreeConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                               toItem:buttonTwo //varCell.containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0
                                                                             constant:tracking];
    
        
        // Add the constraints to button's superview
        [varCell.containerView addConstraints:@[buttonConstraint,buttonTwoConstraint,buttonThreeConstraint]];
        
        
        
        varTypeAsInt = 2;
        NSLog(@"a range till 3");
    } else if([varType isEqualToString:@"1 to 5"]) {
        
        UIView *superView = varCell.containerView;
        
        // Add buttons 1 through 3
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"1" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:button];
        
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonTwo addTarget:self
                      action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
        [buttonTwo setTitle:@"2" forState:UIControlStateNormal];
        [buttonTwo setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonTwo.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonTwo];
        
        UIButton *buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonThree addTarget:self
                        action:@selector(aMethod:)
              forControlEvents:UIControlEventTouchUpInside];
        [buttonThree setTitle:@"3" forState:UIControlStateNormal];
        [buttonThree setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonThree.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonThree];
        
        UIButton *buttonFour = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonFour addTarget:self
                        action:@selector(aMethod:)
              forControlEvents:UIControlEventTouchUpInside];
        [buttonFour setTitle:@"4" forState:UIControlStateNormal];
        [buttonFour setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonFour.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonFour];
        
        UIButton *buttonFive = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonFive addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
        [buttonFive setTitle:@"5" forState:UIControlStateNormal];
        [buttonFive setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonFive.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonFive];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        buttonTwo.translatesAutoresizingMaskIntoConstraints = NO;
        buttonThree.translatesAutoresizingMaskIntoConstraints = NO;
        buttonFour.translatesAutoresizingMaskIntoConstraints = NO;
        buttonFive.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        
        CGFloat tracking = -35.0;
        
        // Constraint to position LeftButton's X value
        NSLayoutConstraint *buttonFiveConstraint = [NSLayoutConstraint constraintWithItem:buttonFive
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                               toItem:varCell.containerView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:0.0];
        
        NSLayoutConstraint *buttonFourConstraint = [NSLayoutConstraint constraintWithItem:buttonFour
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                  toItem:buttonFive // varCell.containerView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:tracking];
        
        NSLayoutConstraint *buttonThreeConstraint = [NSLayoutConstraint constraintWithItem:buttonThree
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:buttonFour //varCell.containerView
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:tracking];
        
        NSLayoutConstraint *buttonTwoConstraint = [NSLayoutConstraint constraintWithItem:buttonTwo
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:buttonThree //varCell.containerView
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:tracking];
        
        NSLayoutConstraint *buttonConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                  toItem:buttonTwo //varCell.containerView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:tracking];
        
        
        // Add the constraints to button's superview
        [varCell.containerView addConstraints:@[buttonConstraint,buttonTwoConstraint,buttonThreeConstraint, buttonFourConstraint, buttonFiveConstraint]];
        
        varTypeAsInt = 3;
        NSLog(@"5 or so");
    } else if([varType isEqualToString:@"1 to 7"]) {
        
        UIView *superView = varCell.containerView;
        
        // Add buttons 1 through 3
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"1" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 10, 40);
        [superView addSubview:button];
        
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonTwo addTarget:self
                      action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
        [buttonTwo setTitle:@"2" forState:UIControlStateNormal];
        [buttonTwo setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonTwo.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonTwo];
        
        UIButton *buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonThree addTarget:self
                        action:@selector(aMethod:)
              forControlEvents:UIControlEventTouchUpInside];
        [buttonThree setTitle:@"3" forState:UIControlStateNormal];
        [buttonThree setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonThree.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonThree];
        
        UIButton *buttonFour = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonFour addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
        [buttonFour setTitle:@"4" forState:UIControlStateNormal];
        [buttonFour setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonFour.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonFour];
        
        UIButton *buttonFive = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonFive addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
        [buttonFive setTitle:@"5" forState:UIControlStateNormal];
        [buttonFive setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonFive.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonFive];
        
        UIButton *buttonSix = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonSix addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
        [buttonSix setTitle:@"6" forState:UIControlStateNormal];
        [buttonSix setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonSix.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonSix];
        
        UIButton *buttonSeven = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonSeven addTarget:self
                      action: nil // @selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
        buttonSeven touch
        [buttonSeven setTitle:@"7" forState:UIControlStateNormal];
        [buttonSeven setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        buttonSeven.frame = CGRectMake(0, 0, 10, 40);
        [varCell.containerView addSubview:buttonSeven];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        buttonTwo.translatesAutoresizingMaskIntoConstraints = NO;
        buttonThree.translatesAutoresizingMaskIntoConstraints = NO;
        buttonFour.translatesAutoresizingMaskIntoConstraints = NO;
        buttonFive.translatesAutoresizingMaskIntoConstraints = NO;
        buttonSix.translatesAutoresizingMaskIntoConstraints = NO;
        buttonSeven.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat tracking = -35.0;
        
        // Constraint to position LeftButton's X value
        NSLayoutConstraint *buttonSevenConstraint = [NSLayoutConstraint constraintWithItem:buttonSeven
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                   toItem:varCell.containerView
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:0.0];
        
        NSLayoutConstraint *buttonSixConstraint = [NSLayoutConstraint constraintWithItem:buttonSix
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:buttonSeven
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:tracking];
        
        

        NSLayoutConstraint *buttonFiveConstraint = [NSLayoutConstraint constraintWithItem:buttonFive
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                   toItem:buttonSix
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1.0
                                                                                 constant:tracking];
        
        NSLayoutConstraint *buttonFourConstraint = [NSLayoutConstraint constraintWithItem:buttonFour
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                   toItem:buttonFive // varCell.containerView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1.0
                                                                                 constant:tracking];
        
        NSLayoutConstraint *buttonThreeConstraint = [NSLayoutConstraint constraintWithItem:buttonThree
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:buttonFour //varCell.containerView
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:tracking];
        
        NSLayoutConstraint *buttonTwoConstraint = [NSLayoutConstraint constraintWithItem:buttonTwo
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                  toItem:buttonThree //varCell.containerView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:tracking];
        
        NSLayoutConstraint *buttonConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                               toItem:buttonTwo //varCell.containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0
                                                                             constant:tracking];
        
        
        // Add the constraints to button's superview
        [varCell.containerView addConstraints:@[buttonConstraint,buttonTwoConstraint,buttonThreeConstraint, buttonFourConstraint, buttonFiveConstraint, buttonSixConstraint, buttonSevenConstraint]];
        
        varTypeAsInt = 4;
        NSLog(@"Jaun is Seven");
    }
  
    [varCell varType:varTypeAsInt];
    // JAN 23
    // use the type of variable to select the right "code" to place in the cell.
    // Below shows how to implement a pickerView in a uitableview cell 
    // link: https://stackoverflow.com/questions/36058054/how-to-load-data-to-picker-view-inside-custom-tableview-cell-in-ios-objective-c
    
//    NSString *cellIdentifierOne = @"binaryCell";
//    binaryCell *binaryCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne forIndexPath:indexPath];
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    
    
    NSString *myString = [NSString stringWithFormat:@"%i", varTypeAsInt];
  
    // Create an if statement that adds the below switch if chosen variable is binary
    
//    UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
//    [binaryCell addSubview:theSwitch];
//    binaryCell.accessoryView = theSwitch;

    
    varCell.varName.text = varObj.key;
    return varCell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
