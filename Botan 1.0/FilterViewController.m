//
//  FilterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize applyButton, cancelBtn, scienceBtn, typeBtn, dateAddBtn, costBtn, timeBtn, scienceLbl, typeLbl, minTxtFld, maxTxtFld, dateAddImg, costImg, timeImg, scrollView, switchBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    //init array of images for buttons
    arrOfImg = [[NSMutableArray alloc] init];
    [arrOfImg addObject:dateAddImg];
    [arrOfImg addObject:costImg];
    [arrOfImg addObject:timeImg];
    for (int i = 0; i < 3; i++){
        ((UIImageView *)[arrOfImg objectAtIndex:i]).hidden = YES;
    }
    
    //init content for all buttons
    [self initWithData];
    
    //init view above keyboard
    aboveKeyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    aboveKeyboardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aboveKeyboardView];
    
    //init button for that view
    UIButton *downKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 0, 70, 50)];
    downKeyboardBtn.backgroundColor = [UIColor whiteColor];
    [downKeyboardBtn setTitle:@"Done" forState:UIControlStateNormal];
    [downKeyboardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downKeyboardBtn addTarget:self action:@selector(downKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [aboveKeyboardView addSubview:downKeyboardBtn];
    
    //init notifications for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [self initWithData];
    
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == minTxtFld){
        mainDelegate.filter.minCost = [textField.text integerValue];
    }
    else{
        mainDelegate.filter.maxCost = [textField.text integerValue];
    }
    
}


- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
 
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    aboveKeyboardView.frame = CGRectMake(0, self.view.frame.size.height - keyboardFrameBeginRect.size.height - 50, self.view.frame.size.width, 50);
    scrollView.contentOffset = (CGPoint){0,200};
    
    [UIView commitAnimations];
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    aboveKeyboardView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
    scrollView.contentOffset = (CGPoint){0,0};
    
    [UIView commitAnimations];
    
}

-(IBAction)downKeyboard:(UIButton *)sender{
    
    [minTxtFld resignFirstResponder];
    [maxTxtFld resignFirstResponder];
    
}

-(IBAction)cancel:(UIButton *)sender{
    
    [self initWithZero];
    [self initWithData];
    
}

-(IBAction)apply:(UIButton *)sender{
    
    mainDelegate.lastFilter = [mainDelegate.filter copy];
    [self performSegueWithIdentifier:@"unwindToMain" sender:self];
    
}

-(IBAction)back:(UIButton *)sender{
    
    [self initWithZero];
    [self performSegueWithIdentifier:@"unwindToMain" sender:self];
    
}

-(void)initWithZero{
    
    mainDelegate.filter.science = 0;
    mainDelegate.filter.type = 0;
    mainDelegate.filter.sort = 0;
    for (int i = 0; i < 3; i++){
        ((UIImageView *)[arrOfImg objectAtIndex:i]).hidden = YES;
    }
    mainDelegate.filter.sortSubject = 0;
    mainDelegate.filter.minCost = 0;
    mainDelegate.filter.maxCost = 0;
    
}

-(void)initWithData{
    
    scienceLbl.text = [mainDelegate.science objectAtIndex:mainDelegate.filter.science];
    typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.filter.type];
    switchBtn.on = mainDelegate.filter.sort;
    ((UIImageView *)[arrOfImg objectAtIndex:mainDelegate.filter.sortSubject]).hidden = NO;
    minTxtFld.text = [NSString stringWithFormat:@"%ld", mainDelegate.filter.minCost];
    maxTxtFld.text = [NSString stringWithFormat:@"%ld", mainDelegate.filter.maxCost];
    
}


@end
