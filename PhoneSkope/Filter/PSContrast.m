//
//  PSContrast.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSContrast.h"

@implementation PSContrast
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(void)setContrast:(int)value withObject:(GPUImageContrastFilter*)object
{
    
    switch (value) {
        case 0:
            [object setContrast:0];
            break;
        case 1:
            [object setContrast:0.75];
            break;
        case 2:
            [object setContrast:1.5];
            break;
        case 3:
            [object setContrast:2];
            break;
        case 4:
            [object setContrast:2.75];
            break;
        case 5:
            [object setContrast:2.5];
            break;
        case 6:
            [object setContrast:4];
            break;
        default:
            break;
    }
}
-(GPUImageContrastFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageContrastFilter alloc] init];
    [(GPUImageContrastFilter *)filter setContrast:1.0];
    return (GPUImageContrastFilter*)filter;
}
@end
