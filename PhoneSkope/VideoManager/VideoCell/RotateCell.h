//
//  RotateCell.h
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSGeneral.h"
#import "PSVideoObject.h"
@protocol VideoCellDelegate<NSObject>
-(void)switchAction:(UITableViewCell*)cell forObject:(PSVideoObject*)object Value:(BOOL)value;
-(void)choiceAction:(UITableViewCell*)cell forObject:(PSVideoObject*)object;
@end
@interface RotateCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel* name;
@property(nonatomic,weak) IBOutlet NSString* value;
@property(nonatomic,weak) IBOutlet UILabel* detail;
@property(nonatomic,weak) IBOutlet UISwitch* enable;
@property(nonatomic,weak) IBOutlet UIImageView* tickImage;
@property(nonatomic,weak) IBOutlet UIButton* selectButton;
@property(nonatomic,assign) CellType type;
@property(nonatomic,assign) id<VideoCellDelegate> delegate;
@property(nonatomic,strong) PSVideoObject* videoObject;


@end