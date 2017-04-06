//
//  ChooseFilterViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 06.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FilterCell.h"
#import "FilterViewController.h"

@interface ChooseFilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITableView *mainTableView;
    
}

@property (nonatomic, strong) IBOutlet UITableView *mainTableView;

@end
