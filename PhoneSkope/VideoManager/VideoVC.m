//
//  RotateVideoVC.m
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/1/13.
//  Copyright (c) 2013 Phu Phan. All rights reserved.
//

#import "VideoVC.h"
#import "PSVideoObject.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <MapKit/MapKit.h>
#import "PSTimerView.h"
#import <ImageIO/ImageIO.h>

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface VideoVC ()
{
    __weak IBOutlet UITableView* _tableView;
    __weak IBOutlet UIView* _mainMenuView,* _menuView,* captureView,* flashMenu;
    __weak IBOutlet UIButton* _cameraButton, *_photoButton, *_otherButton,* capture,* flashButton,* zoomButton, * imageButton,* menu;
    __weak IBOutlet UILabel* _titleLabel;
    UISlider* _slider;
    NSArray* _arrayChildElement;
    NSMutableArray* _arrayCamera, * _arrayVideo, * _arrayPhoto,* _arrayOther;
    FilterType _filterType;
    PhotoType _photoType;
    OthersType _otherType;
    VideoType _videoType;
    SessionType sessionType;
    BOOL isChildData;
    BOOL isCaptureImage;
    int _levelZoom;
    PSVideoObject* gerenalObject;
    AVCaptureDevice *flashLight;
    NSURL *moviePath;
    NSTimer* timerReduce;
    PSTimerView* _timerView;
}
@end

@implementation VideoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isChildData = NO;
    flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480  cameraPosition:AVCaptureDevicePositionBack];
    _stillcamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    filter = [[GPUImageFilterGroup alloc] init];
    isCaptureImage = YES;
    flashMenu = [[NSBundle mainBundle]loadNibNamed:@"VideoVC" owner:self options:nil][1];
    _timerView = [[NSBundle mainBundle]loadNibNamed:@"PSTimerView" owner:self options:nil][0];
    _timerView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - _timerView.frame.size.width)/2, _timerView.frame.size.width, _timerView.frame.size.width);
    flashMenu.frame = CGRectMake(10, 63, flashMenu.frame.size.width, flashMenu.frame.size.height);
    //captureView = [[NSBundle mainBundle]loadNibNamed:@"VideoVC" owner:self options:nil][2];
    captureView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - captureView.frame.size.height, captureView.frame.size.width, captureView.frame.size.height);
    
    menu.frame = CGRectMake((320 - menu.frame.size.width)/2, 30, menu.frame.size.width, menu.frame.size.height);
    zoomButton.frame = CGRectMake(self.view.frame.size.width - 10 - zoomButton.frame.size.width, 30, zoomButton.frame.size.width, zoomButton.frame.size.height);
    flashButton.frame = CGRectMake(10, 30, flashButton.frame.size.width, flashButton.frame.size.height);
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(165, 200, 280, 29)];
    _slider.transform = CGAffineTransformMakeRotation (-3.14/2);
    _slider.maximumValue = 5;
    _slider.minimumValue = 1;
    _slider.value = 1;
    [_slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    _mainMenuView.frame = CGRectMake(20, 100, _mainMenuView.frame.size.width, _mainMenuView.frame.size.height);
    //videoCamera setCaptureSessionPreset:AV
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    //    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1920x1080 cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    _videoCamera.horizontallyMirrorRearFacingCamera = NO;
    GPUImageView* filterView = [[GPUImageView alloc] init];
    
    self.view = filterView;
    
    _gerenalObj = [[PSGeneral alloc]initWithView:self.view Camera:_videoCamera];
    _captureObj = [[PSCaptureSupport alloc]init];
    [self.view addSubview:_slider];
    [self.view addSubview:menu];
    [self.view addSubview:_mainMenuView];
    [self.view addSubview:flashMenu];
    [self.view addSubview:zoomButton];
    [self.view addSubview:flashButton];
    [self.view addSubview:captureView];
    [self.view addSubview:_timerView];

    _timerView.hidden = YES;
    flashMenu.hidden = YES;
    _mainMenuView.hidden = YES;
    [_videoCamera startCameraCapture];
    
    

    
    _arrayCamera = [[NSMutableArray alloc]initWithArray:[_gerenalObj getData:SessionCamera]];
    _arrayPhoto = [[NSMutableArray alloc]initWithArray:[_gerenalObj getData:SessionPhoto]];
    _arrayOther = [[NSMutableArray alloc]initWithArray:[_gerenalObj getData:SessionOthers]];
    _arrayVideo = [[NSMutableArray alloc]initWithArray:[_gerenalObj getData:SessionVideo]];
    sessionType = SessionCamera;
    [_tableView reloadData];
}

