//
//  ChooseCategoryViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChooseCategoryViewController : UIViewController{
    AppDelegate *mainDelegate;
}

@property (nonatomic, strong) AppDelegate *mainDelegate;

@end
