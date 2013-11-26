//
//  PSCaptureSupport.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/15/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSCaptureSupport.h"

@implementation PSCaptureSupport
-(id)init
{
    self = [super init];
    if (self) {
        _photoObject = [[PSPhotoObject alloc]init];
        _photoObject.photoResolution = AVCaptureSessionPreset352x288;
        _photoObject.photoJPEGQuanlity = 0.1;
        _photoObject.photoSelfTimer = 1;
    }
    return self;
}

-(NSArray*)getMenuArray:(PhotoType)type
{
    switch (type) {
        case PhotoResolution:
            return [[NSArray alloc]initWithObjects:@"352x288", @"640x480", @"1280x720", @"1920x1080", nil];
            break;
        case PhotoJPEGQuanlity:
            return [[NSArray alloc]initWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", nil];
            break;
        case PhotoSaveGPS:
            return [[NSArray alloc]initWithObjects:nil];
            break;
        case PhotoOverlay:
            return [[NSArray alloc]initWithObjects:nil];
            break;
        case PhotoDelayJPEG:
            return [[NSArray alloc]initWithObjects:nil];
            break;
        case PhotoSelfTimer:
            return [[NSArray alloc]initWithObjects:@"1s", @"2s", @"3s", @"4s", @"5s", nil];
            break;
        case PhotoStabilizer:
            return [[NSArray alloc]initWithObjects:nil];
            break;
        default:
            return [[NSArray alloc]initWithObjects:@"", nil];
            break;
    }
}
-(void)setType:(PhotoType)type forValue:(int)value
{
    switch (type) {
        case PhotoResolution:
            switch (value) {
                case 0:
                    _photoObject.photoResolution = AVCaptureSessionPreset352x288;
                    break;
                case 1:
                    _photoObject.photoResolution = AVCaptureSessionPreset640x480;
                    break;
                case 2:
                    _photoObject.photoResolution = AVCaptureSessionPreset1280x720;
                    break;
                case 3:
                    _photoObject.photoResolution = AVCaptureSessionPreset1920x1080;
                default:
                    break;
            }
            break;
        case PhotoJPEGQuanlity:
            _photoObject.photoJPEGQuanlity = (float)((float)value + 1) * 0.1;
            break;
        case PhotoSaveGPS:
            if (value == 1)
                _photoObject.photoSaveGPS = YES;
            else
                _photoObject.photoSaveGPS = NO;
            break;
        case PhotoOverlay:
            if (value == NO)
                _photoObject.photoOverlay = YES;
            else
                _photoObject.photoOverlay = NO;
            break;
        case PhotoDelayJPEG:
            if (value == NO)
                _photoObject.photoDelayJPEG = YES;
            else
                _photoObject.photoDelayJPEG = NO;
            break;
        case PhotoSelfTimer:
            _photoObject.photoSelfTimer = value + 1;
            break;
        case PhotoStabilizer:
            if (value == NO)
                _photoObject.photoStabilizer = YES;
            else
                _photoObject.photoStabilizer = NO;
            break;
        default:
            
            break;
    }
}
@end
