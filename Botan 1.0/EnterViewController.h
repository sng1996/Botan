//
//  EnterViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 05.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EnterViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    IBOutlet UITextField *loginTextField;
    IBOutlet UITextField *passwordTextField;
    NSData *jsonData;
}

@property (nonatomic, strong) IBOutlet UITextField *loginTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

- (IBAction)enter:(UIButton *)sender;

@end
