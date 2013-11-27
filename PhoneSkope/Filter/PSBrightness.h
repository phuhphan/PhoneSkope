//
//  PSBrightness.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSBrightness : NSObject
-(NSArray*)getArray;
-(void)setBrightness:(int)value withObject:(GPUImageBrightnessFilter*)object;
-(GPUImageBrightnessFilter*)getDefaultValue;
@end
