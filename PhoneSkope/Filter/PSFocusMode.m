//
//  PSFocusMode.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSFocusMode.h"

@implementation PSFocusMode
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6",nil];
}
-(void)setFocusMode:(int)value withObject:(GPUImageTiltShiftFilter*)object
{
    switch (value) {
        case 0:
            [object setTopFocusLevel:0.1];
            [object setBottomFocusLevel:0.3];
            break;
        case 1:
            [object setTopFocusLevel:0.2];
            [object setBottomFocusLevel:0.4];
            break;
        case 2:
            [object setTopFocusLevel:0.3];
            [object setBottomFocusLevel:0.5];
            break;
        case 3:
            [object setTopFocusLevel:0.4];
            [object setBottomFocusLevel:0.6];
            break;
        case 4:
            [object setTopFocusLevel:0.5];
            [object setBottomFocusLevel:0.7];
            break;
        case 5:
            [object setTopFocusLevel:0.6];
            [object setBottomFocusLevel:0.8];
            break;
        case 6:
            [object setTopFocusLevel:0.7];
            [object setBottomFocusLevel:0.9];
            break;
        default:
            break;
    }
    [object setFocusFallOffRate:0.2];
}
-(GPUImageTiltShiftFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageTiltShiftFilter alloc] init];
    [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
    [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
    [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
    return (GPUImageTiltShiftFilter *)filter;
}
@end
