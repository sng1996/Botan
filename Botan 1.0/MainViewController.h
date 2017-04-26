//
//  MainViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EnterViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSCopying>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITableView *mainTableView;
    IBOutlet UIBarButtonItem *barButtonItemLeft;
    
    NSMutableArray *arrForTable;
    
    NSData *jsonData;
    

}

@property (nonatomic, strong) AppDelegate *mainDelegate;
@property (nonatomic, strong) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) IBOutlet UIButton *buttonAddOrder;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *barButtonItemLeft;



@end
