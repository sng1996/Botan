//
//  ChooseDateViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 20.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChooseDateViewController : UIViewController{
    AppDelegate *mainDelegate;
    UIDatePicker *datePicker;
}

@property (nonatomic, strong) AppDelegate *mainDelegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

-(IBAction)chooseDate:(UIButton *)sender;

@end
