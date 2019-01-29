//
//  MenuTVC.m
//  ModusProto
//
//  Created by Jack Simmons on 1/4/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import "MenuTVC.h"
#import "AppDelegate.h" // this is here so that we can close the drawer

@interface MenuTVC () {
    NSMutableArray *menuButtons;
    NSString *storyboardName;
}

@end

@implementation MenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    menuButtons = [NSMutableArray arrayWithObjects: @"new tracker", @"trackers",@"correlation", @"account", @"settings", nil];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(46/255.0) green:(69/255.0) blue:(100/255.0) alpha:1];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"menu";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"helvetica" size:21]}];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuButtons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[menuButtons objectAtIndex:indexPath.row] capitalizedString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    NSString * storyboardIdentifier = @"Main";// for example "Main.storyboard" then you have to take only "Main"
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: [NSBundle mainBundle]];
    UIViewController * UIVC = [storyboard instantiateViewControllerWithIdentifier:@"NewTrackerVC"];
    [self presentViewController:UIVC animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        NSLog(@"User Pressed OPTION_2");
    } else if (indexPath.row == 2) {
        NSLog(@"User Pressed OPTION_3");
    } else if (indexPath.row == 3) {
        NSLog(@"User Pressed OPTION_4");
    } else if (indexPath.row == 4) {
        NSLog(@"User Pressed OPTION_5");
    }
    
////     let indexValueSection: Int = indexPath.section
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
//    long val = indexPath.section + 1;
//    UIViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewTrackerVC"];
//
//    [refNavigationController pushViewController:homeVC animated:YES];
//
//
//    //    switch (val) {
////        case 1:
////            [refNavigationController pushViewController:homeVC animated:YES];
////            break;
////
////        default:
////            break;
////    }
    
    

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
