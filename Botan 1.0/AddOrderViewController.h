//
//  AddOrderViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TabController.h"
#import "Order.h"
#import "JSON/SBJson.h"
#import "MainViewController.h"

@interface AddOrderViewController : UIViewController <UITextViewDelegate, UIScrollViewDelegate, UITextFieldDelegate>{
    
    AppDelegate *mainDelegate;
    Order *order;
    
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextField *costTxtFld;
    IBOutlet UITextView *descriptionTxtView;
    IBOutlet UITextField *subjectTxtFld;
    IBOutlet UILabel *typeLbl;
    IBOutlet UILabel *scienceLbl;
    IBOutlet UILabel *dateLbl;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIScrollView *mainScroller;
    IBOutlet UIView *dateView;
    IBOutlet UIView *descriptionView;
    
    NSData *jsonData;
    NSMutableArray *photoButtons;
    
    NSInteger flag;
    
}

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UITextField *costTxtFld;
@property (nonatomic, strong) IBOutlet UITextView *descriptionTxtView;
@property (nonatomic, strong) IBOutlet UITextField *subjectTxtFld;
@property (nonatomic, strong) IBOutlet UILabel *typeLbl;
@property (nonatomic, strong) IBOutlet UILabel *scienceLbl;
@property (nonatomic, strong) IBOutlet UILabel *dateLbl;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UIScrollView *mainScroller;
@property (nonatomic, strong) IBOutlet UIView *descriptionView;



-(IBAction)addOrder:(UIButton *)sender;
-(IBAction)dismissKeyboard:(UIBarButtonItem *)sender;

@end
