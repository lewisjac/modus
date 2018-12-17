//
//  TableViewControllerTEST.h
//  ModusProto
//
//  Created by Jack Simmons on 12/10/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoodTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
    
    @property (strong, nonatomic) IBOutlet UITableView *tableView;
    

@end

NS_ASSUME_NONNULL_END