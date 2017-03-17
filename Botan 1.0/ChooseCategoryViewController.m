//
//  ChooseCategoryViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ChooseCategoryViewController.h"

@interface ChooseCategoryViewController ()

@end

@implementation ChooseCategoryViewController
@synthesize mainDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

-(IBAction)chooseCategory:(UIButton *)sender{
    
    mainDelegate.category = sender.tag;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}



@end
