//
//  ProfileViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 11.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProfileViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    IBOutlet UILabel *ordersDoneLbl;
    IBOutlet UILabel *ratingLbl;
    IBOutlet UILabel *balanceLbl;
    IBOutlet UILabel *ordersCreateLbl;
}

@property (nonatomic, strong) IBOutlet UILabel *ordersDoneLbl;
@property (nonatomic, strong) IBOutlet UILabel *ratingLbl;
@property (nonatomic, strong) IBOutlet UILabel *balanceLbl;
@property (nonatomic, strong) IBOutlet UILabel *ordersCreateLbl;

@end
