//
//  RegisterViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 05.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController{
    
    IBOutlet AppDelegate *mainDelegate;
    IBOutlet UITextField *loginTextField;
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *passwordTextField;
    NSData *jsonData;
    
}

@property (nonatomic, strong) IBOutlet UITextField *loginTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

- (IBAction)register:(UIButton *)sender;

@end
