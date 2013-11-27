//
//  PSSceneMode.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSSceneMode.h"

@implementation PSSceneMode
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"Auto", @"landscape", @"snow", @"beach", @"sunset", @"night", @"portrait", @"backlight", @"sports", @"steadyphoto", @"flowers", @"candlelight", @"fireworks", @"party", @"night-portrait", @"theatre", @"action", nil];
}
-(void)setSceneMode:(int)value withObject:(GPUImageRGBFilter*)object
{
    
    switch (value) {
        case 0:
            [object setRed:0.0];
            break;
        case 1:
            [object setRed:0.5];
            break;
        case 2:
            [object setRed:1.0];
            break;
        case 3:
            [object setRed:1.5];
            break;
        case 4:
            [object setRed:2.0];
            break;
        case 5:
            [object setGreen:0.0];
            break;
        case 6:
            [object setGreen:0.5];
            break;
        case 7:
            [object setGreen:1.0];
            break;
        case 8:
            [object setGreen:1.5];
            break;
        case 9:
            [object setGreen:2.0];
            break;
        case 10:
            [object setBlue:0.0];
            break;
        case 11:
            [object setBlue:0.5];
            break;
        case 12:
            [object setBlue:1.0];
            break;
        case 13:
            [object setBlue:1.5];
            break;
        case 14:
            [object setBlue:2.0];
            break;
        case 15:
            [object setBlue:1.5];
            break;
        case 16:
            [object setBlue:2.0];
            break;
        default:
            break;
    }
    
}
-(GPUImageRGBFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageRGBFilter alloc] init];
    [(GPUImageRGBFilter *)filter setGreen:1.0];
    return (GPUImageRGBFilter *)filter;
}
@end
