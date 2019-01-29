//
//  variableCell.m
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//
// *************
//
//
// Use this cell if the other cells aren't necessary.
//
//
//

#import "VariableCell.h"

@implementation VariableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)varType:(int)varType {
    variableType = varType; 
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
