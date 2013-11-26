//
//  PSPhotoObject.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/15/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPhotoObject : NSObject
@property(nonatomic,strong) NSString*   photoResolution;
@property(nonatomic,assign) float       photoJPEGQuanlity;
@property(nonatomic,assign) BOOL        photoSaveGPS;
@property(nonatomic,assign) BOOL        photoOverlay;
@property(nonatomic,assign) BOOL        photoDelayJPEG;
@property(nonatomic,assign) int         photoSelfTimer;
@property(nonatomic,assign) BOOL        photoStabilizer;
@end
