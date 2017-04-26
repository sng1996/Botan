//
//  PerformerViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformerCell.h"
#import "Performer.h"
#import "AppDelegate.h"

@interface PerformerViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    
    IBOutlet UITableView *mainTableView;
    
    NSMutableArray *performersArr;
    NSData *jsonData;
    
    
}

@property (nonatomic, strong) IBOutlet UITableView *mainTableView;

@end
