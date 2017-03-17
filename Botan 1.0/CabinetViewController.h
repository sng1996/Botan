//
//  CabinetViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 11.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SiteCell.h"

@interface CabinetViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITableView *mainTableView;
    NSMutableArray *arrForTable;
    
}

@property (nonatomic, strong) IBOutlet UITableView *mainTableView;

@end