-(void)initData
{
    
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isChildData)
    {

        static NSString *CellIndentifier = @"RotateCell";
        RotateCell *cell = (RotateCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        
        if (cell==nil) {
            cell =(RotateCell *) [[[NSBundle mainBundle ] loadNibNamed:@"RotateCell" owner:self options:nil] objectAtIndex:1];
        }
        cell.delegate = self;
        NSString* str = [_arrayChildElement objectAtIndex:indexPath.row];
        [cell.selectButton setTitle:str forState:UIControlStateNormal];
        [cell.selectButton setTitle:str forState:UIControlStateHighlighted];
        cell.type = CellChildElement;
        cell.value = gerenalObject.value;
        cell.videoObject = gerenalObject;
        return cell;
    }
    else
    {
        static NSString *CellIndentifier = @"RotateCell";
        RotateCell *cell = (RotateCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        
        if (cell==nil) {
            cell =(RotateCell *) [[[NSBundle mainBundle ] loadNibNamed:@"RotateCell" owner:self options:nil] objectAtIndex:0];
        }
        PSVideoObject* object;
        switch (sessionType) {
            case SessionCamera:
                object = [_arrayCamera objectAtIndex:indexPath.row];
                break;
            case SessionOthers:
                object = [_arrayOther objectAtIndex:indexPath.row];
                break;
            case SessionPhoto:
                object = [_arrayPhoto objectAtIndex:indexPath.row];
                break;
            case SessionVideo:
                object = [_arrayVideo objectAtIndex:indexPath.row];
                break;
        }
        cell.delegate = self;
        cell.type = object.type;
        cell.name.text = object.name;
        cell.value = object.value;
        cell.videoObject = object;
        
        return cell;
    }
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isChildData)
        return _arrayChildElement.count;
    else
    {
        switch (sessionType) {
            case SessionCamera:
                return _arrayCamera.count;
                break;
            case SessionOthers:
                return _arrayOther.count;
                break;
            case SessionPhoto:
                return _arrayPhoto.count;
                break;
            case SessionVideo:
                return _arrayVideo.count;
                break;
            default:
                return _arrayCamera.count;
                break;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isChildData == NO) {
        if (_arrayChildElement.count > 1) {
            isChildData = YES;
        }
        PSVideoObject* object;
        switch (sessionType) {
            case SessionCamera:
                object = [_arrayCamera objectAtIndex:indexPath.row];
                _arrayChildElement = [_gerenalObj getMenuArray:indexPath.row];
                _filterType = indexPath.row;
                break;
            case SessionOthers:
                object = [_arrayOther objectAtIndex:indexPath.row];
                _arrayChildElement = [_gerenalObj getMenuOtherArray:indexPath.row];
                _otherType = indexPath.row;
                break;
            case SessionPhoto:
                object = [_arrayPhoto objectAtIndex:indexPath.row];
                _arrayChildElement = [_gerenalObj getMenuPhotoArray:indexPath.row];
                _photoType = indexPath.row;
                break;
            case SessionVideo:
                object = [_arrayVideo objectAtIndex:indexPath.row];
                _arrayChildElement = [_gerenalObj getMenuVideoArray:indexPath.row];
                _videoType = indexPath.row;
                break;
        }
        if (object.type != CellSwithChoice) {
            gerenalObject = object;
            _titleLabel.text = object.name;
            _menuView.hidden = YES;
            [_tableView reloadData];
        }
    }
    
    

}

-(IBAction)rotateVideo:(id)sender
{
    if (_mainMenuView.hidden) {
        _mainMenuView.hidden = NO;
        _slider.hidden = YES;
        [zoomButton setBackgroundImage:[UIImage imageNamed:@"zoom_normal.png"] forState:UIControlStateHighlighted];
        [zoomButton setBackgroundImage:[UIImage imageNamed:@"zoom_normal.png"] forState:UIControlStateNormal];
        [menu setBackgroundImage:[UIImage imageNamed:@"optionbutton_highlight.png"] forState:UIControlStateNormal];
        [menu setBackgroundImage:[UIImage imageNamed:@"optionbutton_highlight.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        _mainMenuView.hidden = YES;
        [menu setBackgroundImage:[UIImage imageNamed:@"optionButton.png"] forState:UIControlStateNormal];
        [menu setBackgroundImage:[UIImage imageNamed:@"optionButton.png"] forState:UIControlStateHighlighted];
    }
}
-(IBAction)backButton:(id)sender
{
    _menuView.hidden = NO;
    [self segmentDidChange:_cameraButton];
}
-(IBAction)captureImage:(id)sender
{
    if (isCaptureImage) {
        if (_captureObj.photoObject.photoSelfTimer == 0) {
            [self startCapture];
        }
        else
        {
            _timerView.timerLabel.text = [NSString stringWithFormat:@"%d",_captureObj.photoObject.photoSelfTimer];
            _timerView.hidden = NO;
            timerReduce = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimer) userInfo:nil repeats:YES];
        }
    }
    else
    {
        NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
        unlink([pathToMovie UTF8String]);
        moviePath = [NSURL fileURLWithPath:pathToMovie];
        self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:moviePath size:CGSizeMake(480.0, 640.0)];
        [_videoCamera addTarget:self.movieWriter];
        [_videoCamera startCameraCapture];
        _videoCamera.audioEncodingTarget = self.movieWriter;
        [self.movieWriter startRecording];
    }
}

