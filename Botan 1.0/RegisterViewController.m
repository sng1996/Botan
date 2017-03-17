//
//  RegisterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 05.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize  loginTextField, nameTextField, passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(UIButton *)sender{
    
    NSString *login = loginTextField.text;
    NSString *name = nameTextField.text;
    NSString *password = passwordTextField.text;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          login, @"email",
                          name, @"name",
                          password, @"password",nil];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/register"];
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

- (IBAction)dismissKeyboard:(UIBarButtonItem *)sender{
    [loginTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];

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
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MainViewController *mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
        [self presentViewController:mainViewController animated:YES completion:nil];
    }
    
    
}


@end
