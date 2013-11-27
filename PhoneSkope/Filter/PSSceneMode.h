//
//  PSSceneMode.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSSceneMode : NSObject
-(NSArray*)getArray;
-(GPUImageRGBFilter*)getDefaultValue;
-(void)setSceneMode:(int)type withObject:(GPUImageRGBFilter*)object;
@end
