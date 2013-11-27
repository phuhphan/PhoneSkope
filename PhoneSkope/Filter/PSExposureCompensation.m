//
//  PSExposureCompensation.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSExposureCompensation.h"

@implementation PSExposureCompensation
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
}
-(void)setExposureCompensation:(int)value withObject:(GPUImageExposureFilter*)object
{
    
    switch (value) {
        case 0:
            [object setExposure:-4.0];
            break;
        case 1:
            [object setExposure:-3.0];
            break;
        case 2:
            [object setExposure:-2.0];
            break;
        case 3:
            [object setExposure:-1.0];
            break;
        case 4:
            [object setExposure:0.0];
            break;
        case 5:
            [object setExposure:1.0];
            break;
        case 6:
            [object setExposure:2.0];
            break;
        case 7:
            [object setExposure:3.0];
            break;
        case 8:
            [object setExposure:4.0];
            break;
        default:
            break;
    }
}
-(GPUImageExposureFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageExposureFilter alloc] init];
    [(GPUImageExposureFilter *)filter setExposure:0.0];
    return (GPUImageExposureFilter*)filter;
}
@end
