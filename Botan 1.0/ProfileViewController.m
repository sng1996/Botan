//
//  ProfileViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 11.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ProfileViewController.h"
#import "EnterViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize  ordersDoneLbl, ratingLbl, balanceLbl, ordersCreateLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/profile/more_info/?id=%ld", (long)mainDelegate.currentOrder.customer._id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)quit:(UIButton *)sender{
    
    mainDelegate.currentUser = NULL;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EnterViewController *enterViewController =  (EnterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"enterViewController"];
    [self presentViewController:enterViewController animated:YES completion:nil];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    mainDelegate.jsonData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:mainDelegate.jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSDictionary *respDict = [responseDic objectForKey:@"response"];
        ordersCreateLbl.text = [respDict objectForKey:@"orders_create"];
        ordersDoneLbl.text = [respDict objectForKey:@"orders_done"];
        ratingLbl.text = [respDict objectForKey:@"rating"];
        
    }
    
}

@end
