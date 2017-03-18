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
@synthesize mainDelegate, order, pictureButton, pictureView, datePicker, costTxtFld, descriptionTextView, sbjTxtFld, editBtn, typeLbl, categoryLbl, jsonData, scrollView, rightBarBtn;

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    if (mainDelegate.isEdit){
        mainDelegate.category = mainDelegate.currentOrder.category;
        mainDelegate.type = mainDelegate.currentOrder.type;
        sbjTxtFld.text = mainDelegate.currentOrder.subject;
        descriptionTextView.text = mainDelegate.currentOrder.description;
        costTxtFld.text = [NSString stringWithFormat:@"%d", mainDelegate.currentOrder.cost];
        /*NSString *dateString = mainDelegate.currentOrder.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        datePicker.date = dateFromString;*/
        
        //строка с датой почему то null
        
        //+photo
        
    }
    categoryLbl.text = [mainDelegate.categories objectAtIndex:mainDelegate.category];
    typeLbl.text = [mainDelegate.types objectAtIndex:mainDelegate.type];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 40)];
    UIButton *btnBottom = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 60, 40)];
    UIButton *btnTop = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitle:@"убрать" forState:UIControlStateNormal];
    [btnBottom setTitle:@"вниз" forState:UIControlStateNormal];
    [btnTop setTitle:@"вверх" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [btnBottom addTarget:self action:@selector(toTheBottom:) forControlEvents:UIControlEventTouchUpInside];
    [btnTop addTarget:self action:@selector(toTheTop:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor whiteColor]];
    [btnBottom setTintColor:[UIColor whiteColor]];
    [btnTop setTintColor:[UIColor whiteColor]];
    [view setBackgroundColor: [UIColor colorWithRed:199.0f/255.0f green:202.0/255.0f blue:208.0/255.0f alpha:1.0]];
    [view addSubview:btn];
    [view addSubview:btnBottom];
    [view addSubview:btnTop];
    costTxtFld.inputAccessoryView = view;
    descriptionTextView.inputAccessoryView = view;
    sbjTxtFld.inputAccessoryView = view;
    costTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    sbjTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    descriptionTextView.autocorrectionType = UITextAutocorrectionTypeNo;
}

-(void)viewDidAppear:(BOOL)animated{
    
    if ([mainDelegate.imageArray count] == 0){
        picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noimage.png"]];
        [picture setFrame:CGRectMake(8, 5, 70, 70)];
        [pictureView addSubview:picture];
    }
    else{
        for (int i = 0; i < [mainDelegate.imageArray count]; i++){
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8 + i*78, 5, 70, 70)];
            [btn setBackgroundImage:((ImageButton *)[mainDelegate.imageArray objectAtIndex:i]).image forState:UIControlStateNormal];
            [btn setTag:i];
            [pictureView addSubview:btn];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)addOrder:(UIBarButtonItem *)sender{
    if ([sender.title isEqualToString:@"Далее"]){
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[datePicker date]]];
    NSString *beginStrDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    order = [[Order alloc] init];
    order.category = mainDelegate.category;
    order.description = descriptionTextView.text;
    order.cost = [costTxtFld.text intValue];
    order.type = mainDelegate.type;
    order.subject = sbjTxtFld.text;
    order.date = strDate;
    order.dateOrder = beginStrDate;
    order.status = 0;
    order.customer = mainDelegate.currentUser;
    [mainDelegate.orders addObject:order];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInteger: mainDelegate.currentOrder._id], @"id",
                          [NSNumber numberWithInteger: order.cost], @"cost",
                          order.date, @"date",
                          order.subject, @"subject",
                          [NSNumber numberWithInteger: order.type], @"type",
                          [NSNumber numberWithInteger: order.category], @"category",
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
        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
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


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    scrollView.contentOffset = (CGPoint){0,CGRectGetMinY(textField.frame)+55};
    [UIView commitAnimations];
    currentTextField = textField.tag;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    scrollView.contentOffset = (CGPoint){0, 0};
    [UIView commitAnimations];
}


- (IBAction)toTheTop:(UIButton *)sender{
    
    if (currentTextField == 3){
        [descriptionTextView becomeFirstResponder];
        return ;
    }
    if (currentTextField == 2){
        [sbjTxtFld becomeFirstResponder];
        return ;
    }

    
}

- (IBAction)toTheBottom:(UIButton *)sender{
    
    if (currentTextField == 1){
        [descriptionTextView becomeFirstResponder];
        return ;
    }
    if (currentTextField == 2){
        [costTxtFld becomeFirstResponder];
        return ;
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView.textColor != [UIColor blackColor]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    scrollView.contentOffset = (CGPoint){0,CGRectGetMinY(textView.frame)+55};
    [UIView commitAnimations];
    currentTextField = textView.tag;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Описание задания";
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    scrollView.contentOffset = (CGPoint){0,0};
    [UIView commitAnimations];
    [rightBarBtn setTitle:@"Далее"];
    
}


-(IBAction)dismissKeyboard:(UIBarButtonItem *)sender{
    
    [costTxtFld resignFirstResponder];
    [descriptionTextView resignFirstResponder];
    [sbjTxtFld resignFirstResponder];
}

@end
