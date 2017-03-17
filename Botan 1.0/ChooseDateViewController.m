//
//  ChooseDateViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 20.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ChooseDateViewController.h"

@interface ChooseDateViewController ()

@end

@implementation ChooseDateViewController
@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)chooseDate:(UIButton *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    mainDelegate.date = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[datePicker date]]];
}

@end
