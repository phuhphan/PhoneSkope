//
//  PSCaptureSupport.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/15/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPhotoObject.h"
#import <AVFoundation/AVFoundation.h>
#import "PSGeneral.h"

@interface PSCaptureSupport : NSObject
-(void)setType:(PhotoType)type forValue:(int)value;

@property(nonatomic,strong) PSPhotoObject* photoObject;
@end
