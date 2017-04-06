//
//  FilterViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FilterViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    IBOutlet UIButton *cancelBtn;
    IBOutlet UIButton *applyButton;
    IBOutlet UIButton *scienceBtn;
    IBOutlet UIButton *typeBtn;
    IBOutlet UIButton *dateAddBtn;
    IBOutlet UIButton *costBtn;
    IBOutlet UIButton *timeBtn;
    IBOutlet UILabel *scienceLbl;
    IBOutlet UILabel *typeLbl;
    IBOutlet UITextField *minTxtFld;
    IBOutlet UITextField *maxTxtFld;
    IBOutlet UIImageView *dateAddImg;
    IBOutlet UIImageView *costImg;
    IBOutlet UIImageView *timeImg;
    
    NSMutableArray *arrOfImg;
    
}

@property (nonatomic, strong) IBOutlet UIButton *applyButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) IBOutlet UIButton *scienceBtn;
@property (nonatomic, strong) IBOutlet UIButton *typeBtn;
@property (nonatomic, strong) IBOutlet UIButton *dateAddBtn;
@property (nonatomic, strong) IBOutlet UIButton *costBtn;
@property (nonatomic, strong) IBOutlet UIButton *timeBtn;
@property (nonatomic, strong) IBOutlet UILabel *scienceLbl;
@property (nonatomic, strong) IBOutlet UILabel *typeLbl;
@property (nonatomic, strong) IBOutlet UITextField *minTxtFld;
@property (nonatomic, strong) IBOutlet UITextField *maxTxtFld;
@property (nonatomic, strong) IBOutlet UIImageView *dateAddImg;
@property (nonatomic, strong) IBOutlet UIImageView *costImg;
@property (nonatomic, strong) IBOutlet UIImageView *timeImg;


@end
