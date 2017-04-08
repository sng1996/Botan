//
//  ProfileViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 11.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ReviewCell.h"
#import "SiteCell.h"
#import "Review.h"

@interface ProfileViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UILabel *nickLbl;
    IBOutlet UIButton *balanceBtn;
    IBOutlet UILabel *balanceLbl;
    IBOutlet UIButton *currentWorkBtn;
    IBOutlet UIButton *currentOrdersBtn;
    IBOutlet UIButton *archiveBtn;
    IBOutlet UIButton *reviewsBtn;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIView *pageLineView;
    
    NSMutableArray *buttonsArr;
    NSMutableArray *tablesArr;
    NSMutableArray *dataArr;
    
}

@property (nonatomic, strong) IBOutlet UILabel *nickLbl;
@property (nonatomic, strong) IBOutlet UIButton *balanceBtn;
@property (nonatomic, strong) IBOutlet UIButton *currentWorkBtn;
@property (nonatomic, strong) IBOutlet UIButton *currentOrdersBtn;
@property (nonatomic, strong) IBOutlet UIButton *archiveBtn;
@property (nonatomic, strong) IBOutlet UIButton *reviewsBtn;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UILabel *balanceLbl;
@property (nonatomic, strong) IBOutlet UIView *pageLineView;




@end
