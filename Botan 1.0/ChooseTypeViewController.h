//
//  ChooseTypeViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChooseTypeViewController : UIViewController {
    AppDelegate *mainDelegate;
}

@property (nonatomic, strong) AppDelegate *mainDelegate;

@end
