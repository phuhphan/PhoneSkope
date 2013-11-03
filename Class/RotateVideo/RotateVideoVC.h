//
//  RotateVideoVC.h
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface RotateVideoVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    GPUImageGammaFilter *myGammaFilter;
    GPUImageStillCamera * stillCamera;
}
- (IBAction)updateSliderValue:(id)sender;
@end
