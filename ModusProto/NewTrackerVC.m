//
//  NewTrackerVC.m
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import "NewTrackerVC.h"

@interface NewTrackerVC ()

@end

@implementation NewTrackerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *colour = [[UIColor alloc]initWithRed:65/255.0
                                            green:91/255.0
                                             blue:255/255.0
                                            alpha:1.0];
    self.view.backgroundColor = colour;
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
