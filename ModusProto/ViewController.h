//
//  ViewController.h
//  ModusProto
//
//  Created by Jack Simmons on 11/26/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> 



- (IBAction)newTrackerBtn:(id)sender;
- (IBAction)newMoodBtn:(id)sender;
- (IBAction)settingsBtn:(id)sender;
- (void)startObservingBD;
    
    
    
    

@end

