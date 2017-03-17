//
//  GetOrderViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GetOrderViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    IBOutlet UIImageView *taskImage;
    IBOutlet UILabel *headLabel;
    IBOutlet UIButton *rightBtn;
    IBOutlet UIButton *leftBtn;
    IBOutlet UILabel *infoLabel;
    IBOutlet UILabel *nickLabel;
    IBOutlet UIView *profileView;
    IBOutlet UITextView *descriptionTextView;
    IBOutlet UIView *descriptionView;
    IBOutlet UILabel *costLabel;
    IBOutlet UILabel *categoryLabel;
    IBOutlet UILabel *typeLabel;
    IBOutlet UILabel *beginLabel;
    IBOutlet UILabel *endLabel;
}

@property (nonatomic, strong) IBOutlet UIImageView *taskImage;
@property (nonatomic, strong) IBOutlet UILabel *headLabel;
@property (nonatomic, strong) IBOutlet UIButton *rightBtn;
@property (nonatomic, strong) IBOutlet UIButton *leftBtn;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) IBOutlet UILabel *nickLabel;
@property (nonatomic, strong) IBOutlet UIView *profileView;
@property (nonatomic, strong) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, strong) IBOutlet UIView *descriptionView;
@property (nonatomic, strong) IBOutlet UILabel *costLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *beginLabel;
@property (nonatomic, strong) IBOutlet UILabel *endLabel;



@end
