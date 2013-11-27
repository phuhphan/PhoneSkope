//
//  PSSharpness.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSSharpness.h"

@implementation PSSharpness
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(void)setSharpness:(int)value withObject:(GPUImageSharpenFilter*)object
{
    
    switch (value) {
        case 0:
            [object setSharpness:-1];
            break;
        case 1:
            [object setSharpness:-0.15];
            break;
        case 2:
            [object setSharpness:0.7];
            break;
        case 3:
            [object setSharpness:1.5];
            break;
        case 4:
            [object setSharpness:2.3];
            break;
        case 5:
            [object setSharpness:3.1];
            break;
        case 6:
            [object setSharpness:4];
            break;
        default:
            break;
    }
}
-(GPUImageSharpenFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageSharpenFilter alloc] init];
    [(GPUImageSharpenFilter *)filter setSharpness:0.0];
    return (GPUImageSharpenFilter*)filter;
}
@end
