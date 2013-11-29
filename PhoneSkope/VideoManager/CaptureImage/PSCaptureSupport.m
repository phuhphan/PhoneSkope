//
//  PSCaptureSupport.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/15/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSCaptureSupport.h"
#import "DateChange.h"
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
            _photoObject.photoSaveGPS = value;
            break;
        case PhotoOverlay:
            _photoObject.photoOverlay = value;
            break;
        case PhotoDelayJPEG:
             _photoObject.photoDelayJPEG = value;
            break;
        case PhotoSelfTimer:
            _photoObject.photoSelfTimer = value;
            break;
        case PhotoStabilizer:
            _photoObject.photoStabilizer = value;
            break;
        default:
            
            break;
    }
}
-(UIImage *)addText:(UIImage *)img{
    
    NSDate* dateNow = [DateChange getCurrentDate];
    NSString* text1 = [NSString stringWithFormat:@"%d-%d-%d %d-%d", [DateChange getDay:dateNow],[DateChange getMonth:dateNow], [DateChange getYear:dateNow], [DateChange getHour:dateNow], [DateChange getMinute:dateNow]];
    
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
	char* text	= (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Arial",20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextShowTextAtPoint(context,10,10,text, strlen(text));
    CGImageRef imgCombined = CGBitmapContextCreateImage(context);
    
	CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
	return [UIImage imageWithCGImage:imgCombined];
}

@end