-(void)showTimer
{
    _timerView.timerLabel.text = [NSString stringWithFormat:@"%d",([_timerView.timerLabel.text intValue] - 1)];
    NSLog(@"Timer: %@",_timerView.timerLabel.text);
    if ([_timerView.timerLabel.text intValue] == 0) {
        _timerView.hidden = YES;
        [timerReduce invalidate];
        [self startCapture];
    }
}

-(void)startCapture
{
    [_videoCamera stopCameraCapture];
    [_stillcamera startCameraCapture];
    _stillcamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    if (_captureObj.photoObject.photoDelayJPEG) {
        [_stillcamera setCaptureSessionPreset:AVCaptureSessionPresetHigh];
    }
    else if(_captureObj.photoObject.photoResolution != nil)
    {
        [_stillcamera setCaptureSessionPreset:_captureObj.photoObject.photoResolution];
    }
    else
        [_stillcamera setCaptureSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureConnection *videoConnection = [_stillcamera videoCaptureConnection];
    if (_captureObj.photoObject.photoStabilizer) {
        if ([videoConnection isVideoStabilizationSupported])
        {
            NSLog(@"VideoStabilizationSupported! Curr val: %i", [videoConnection isVideoStabilizationEnabled]);
            if (![videoConnection isVideoStabilizationEnabled])
            {
                NSLog(@"enabling Video Stabilization!");
                videoConnection.enablesVideoStabilizationWhenAvailable= YES;
                NSLog(@"after: %i", [videoConnection isVideoStabilizationEnabled]);
            }
        }
    }
    [_stillcamera capturePhotoAsImageProcessedUpToFilter:_gerenalObj.currentFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        NSLog(@"abcde");
        NSData *dataForPNGFile = UIImageJPEGRepresentation(processedImage, _captureObj.photoObject.photoJPEGQuanlity);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSError *error2 = nil;
        if (![dataForPNGFile writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
        {
            return;
        }
        NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"]);
        UIImage* image= [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"]];
        
        if (_captureObj.photoObject.photoOverlay) {
            image   = [_captureObj addText:image];
        }
        
        if (_captureObj.photoObject.photoSaveGPS) {
            CLLocation* loc = [[CLLocation alloc]init];
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
            NSDictionary *gpsDict   = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithFloat:fabs(loc.coordinate.latitude)], kCGImagePropertyGPSLatitude
                                       , ((loc.coordinate.latitude >= 0) ? @"N" : @"S"), kCGImagePropertyGPSLatitudeRef
                                       , [NSNumber numberWithFloat:fabs(loc.coordinate.longitude)], kCGImagePropertyGPSLongitude
                                       , ((loc.coordinate.longitude >= 0) ? @"E" : @"W"), kCGImagePropertyGPSLongitudeRef
                                       , [formatter stringFromDate:[loc timestamp]], kCGImagePropertyGPSTimeStamp
                                       , [NSNumber numberWithFloat:fabs(loc.altitude)], kCGImagePropertyGPSAltitude
                                       , nil];
            [library writeImageDataToSavedPhotosAlbum:dataForPNGFile metadata:gpsDict completionBlock:^(NSURL *assetURL, NSError *error) {
            }];
        }
        else
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
        
        [imageButton setBackgroundImage:image forState:UIControlStateNormal];
        [imageButton setBackgroundImage:image forState:UIControlStateHighlighted];
        // [self viewDidLoad];
    }];
    
    [_stillcamera stopCameraCapture];
    [_videoCamera startCameraCapture];
}

-(IBAction)changeValue:(id)sender
{
    NSLog(@"zoom");
    [_gerenalObj setZoom:_slider.value];
}
-(IBAction)showFlashMenuPress:(id)sender
{
    if (flashMenu.hidden) {
        flashMenu.hidden = NO;
        _mainMenuView.hidden = YES;
    }
    else
    {
        flashMenu.hidden = YES;
    }
    
}
-(IBAction)zoomPress:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if (_slider.hidden) {
        [button setBackgroundImage:[UIImage imageNamed:@"zoom_selected.png"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"zoom_selected.png"] forState:UIControlStateNormal];
        _slider.hidden = NO;
        _mainMenuView.hidden = YES;
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"zoom_normal.png"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"zoom_normal.png"] forState:UIControlStateNormal];
        _slider.hidden = YES;
    }
}

