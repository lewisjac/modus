//
//  variableCell.h
//  ModusProto
//
//  Created by Jack Simmons on 1/19/19.
//  Copyright © 2019 Jack Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VariableCell : UITableViewCell {
    int variableType;
}

@property (strong, nonatomic) IBOutlet UILabel *varName;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (void)varType:(int)varType;

@end

NS_ASSUME_NONNULL_END
