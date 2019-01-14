//
//  AddDetail.m
//  ModusProto
//
//  Created by Jack Simmons on 1/8/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import "AddDetailVC.h"
#import "AppDelegate.h"

@interface AddDetailVC ()

@end

@implementation AddDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *anotherView = [[UIViewController alloc] init];
    UIView *thisView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    thisView.backgroundColor = [UIColor darkGrayColor];
    NSLog(@"AddDetailVC has loaded");
    [self.view addSubview:thisView];
//    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    navBar.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"parameters";
    
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"helvetica" size:21]}];
    [self.view addSubview:navBar];
    
    
    
//    // add the nav bar in here
//    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:anotherView];
//    [self.navigationController pushViewController:navCon animated:YES];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(76/255.0) green:(99/255.0) blue:(135/255.0) alpha:1];
//    
//    self.navigationController.navigationBar.translucent = NO;
//    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.title = @"parameters";
//    
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//

//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont fontWithName:@"helvetica" size:21]}];
//
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:navCon]; 
    
//    [self.view addSubview:navCon];
    
    
    
    [self loadUserPreferences];
    
}

- (void)loadUserPreferences {
    
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
