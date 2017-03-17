//
//  EnterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 05.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "EnterViewController.h"
#import "MainViewController.h"
#import "JSON/SBJson.h"

@interface EnterViewController ()

@end

@implementation EnterViewController
@synthesize loginTextField, passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (IBAction)enter:(UIButton *)sender{
    
    NSString *login = loginTextField.text;
    NSString *password = passwordTextField.text;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          login, @"email",
                          password, @"password",nil];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/enter"];
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
    }
    else{
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
    NSLog( @"RESULT IS %@", result);
    
    NSInteger answerCode = [[responseDic objectForKey:@"code"] intValue];
    
    if(answerCode == 0){
        mainDelegate.currentUser._id = [[responseDic objectForKey:@"id"] intValue];
        NSLog(@"currentUserId = %ld", (long)mainDelegate.currentUser._id);
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MainViewController *mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:mainViewController animated:YES completion:nil];
    }
        
    
}

- (IBAction)dismissKeyboard:(UIBarButtonItem *)sender{
    [loginTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}



@end
