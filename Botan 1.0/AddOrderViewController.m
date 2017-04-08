//
//  AddOrderViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "AddOrderViewController.h"
#import "TabController.h"
#import "Order.h"
#import "JSON/SBJson.h"
#import "ImageButton.h"
#import "MainViewController.h"

@interface AddOrderViewController ()

@end

@implementation AddOrderViewController
@synthesize datePicker, costTxtFld, descriptionTxtView, subjectTxtFld, typeLbl, scienceLbl, dateLbl, scroller, mainScroller, descriptionView;

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (mainDelegate.isEdit){
        mainDelegate.isEdit = NO;
        
        scienceLbl.text = [mainDelegate.science objectAtIndex:mainDelegate.currentOrder.science];
        typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.currentOrder.type];
        subjectTxtFld.text = mainDelegate.currentOrder.subject;
        dateLbl.text = mainDelegate.currentOrder.endDate;
        costTxtFld.text = [NSString stringWithFormat:@"%ld", mainDelegate.currentOrder.cost];
        descriptionTxtView.text = mainDelegate.currentOrder.description;
        
    }
    
    //init view above keyboard
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 40)];
    [btn setTitle:@"Убрать" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor whiteColor]];
    [view setBackgroundColor: [UIColor colorWithRed:210.0f/255.0f green:213.0/255.0f blue:219.0/255.0f alpha:1]];
    [view addSubview:btn];
    costTxtFld.inputAccessoryView = view;
    descriptionTxtView.inputAccessoryView = view;
    subjectTxtFld.inputAccessoryView = view;
    subjectTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    descriptionTxtView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //init photo scrollview
    photoButtons = [[NSMutableArray alloc] init];
    
    scroller.pagingEnabled = NO;
    scroller.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 4; i++){
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(16 + i*76, 0, 60, 60)];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(addPhoto:) forControlEvents: UIControlEventTouchUpInside];
        [scroller addSubview:button];
        [photoButtons addObject:button];
        
        UIButton *smButton = [[UIButton alloc] initWithFrame:CGRectMake(button.frame.origin.x + 18, 20, 24, 20)];
        [smButton setBackgroundImage:[UIImage imageNamed:@"photo.tiff"] forState:UIControlStateNormal];
        [smButton addTarget:self action:@selector(addPhoto:) forControlEvents: UIControlEventTouchUpInside];
        [scroller addSubview:smButton];
        [photoButtons addObject:smButton];
        
    }
    
    scroller.contentSize = CGSizeMake((photoButtons.count/2)*76 + 16, scroller.frame.size.height);
    
    dateView.frame = CGRectMake(0, 568, dateView.frame.size.width, dateView.frame.size.height);
    
    descriptionTxtView.scrollEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(keyPressed:)
                                                 name: UITextViewTextDidChangeNotification
                                               object: nil];


}

-(void)viewDidAppear:(BOOL)animated{
    
    scienceLbl.text = [mainDelegate.science objectAtIndex:mainDelegate.currentOrder.science];
    typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.currentOrder.type];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)addOrder:(UIBarButtonItem *)sender{
    
    [mainDelegate.orders addObject:mainDelegate.currentOrder];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInteger: mainDelegate.currentOrder._id], @"id",
                          [NSNumber numberWithInteger: order.cost], @"cost",
                          order.endDate, @"date",
                          order.subject, @"subject",
                          [NSNumber numberWithInteger: order.type], @"type",
                          [NSNumber numberWithInteger: order.science], @"category",
                          order.description, @"description",
                          [NSNumber numberWithInteger: order.status], @"status",
                          [NSNumber numberWithInteger: order.customer._id], @"client", nil];
    
    NSString *url;
    
    if (mainDelegate.isEdit){
        url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/edit"];
    }else{
        url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/create"];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL
                                                                        URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    NSError *error;
    if ([NSJSONSerialization isValidJSONObject:dict]){
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:jsonData];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (connection){
            NSLog(@"OK");
        }else{
            NSLog(@"ERROR");
        }
    }else{
        NSLog(@"ERROR!!!!!!!!!!!!!!!");
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    jsonData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSLog(@"code = %@", [responseDic objectForKey:@"code"]);
    }
    
    NSInteger code = [[responseDic objectForKey:@"code"] intValue];
    UIAlertController *alert;
    
    
    switch (code){
            
        case 104: //заказ успешно добавлен
            alert = [UIAlertController alertControllerWithTitle:@"" message:@"Заказ успешно добавлен" preferredStyle:UIAlertControllerStyleAlert];
            break;
        
        case 105: //заказ успешно отредактирован
            alert = [UIAlertController alertControllerWithTitle:@"" message:@"Заказ успешно отредактирован" preferredStyle:UIAlertControllerStyleAlert];
            break;
    }
    
    if (alert != NULL){
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                 MainViewController *mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
                                 [self presentViewController:mainViewController animated:YES completion:nil];
                                 
                             }];
        
        [alert addAction: ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    mainScroller.contentOffset = (CGPoint){0, 309};
    [UIView commitAnimations];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    mainScroller.contentOffset = (CGPoint){0,0};
    [UIView commitAnimations];
}


-(IBAction)dismissKeyboard:(UIButton *)sender{
    
    [costTxtFld resignFirstResponder];
    [descriptionTxtView resignFirstResponder];
    [subjectTxtFld resignFirstResponder];
}

-(IBAction)choose:(UIButton *)sender{
    
    mainDelegate.currentFilterObject = sender.tag;
    if (sender.tag == 3)
        mainDelegate.currentFilterArray = mainDelegate.types;
    else{
        mainDelegate.currentFilterArray = mainDelegate.science;
    }
    
}

-(IBAction)showDatePicker:(UIButton *)sender{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2f];
    
    dateView.frame = CGRectMake(0, 321, dateView.frame.size.width, dateView.frame.size.height);
    
    [UIView commitAnimations];
    
}

-(IBAction)setDate:(UIButton *)sender{
    
    NSDate *date = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
    mainDelegate.currentOrder.endDate = strDate;
    dateLbl.text = strDate;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2f];
    
    dateView.frame = CGRectMake(0, 568, dateView.frame.size.width, dateView.frame.size.height);
    
    [UIView commitAnimations];

}

-(IBAction)keyPressed:(id)sender{
    
    CGSize newSize = [descriptionTxtView.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14] constrainedToSize:CGSizeMake(255,9999) lineBreakMode:UILineBreakModeWordWrap];
    NSInteger newSizeH = newSize.height;
    NSInteger newSizeW = newSize.width;
    
    
    if (descriptionTxtView.hasText)
    {
        if (newSizeH <= 200)
        {
            [descriptionTxtView scrollRectToVisible:CGRectMake(0,0,1,1) animated:NO];
            CGRect descriptionBoxFrame = descriptionTxtView.frame;
            NSInteger descriptionBoxH = descriptionBoxFrame.size.height;
            NSInteger descriptionBoxW = descriptionBoxFrame.size.width;
            descriptionBoxFrame.size.height = newSizeH + 23;
            descriptionTxtView.frame = descriptionBoxFrame;
            
            CGRect formFrame = descriptionView.frame;
            NSInteger viewFormH = formFrame.size.height;
            formFrame.size.height = 30 + newSizeH;
            //formFrame.origin.y = 199 - (newSizeH - 18);
            descriptionView.frame = formFrame;
        }
        if (newSizeH > 200)
        {
            descriptionTxtView.scrollEnabled = YES;
        }
    }

    
}

@end
