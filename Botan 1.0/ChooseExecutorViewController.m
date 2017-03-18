//
//  ChooseExecutorViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 18.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ChooseExecutorViewController.h"
#import "MainViewController.h"

@interface ChooseExecutorViewController ()

@end

@implementation ChooseExecutorViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    arrForTable = [[NSMutableArray alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/get_executors/?id=%d",mainDelegate.currentOrder._id];
    NSLog(@"current order id = %d", mainDelegate.currentOrder._id);
    [self sendToServer:url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrForTable count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    
    SiteCell *cell = (SiteCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[SiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    
    cell.imageView.frame = CGRectMake(10, 15, 40, 40);
    cell.subjectLabel.frame = CGRectMake(60, 0, self.view.frame.size.width*0.5f, 20);
    cell.typeLabel.frame = CGRectMake(60, 20, self.view.frame.size.width*0.5f, 15);
    cell.descriptLabel.frame = CGRectMake(60, 35, self.view.frame.size.width*0.5f, 30);
    cell.dateLabel.frame = CGRectMake(self.view.frame.size.width*0.5f + 65, 60, self.view.frame.size.width*0.5f - 65, 10);
    cell.costLabel.frame = CGRectMake(self.view.frame.size.width*0.5f + 65, 35, self.view.frame.size.width*0.5f - 65, 20);
    
    cell.typeLabel.textColor = [UIColor blackColor];
    cell.subjectLabel.textColor = [UIColor blackColor];
    cell.dateLabel.textColor = [UIColor blackColor];
    cell.costLabel.textColor = [UIColor blackColor];
    cell.descriptLabel.textColor = [UIColor blackColor];
    
    Person *person = [arrForTable objectAtIndex:row];
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", person.name];
    cell.subjectLabel.text = [NSString stringWithFormat:@"%ld", (long)person.rating];
    cell.costLabel.text = [NSString stringWithFormat:@"%ld", (long)person.cost];
    
    
    cell.accessoryType = UITableViewCellStyleDefault;
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:104/255.0f green:202/255.0f blue:255/255.0f alpha:0.2f];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 0;
    cell.clipsToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    Person *person = [arrForTable objectAtIndex:row];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/set_executor/?id_order=%ld&id_executor%ld", (long)mainDelegate.currentOrder._id, (long)person._id];
    [self sendToServer:url];
    
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
    UIStoryboard *mainStoryboard;
    MainViewController *mainViewController;
    NSString *url;
    
    switch(code){
        case 107: //успешно загружен массив исполнителей
            if ([NSJSONSerialization isValidJSONObject:responseDic])
            {
                NSArray *array = [responseDic objectForKey:@"response"];
                [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
                    NSLog(@"107 array");
                    Person *person = [[Person alloc] init];
                    person._id = [[dict objectForKey:@"id"] integerValue];
                    person.email = [dict objectForKey:@"email"];
                    person.phone = [dict objectForKey:@"phone"];
                    person.name = [dict objectForKey:@"name"];
                    person.rating = [[dict objectForKey:@"rating"] integerValue];
                    person.photo = [dict objectForKey:@"photo"];
                    person.balance = [[dict objectForKey:@"balance"] integerValue];
                    person.password = [dict objectForKey:@"password"];
                    person.cost = [[dict objectForKey:@"cost"] integerValue];
                    person.date = [dict objectForKey:@"date"];
                    [arrForTable addObject:person];
                }];
            }
            [mainTableView reloadData];
            break;
        case 108: //успешно выбран исполнитель
            url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/change_status/?id=%ld&status=1", (long)mainDelegate.currentOrder._id];
            [self sendToServer:url];
            break;
        case 102: //успешно сменил статус
            mainDelegate.currentOrder.status = 1;
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
    }
    
}

-(void)sendToServer:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

@end
