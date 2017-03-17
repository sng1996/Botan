//
//  AddOrderViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddOrderViewController : UIViewController <UITextFieldDelegate>{
    
    AppDelegate *mainDelegate;
    Order *order;
    IBOutlet UIBarButtonItem *rightBarBtn;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *pictureButton;
    IBOutlet UIView *pictureView;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextField *costTxtFld;
    IBOutlet UITextView *descriptionTextView;
    IBOutlet UITextField *sbjTxtFld;
    IBOutlet UIButton *editBtn;
    IBOutlet UILabel *typeLbl;
    IBOutlet UILabel *categoryLbl;
    NSData *jsonData;
    UIImageView *picture;
    NSInteger currentTextField; //look at the tags
    
}

@property (nonatomic, strong) AppDelegate *mainDelegate;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightBarBtn;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIButton *pictureButton;
@property (nonatomic, strong) IBOutlet UIView *pictureView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UITextField *costTxtFld;
@property (nonatomic, strong) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, strong) IBOutlet UITextField *sbjTxtFld;
@property (nonatomic, strong) IBOutlet UIButton *editBtn;
@property (nonatomic, strong) IBOutlet UILabel *typeLbl;
@property (nonatomic, strong) IBOutlet UILabel *categoryLbl;
@property (nonatomic, strong) Order *order;
@property (nonatomic, strong) NSData *jsonData;


-(IBAction)addOrder:(UIButton *)sender;
-(IBAction)dismissKeyboard:(UIBarButtonItem *)sender;

@end
