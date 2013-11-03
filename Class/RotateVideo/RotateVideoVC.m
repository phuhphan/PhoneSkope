//
//  RotateVideoVC.m
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import "RotateVideoVC.h"
#import "RotateCell.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface RotateVideoVC ()
{
    __weak IBOutlet UISlider* slider;
    __weak IBOutlet UIButton* menu;
    __weak IBOutlet UIButton* capture;
    __weak IBOutlet UITableView* _tableView;
    NSMutableArray* _arrayCamera;
    NSMutableArray* _arrayPhoto;
}
@end

@implementation RotateVideoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrayCamera = [[NSMutableArray alloc]initWithObjects:@"White blance", @"Effect", @"Scene mode", @"ISO", @"Exposure mode", @"Exposure compensation", @"Anti banding", @"Focus mode", @"Constast", @"Saturation", nil];
        _arrayPhoto = [[NSMutableArray alloc]initWithObjects:@"Photo resolution", @"Photo mode", @"JPEG quality", @"Other settings", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    slider.frame = CGRectMake(-slider.frame.size.width/2 + 10, 50, slider.frame.size.width, slider.frame.size.height);
    menu.frame = CGRectMake(270, 20, menu.frame.size.width, menu.frame.size.height);
    capture.frame = CGRectMake(270, 280, capture.frame.size.width, capture.frame.size.height);
    _tableView.frame = CGRectMake(-150, 20, 170, 260);
    //videoCamera setCaptureSessionPreset:AV
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1920x1080 cameraPosition:AVCaptureDevicePositionBack];
    
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    videoCamera.horizontallyMirrorRearFacingCamera = NO;
  
    filter = [[GPUImageSepiaFilter alloc] init];
    
    //    filter = [[GPUImageTiltShiftFilter alloc] init];
    //    [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.65];
    //    [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.85];
    //    [(GPUImageTiltShiftFilter *)filter setBlurSize:1.5];
    //    [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
    
    //    filter = [[GPUImageSketchFilter alloc] init];
    //    filter = [[GPUImageSmoothToonFilter alloc] init];
    //    GPUImageRotationFilter *rotationFilter = [[GPUImageRotationFilter alloc] initWithRotation:kGPUImageRotateRightFlipVertical];
    
    [videoCamera addTarget:filter];
    GPUImageView* filterView = [[GPUImageView alloc] init];
    self.view = filterView;
    
//    stillCamera = [[GPUImageStillCamera alloc] init];
//    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//    
//    myGammaFilter = [[GPUImageGammaFilter alloc] init];
//    //[myGammaFilter prepareForImageCapture];
//    [stillCamera addTarget:myGammaFilter];
//    [myGammaFilter addTarget:filterView];
//    
//    [stillCamera startCameraCapture];
    

    [filter addTarget:filterView];
    [self.view addSubview:slider];
    [self.view addSubview:_tableView];
    [self.view addSubview:menu];
    [self.view addSubview:capture];
    
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(degreesToRadian(90));
    landscapeTransform = CGAffineTransformTranslate (landscapeTransform, 0.0, 0.0);
    [slider setTransform:landscapeTransform];
    [_tableView setTransform:landscapeTransform];
    [menu setTransform:landscapeTransform];
    [capture setTransform:landscapeTransform];
    
    _tableView.hidden = YES;
    //    filterView.fillMode = kGPUImageFillModeStretch;
    //    filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    // Record a movie for 10 s and store it in /Documents, visible via iTunes file sharing
    
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    //    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 480.0)];
    //    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(720.0, 1280.0)];
    //    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(1080.0, 1920.0)];
    [filter addTarget:movieWriter];
    
    [videoCamera startCameraCapture];
    
    double delayToStartRecording = 0.5;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, delayToStartRecording * NSEC_PER_SEC);
    dispatch_after(startTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Start recording");
        
        videoCamera.audioEncodingTarget = movieWriter;
        [movieWriter startRecording];
        
        //        NSError *error = nil;
        //        if (![videoCamera.inputCamera lockForConfiguration:&error])
        //        {
        //            NSLog(@"Error locking for configuration: %@", error);
        //        }
        //        [videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
        //        [videoCamera.inputCamera unlockForConfiguration];
        
        double delayInSeconds = 30.0;
        dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(stopTime, dispatch_get_main_queue(), ^(void){
            
            [filter removeTarget:movieWriter];
            videoCamera.audioEncodingTarget = nil;
            [movieWriter finishRecording];
            NSLog(@"Movie completed");
            
            //            [videoCamera.inputCamera lockForConfiguration:nil];
            //            [videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
            //            [videoCamera.inputCamera unlockForConfiguration];
        });
    });
    
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // Map UIDeviceOrientation to UIInterfaceOrientation.
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeLeft;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            break;
            
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            // When in doubt, stay the same.
            orient = fromInterfaceOrientation;
            break;
    }
    videoCamera.outputImageOrientation = orient;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)shouldAutorotate{
    if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft ||[[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
    else{
        return NO;
    }
}
- (IBAction)updateSliderValue:(id)sender
{
    [(GPUImageSepiaFilter *)filter setIntensity:[(UISlider *)sender value]];
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"RotateCell";
    RotateCell *cell = (RotateCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell==nil) {
        cell =(RotateCell *) [[[NSBundle mainBundle ] loadNibNamed:@"RotateCell" owner:self options:nil] objectAtIndex:0];
    }
    NSString* str;
    if (indexPath.section == 0) {
        str = [_arrayCamera objectAtIndex:indexPath.row];
    }
    else
    {
        str = [_arrayPhoto objectAtIndex:indexPath.row];
    }
    cell.name.text = str;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"RotateCell";
    RotateCell *cell = (RotateCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell==nil) {
        cell =(RotateCell *) [[[NSBundle mainBundle ] loadNibNamed:@"RotateCell" owner:self options:nil] objectAtIndex:0];
    }
    
    return cell.frame.size.height;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Video";
    }
    else
    {
        return @"Photo";
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return _arrayCamera.count;
    else
        return _arrayPhoto.count;
}
-(IBAction)rotateVideo:(id)sender
{
    _tableView.hidden = NO;
}
-(IBAction)btnCapturePressed:(id)sender{
    
    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:myGammaFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error)
     {
         [videoCamera stopCameraCapture];
         [stillCamera stopCameraCapture];
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         
         NSError *error2 = nil;
         if (![processedJPEG writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
         {
             return;
         }
         NSLog(@"%@", [documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"]);
     }];
    
}
@end
