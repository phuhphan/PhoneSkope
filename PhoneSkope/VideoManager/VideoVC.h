//
//  RotateVideoVC.h
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "PSGeneral.h"
#import "PSCaptureSupport.h"
#import "RotateCell.h"
@interface VideoVC : UIViewController<UITableViewDelegate, UITableViewDataSource,GPUImageVideoCameraDelegate,VideoCellDelegate>
{
    GPUImageFilterGroup *filter;
}
@property(nonatomic,strong) GPUImageVideoCamera *videoCamera;
@property(nonatomic,strong) GPUImageMovieWriter *movieWriter;
@property(nonatomic,strong) GPUImageStillCamera* stillcamera;

@property(nonatomic,strong) PSGeneral* gerenalObj;
@property(nonatomic,strong) PSCaptureSupport* captureObj;
-(IBAction)captureImage:(id)sender;
@end
