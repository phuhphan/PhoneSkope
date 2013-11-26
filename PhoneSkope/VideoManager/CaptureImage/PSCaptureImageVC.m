//
//  PSCaptureImageVC.m
//  PhoneSkope
//
//  Created by Phan Hoang Phu on 11/13/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSCaptureImageVC.h"

@interface PSCaptureImageVC ()

@end

@implementation PSCaptureImageVC

-(id)init
{
    self = [super initWithNibName:@"RotateVideoVC" bundle:nil];
    if (self) {
    }
    return self;
}

-(void)captureImage:(id)sender
{
    [super captureImage:sender];
    NSLog(@"Sub");
}
@end
