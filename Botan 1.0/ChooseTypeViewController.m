//
//  ChooseTypeViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ChooseTypeViewController.h"

@interface ChooseTypeViewController ()

@end

@implementation ChooseTypeViewController
@synthesize mainDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

-(IBAction)chooseType:(UIButton *)sender{
    
    mainDelegate.type = sender.tag;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}


@end
