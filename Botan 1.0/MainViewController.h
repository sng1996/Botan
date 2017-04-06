//
//  MainViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSCopying>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITableView *mainTableView;
    IBOutlet UIBarButtonItem *barButtonItemLeft;
    IBOutlet NSMutableArray *arrForTable;
    

}

@property (nonatomic, strong) AppDelegate *mainDelegate;
@property (nonatomic, strong) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) IBOutlet UIButton *buttonAddOrder;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *barButtonItemLeft;


-(IBAction)slideView:(UIBarButtonItem *)sender;
-(IBAction)backToChoose:(UIButton *)sender;
-(IBAction)getOrder:(UIButton *)sender;
-(IBAction)changeCost:(UIButton *)sender;


@end
