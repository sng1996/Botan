//
//  GetOrderViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "GetOrderViewController.h"

@interface GetOrderViewController ()

@end

@implementation GetOrderViewController
@synthesize taskImage, headLabel, rightBtn, leftBtn, infoLabel, nickLabel, profileView, descriptionTextView, descriptionView, costLabel, categoryLabel, typeLabel, beginLabel, endLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    NSLog(@"id = %ld", (long)mainDelegate.currentOrder.customer._id);
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/profile/?id=%ld", (long)mainDelegate.currentOrder.customer._id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
    if (mainDelegate.currentOrder.customer._id == mainDelegate.currentUser._id){
        [rightBtn setTitle:@"Удалить" forState:UIControlStateNormal];
        [leftBtn setTitle:@"Редактировать" forState:UIControlStateNormal];
        [rightBtn setTag:1];
        [leftBtn setTag:2];
    }else{
    
        if (mainDelegate.currentOrder.performer._id == mainDelegate.currentUser._id){
            [rightBtn setTitle:@"Чат" forState:UIControlStateNormal];
            [leftBtn setTitle:@"Завершить" forState:UIControlStateNormal];
            [rightBtn setTag:3];
            [leftBtn setTag:4];
        }else{
            [rightBtn setTitle:@"Взять" forState:UIControlStateNormal];
            [leftBtn setTitle:@"Новая цена" forState:UIControlStateNormal];
            [rightBtn setTag:5];
            [leftBtn setTag:6];
        }
        
    }
    
    headLabel.text = mainDelegate.currentOrder.subject;
    costLabel.text = [NSString stringWithFormat:@"%ld руб.", (long)mainDelegate.currentOrder.cost];
    categoryLabel.text = [mainDelegate.categories objectAtIndex: mainDelegate.currentOrder.category];
    typeLabel.text = [mainDelegate.types objectAtIndex: mainDelegate.currentOrder.type];
    beginLabel.text = mainDelegate.currentOrder.dateOrder;
    endLabel.text = mainDelegate.currentOrder.date;
    descriptionTextView.text = mainDelegate.currentOrder.description;
    nickLabel.text = mainDelegate.currentOrder.customer.name;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)pressButton:(UIButton *)sender{
    
    switch(sender.tag){
        case 1:
            //удалить заказ
        case 2:
            //редактировать
        case 3:
            //чат
        case 4:
            //завершить
        case 5:
            //Взять
        case 6:
            //Новая цена
        default: ;
    }
    
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
        NSDictionary *dict = [responseDic objectForKey:@"response"];
            Person *person = [[Person alloc] init];
            person._id = [[dict objectForKey:@"id"] integerValue];
            person.email = [dict objectForKey:@"email"];
            person.phone = [dict objectForKey:@"phone"];
            person.name = [dict objectForKey:@"name"];
            person.rating = [[dict objectForKey:@"rating"] integerValue];
            person.photo = [dict objectForKey:@"photo"];
            person.balance = [[dict objectForKey:@"balance"] integerValue];
            person.password = [dict objectForKey:@"password"];
            mainDelegate.currentOrder.customer = person;
    }
    
}


@end
