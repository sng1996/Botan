//
//  CameraViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UIView *cameraPlace;
    IBOutlet UIButton *doneBtn;
    IBOutlet UIButton *backBtn;
    IBOutlet UIButton *takePhotoBtn;
    IBOutlet UIButton *gallaryBtn;
    AVCaptureSession *session;
    AVCaptureStillImageOutput *stillImageOutput;
    IBOutlet UIButton *imageBtn;
    IBOutlet UIView *sView;
}


@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) IBOutlet UIView *cameraPlace;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (strong, nonatomic) IBOutlet UIButton *gallaryBtn;
@property (strong, nonatomic) IBOutlet UIButton *imageBtn;
@property (strong, nonatomic) IBOutlet UIView *sView;


- (IBAction)takePhoto:  (UIButton *)sender;


@end