-(IBAction)switchStatus:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if (isCaptureImage) {
        [button setBackgroundImage:[UIImage imageNamed:@"switchStatusCapture.png"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"switchStatusCapture.png"] forState:UIControlStateNormal];
        [capture setBackgroundImage:[UIImage imageNamed:@"camera_start_rotate_image.png"] forState:UIControlStateHighlighted];
        [capture setBackgroundImage:[UIImage imageNamed:@"camera_start_rotate_image.png"] forState:UIControlStateNormal];
        isCaptureImage = NO;
        [_photoButton setTitle:@"Video" forState:UIControlStateNormal];
        [_photoButton setTitle:@"Video" forState:UIControlStateHighlighted];
        [self segmentDidChange:_cameraButton];
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"switchStatusCamera.png"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"switchStatusCamera.png"] forState:UIControlStateNormal];
        [capture setBackgroundImage:[UIImage imageNamed:@"video_capture_icon.png"] forState:UIControlStateHighlighted];
        [capture setBackgroundImage:[UIImage imageNamed:@"video_capture_icon.png"] forState:UIControlStateNormal];
        isCaptureImage = YES;
        [_photoButton setTitle:@"Photo" forState:UIControlStateNormal];
        [_photoButton setTitle:@"Photo" forState:UIControlStateHighlighted];
        [self segmentDidChange:_cameraButton];
    }
}

-(IBAction)actionMenuPress:(id)sender
{
    UIButton* button = (UIButton*)sender;
    flashMenu.hidden = YES;
    if (button.tag == 3) {
        if([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
        {
            BOOL success = [flashLight lockForConfiguration:nil];
            if(success){
                [flashLight setTorchMode:AVCaptureTorchModeOn];
                [flashLight unlockForConfiguration];
            }
        }
    }
    if (button.tag == 2) {
        if([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
        {
            BOOL success = [flashLight lockForConfiguration:nil];
            if(success){
                [flashLight setTorchMode:AVCaptureTorchModeOff];
                [flashLight unlockForConfiguration];
            }
        }
    }
}
- (IBAction)segmentDidChange:(id)sender {
    UIButton* button = (UIButton*)sender;
    
    [_cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_menu_icon.png"] forState:UIControlStateNormal];
    [_cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_menu_icon.png"] forState:UIControlStateHighlighted];
    [_photoButton setBackgroundImage:[UIImage imageNamed:@"photo_menu_icon.png"] forState:UIControlStateNormal];
    [_photoButton setBackgroundImage:[UIImage imageNamed:@"photo_menu_icon.png"] forState:UIControlStateHighlighted];
    [_otherButton setBackgroundImage:[UIImage imageNamed:@"other_menu_icon.png"] forState:UIControlStateNormal];
    [_otherButton setBackgroundImage:[UIImage imageNamed:@"other_menu_icon.png"] forState:UIControlStateHighlighted];
    
    switch (button.tag) {
        case 0:
            sessionType = SessionCamera;
            [button setBackgroundImage:[UIImage imageNamed:@"camera_background.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"camera_background.png"] forState:UIControlStateHighlighted];
            break;
        case 1:
            if (isCaptureImage)
            {
                sessionType = SessionPhoto;
            }
            else
            {
                sessionType = SessionVideo;
            }
            [button setBackgroundImage:[UIImage imageNamed:@"photo_menu_icon_highlight.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"photo_menu_icon_highlight.png"] forState:UIControlStateHighlighted];
            break;
        case 2:
            sessionType = SessionOthers;
            [button setBackgroundImage:[UIImage imageNamed:@"other_background.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"other_background.png"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
    }

    isChildData = NO;
    [_tableView reloadData];
}
-(void)switchAction:(UITableViewCell*)cell forObject:(PSVideoObject*)object Value:(BOOL)value
{
    switch (object.session) {
        case SessionCamera:
            
            break;
        case SessionOthers:
            
            break;
        case SessionPhoto:
            [_captureObj setType:object.photoType forValue:value];
            break;
        case SessionVideo:
            
            break;
        default:
            break;
    }
}
-(void)choiceAction:(UITableViewCell *)cell forObject:(PSVideoObject *)object
{
    NSIndexPath* indexPath = [_tableView indexPathForCell:cell];
    switch (sessionType) {
        case SessionCamera:
            [_gerenalObj setType:object.filterType WithValue:indexPath.row];
            break;
        case SessionOthers:
            break;
        case SessionPhoto:
            [_captureObj setType:object.photoType forValue:indexPath.row];
            break;
        case SessionVideo:
            break;
    }
    object.value = [_arrayChildElement objectAtIndex:indexPath.row];
    
    [self segmentDidChange:_cameraButton];
    _menuView.hidden = NO;
}
@end
