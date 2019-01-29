//
//  binaryCell.m
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import "binaryCell.h"

@implementation binaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    binaryCell addSubview;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(130, 235, 0, 0)];
//
//
//
//
//
////    [binaryCell addSubview:mySwitch];
////    binaryCell.accessoryView = mySwitch;
//    // Configure the view for the selected state
}

- (IBAction) flip: (id) sender {
    UISwitch *onoff = (UISwitch *)sender;
    NSLog(@"%@", onoff.on ? @"On" : @"Off");
}


@end
