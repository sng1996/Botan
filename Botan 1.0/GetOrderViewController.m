//
//  GetOrderViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "GetOrderViewController.h"
#import "AddOrderViewController.h"
#import "TalkingViewController.h"
#import "MainViewController.h"
#import "ChooseExecutorViewController.h"

@interface GetOrderViewController ()

@end

@implementation GetOrderViewController
@synthesize taskImage, headLabel, rightBtn, leftBtn, centerBtn, infoLabel, nickLabel, profileView, descriptionTextView, descriptionView, costLabel, categoryLabel, typeLabel, beginLabel, endLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/profile/?id=%ld", (long)mainDelegate.currentOrder.customer._id];
    NSLog(@"current order id = %d", mainDelegate.currentOrder._id);
    [self sendToServer:url];

    
    if (mainDelegate.currentOrder.customer._id == mainDelegate.currentUser._id){
        [rightBtn setTitle:@"Удалить" forState:UIControlStateNormal];
        [leftBtn setTitle:@"Редактировать" forState:UIControlStateNormal];
        if (mainDelegate.currentOrder.performer._id > 0){
            [centerBtn setTitle:@"чат" forState:UIControlStateNormal];
            [centerBtn setTag:3];
        }else{
            [centerBtn setTitle:@"выбор" forState:UIControlStateNormal];
            [centerBtn setTag:7];
        }
        [rightBtn setTag:1];
        [leftBtn setTag:2];
    }else{
    
        if (mainDelegate.currentOrder.performer._id == mainDelegate.currentUser._id){
            [rightBtn setTitle:@"Чат" forState:UIControlStateNormal];
            [leftBtn setTitle:@"Завершить" forState:UIControlStateNormal];
            centerBtn.hidden = YES;
            [rightBtn setTag:3];
            [leftBtn setTag:4];
        }else{
            [rightBtn setTitle:@"Взять" forState:UIControlStateNormal];
            [leftBtn setTitle:@"Новая цена" forState:UIControlStateNormal];
            centerBtn.hidden = YES;
            [rightBtn setTag:5];
            [leftBtn setTag:6];
        }
        
    }
    
    headLabel.text = mainDelegate.currentOrder.subject;
    costLabel.text = [NSString stringWithFormat:@"%ld руб.", (long)mainDelegate.currentOrder.cost];
    categoryLabel.text = [mainDelegate.science objectAtIndex: mainDelegate.currentOrder.category];
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
    
    NSString *url;
    UIStoryboard *mainStoryboard;
    AddOrderViewController *addOrderViewController;
    TalkingViewController *talkingViewController;
    ChooseExecutorViewController *chooseExecutorViewController;
    NSDateFormatter *dateFormatter;
    NSString *strDate;
    UIAlertController * alertController;
    
    switch(sender.tag){
        case 1://удалить заказ
            
            url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/remove/?id=%ld", (long)mainDelegate.currentOrder._id];
            [self sendToServer:url];
            break;
            
        case 2: //редактировать заказ
            
            mainDelegate.isEdit = YES;
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            addOrderViewController =  (AddOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"addOrderViewController"];
            [self presentViewController:addOrderViewController animated:YES completion:nil];
            break;
            
        case 3: //чат
            
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            talkingViewController =  (TalkingViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"talkingViewController"];
            [self presentViewController:talkingViewController animated:YES completion:nil];
            break;
            
        case 4: //завершить
            
            url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/change_status/?id=%ld&status=%ld", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentOrder.status];
            [self sendToServer:url];
            break;
            
        case 5: //взять
            
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
            url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/take/?id=%ld&executor=%ld&cost=%ld&date=%@", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentUser._id, (long)mainDelegate.currentOrder.cost, strDate];
            [self sendToServer:url];
            break;
            
        case 7: // выбрать исполнителя
            NSLog(@"current order id = %d", mainDelegate.currentOrder._id);
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            chooseExecutorViewController =  (ChooseExecutorViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"chooseExecutorViewController"];
            [self presentViewController:chooseExecutorViewController animated:YES completion:nil];
            break;
            
        case 6: //предложить свою цену
            
            alertController = [UIAlertController alertControllerWithTitle: @""
                                                                  message: @"Введите новую цену"
                                                           preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"цена, руб.";
                textField.textColor = [UIColor blackColor];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
                NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/take/?id=%ld&executor=%ld&cost=%ld&date=%@", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentUser._id, (long)alertController.textFields[0].text, strDate];
                [self sendToServer:url];
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
            
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
    
    NSInteger code = [[responseDic objectForKey:@"code"] integerValue];
    NSLog(@"code = %d", code);
    UIStoryboard *mainStoryboard;
    MainViewController *mainViewController;
    
    switch (code){
            
        case 101: // заказ успешно удален
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
        case 102: // заказ успешно сменил статус
            mainDelegate.currentOrder.status = 2;
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
        case 103: // готов выполнить заказ
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
        case 106: // успешно получен профиль пользователя
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
            break;
    }
    
    
}

-(void)sendToServer:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}



@end
