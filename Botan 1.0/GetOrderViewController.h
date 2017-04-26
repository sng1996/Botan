//
//  GetOrderViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PerformerViewController.h"

@interface GetOrderViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UILabel *typeLbl;
    IBOutlet UILabel *beginDateLbl;
    IBOutlet UILabel *endDateLbl;
    IBOutlet UILabel *costLbl;
    IBOutlet UILabel *descriptionLbl;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scroller;

    NSInteger currentStatus;
    NSMutableArray *imagesArray;
}

@property (nonatomic, strong) IBOutlet UILabel *typeLbl;
@property (nonatomic, strong) IBOutlet UILabel *beginDateLbl;
@property (nonatomic, strong) IBOutlet UILabel *endDateLbl;
@property (nonatomic, strong) IBOutlet UILabel *costLbl;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLbl;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;



@end
