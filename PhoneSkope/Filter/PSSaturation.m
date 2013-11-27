//
//  PSSaturation.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSSaturation.h"

@implementation PSSaturation
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(void)setSaturation:(int)value withObject:(GPUImageSaturationFilter*)object
{
    
    switch (value) {
        case 0:
            [object setSaturation:0];
            break;
        case 1:
            [object setSaturation:0.35];
            break;
        case 2:
            [object setSaturation:0.7];
            break;
        case 3:
            [object setSaturation:1];
            break;
        case 4:
            [object setSaturation:1.35];
            break;
        case 5:
            [object setSaturation:1.7];
            break;
        case 6:
            [object setSaturation:2];
            break;
        default:
            break;
    }
}
-(GPUImageSaturationFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageSaturationFilter alloc] init];
    [(GPUImageSaturationFilter *)filter setSaturation:1];
    return (GPUImageSaturationFilter*)filter;
}
@end
