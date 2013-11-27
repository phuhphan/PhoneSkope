//
//  PSWhiteBalance.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSWhiteBalance.h"

@implementation PSWhiteBalance

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"Auto", @"incandescent", @"fluorescent", @"daylight", @"cloudy-daylight", nil];
}
-(GPUImageWhiteBalanceFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageWhiteBalanceFilter alloc] init];
    [(GPUImageWhiteBalanceFilter *)filter setTemperature:5000];
    return (GPUImageWhiteBalanceFilter *)filter;
}
-(void)setWhiteblance:(WhiteBlanceType)type withObject:(GPUImageWhiteBalanceFilter*)object
{
    
    switch (type) {
        case WhiteBlanceAuto:
            [object setTemperature:5000];
            break;
        case WhiteBlanceIncandescent:
            [object setTemperature:0];
            break;
        case WhiteBlanceFluorescent:
            [object setTemperature:2500];
            break;
        case WhiteBlanceDaylight:
            [object setTemperature:7500];
            break;
        case WhiteBlanceCloudyDaylight:
            [object setTemperature:10000];
            break;
        default:
            break;
    }
    
}
@end
