//
//  PSExposureCompensation.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSExposureCompensation : NSObject
-(NSArray*)getArray;
-(void)setExposureCompensation:(int)value withObject:(GPUImageExposureFilter*)object;
-(GPUImageExposureFilter*)getDefaultValue;
@end
