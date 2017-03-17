//
//  FilterViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITableView *mainTableView;
    NSArray *filterGroups;
    IBOutlet UIView *upperView;
    IBOutlet UIPickerView *pickerView;
    IBOutlet UIButton *applyButton;
    NSMutableArray *arrayOfFilter;
    NSArray *dataSource;
    NSInteger currentRow;
    
}

@property (nonatomic, strong) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) IBOutlet UIView *upperView;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) IBOutlet UIButton *applyButton;


-(IBAction)apply:(UIButton *)sender;
-(IBAction)deleteFilter:(UIButton *)sender;

@end
