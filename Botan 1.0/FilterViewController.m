//
//  FilterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "FilterViewController.h"
//#import "FilterCell.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize applyButton, cancelBtn, scienceBtn, typeBtn, dateAddBtn, costBtn, timeBtn, scienceLbl, typeLbl, minTxtFld, maxTxtFld, dateAddImg, costImg, timeImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    arrOfImg = [[NSMutableArray alloc] init];
    [arrOfImg addObject:dateAddImg];
    [arrOfImg addObject:costImg];
    [arrOfImg addObject:timeImg];
    for (int i = 0; i < 3; i++){
        ((UIImageView *)[arrOfImg objectAtIndex:i]).hidden = YES;
    }
    scienceLbl.text = [mainDelegate.science objectAtIndex:mainDelegate.filter.science];
    typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.filter.type];
}

-(void)viewDidAppear:(BOOL)animated{
    
    scienceLbl.text = [mainDelegate.science objectAtIndex:mainDelegate.filter.science];
    typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.filter.type];
    
}

-(IBAction)choose:(UIButton *)sender{
    
    mainDelegate.currentFilterObject = sender.tag;
    if (sender.tag == 1)
        mainDelegate.currentFilterArray = mainDelegate.types;
    else{
        mainDelegate.currentFilterArray = mainDelegate.science;
    }
    
}

-(IBAction)switchChange:(UISwitch *)sender{
    
    if(sender.on){
        mainDelegate.filter.sort = 1;
    }
    else{
        mainDelegate.filter.sort = 0;
    }
    
}

-(IBAction)chooseSortType:(UIButton *)sender{
    
    for (int i = 0; i < 3; i++){
        ((UIImageView *)[arrOfImg objectAtIndex:i]).hidden = YES;
    }
    mainDelegate.filter.sortSubject = sender.tag - 2;
    UIImageView *imgView = [arrOfImg objectAtIndex:sender.tag - 2];
    imgView.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}


@end
