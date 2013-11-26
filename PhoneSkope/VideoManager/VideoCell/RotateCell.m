//
//  RotateCell.m
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import "RotateCell.h"

@implementation RotateCell
@synthesize type = _type, value = _value;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(CellType)type
{
    _type = type;
}

-(IBAction)swichAction:(id)sender
{
    self.videoObject.value = [NSString stringWithFormat:@"%hhd",self.enable.on];
    [self.delegate switchAction:self forObject:self.videoObject Value:self.enable.on];
}
-(IBAction)choiceAction:(id)sender
{
    self.videoObject.value = [NSString stringWithFormat:@"%hhd",self.enable.on];
    [self.delegate choiceAction:self forObject:self.videoObject];
}
-(void)setValue:(NSString *)value
{
    _value = value;
    switch (_type) {
        case CellChildElement:
            self.enable.hidden      = YES;
            self.detail.hidden      = YES;
            if ([value isEqualToString:self.selectButton.titleLabel.text]) {
                [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon_highlight.png"] forState:UIControlStateNormal];
                [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon_highlight.png"] forState:UIControlStateHighlighted];
            }
            else
            {
                [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon.png"] forState:UIControlStateNormal];
                [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon.png"] forState:UIControlStateHighlighted];
            }
            break;
        case CellManyChoice:
            self.enable.hidden      = YES;
            self.detail.hidden      = NO;
            self.tickImage.hidden   = YES;
            self.detail.text      = value;
            break;
        case CellSwithChoice:
            self.enable.hidden      = NO;
            if ([value isEqualToString:@"1"])
                [self.enable setOn:YES];
            else
                [self.enable setOn:NO];
            self.detail.hidden      = YES;
            self.tickImage.hidden   = YES;
            break;
        default:
            self.enable.hidden      = YES;
            self.detail.hidden      = YES;
            self.tickImage.hidden   = YES;
            [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon.png"] forState:UIControlStateNormal];
            [self.selectButton setBackgroundImage:[UIImage imageNamed:@"menulist_icon.png"] forState:UIControlStateHighlighted];
            break;
    }
}
@end
