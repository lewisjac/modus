//
//  EntryCell.h
//  ModusProto
//
//  Created by Jack Simmons on 12/6/18.
//  Copyright © 2018 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EntryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *motLevel; 
@property (strong, nonatomic) IBOutlet UIImageView *moodImage;

@end

NS_ASSUME_NONNULL_END
