//
//  MainViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "MainViewController.h"
#import "SiteCell.h"
#import "GetOrderViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize mainTableView, barButtonItemLeft, mainDelegate;

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
    
    Order *order = [arrForTable objectAtIndex:row];
    cell.typeLabel.text = [NSString stringWithFormat:@"#%@ #%@", [mainDelegate.types objectAtIndex:order.type], [mainDelegate.types objectAtIndex:order.category]];
    cell.subjectLabel.text = order.subject;
    cell.descriptLabel.text = order.description;
    cell.dateLabel.text = order.date;
    cell.costLabel.text = [NSString stringWithFormat:@"%ld", (long)order.cost];
    
    
    cell.accessoryType = UITableViewCellStyleDefault;
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:104/255.0f green:202/255.0f blue:255/255.0f alpha:0.2f];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 0;
    cell.clipsToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    mainDelegate.currentOrder = [arrForTable objectAtIndex:(NSInteger)indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GetOrderViewController *getOrderViewController =  (GetOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"getOrderViewController"];
    [self presentViewController:getOrderViewController animated:YES completion:nil];
    
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/get_all_orders"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    mainDelegate.jsonData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [mainDelegate.orders removeAllObjects];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:mainDelegate.jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSArray *array = [responseDic objectForKey:@"response"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            Order *order = [[Order alloc] init];
            order._id = [[obj objectForKey:@"id"] integerValue];
            order.category = [[obj objectForKey:@"category"] integerValue];
            order.foto = NULL;
            order.description = [obj objectForKey:@"description"];
            order.cost = [[obj objectForKey:@"cost"] integerValue];
            order.date = [obj objectForKey:@"end_date"];
            order.customer._id = [[obj objectForKey:@"client"] integerValue];
            order.performer._id = [[obj objectForKey:@"executor"] integerValue];
            order.dateOrder = [obj objectForKey:@"create_date"];
            order.type = [[obj objectForKey:@"type"] integerValue];
            order.subject = [obj objectForKey:@"subject"];
            [mainDelegate.orders addObject:order];
        }];
        
    }
    arrForTable = [mainDelegate.orders mutableCopy];
    [mainTableView reloadData];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    arrForTable = [mainDelegate.orders mutableCopy];
    if (![[mainDelegate.arrOfResult objectAtIndex:1] isEqualToString:@""]){
        for (int i = 0; i < [arrForTable count]; i++){
            if(!(((Order *)[arrForTable objectAtIndex:i]).type == [[mainDelegate.arrOfResult objectAtIndex:1] integerValue])){
                [arrForTable removeObjectAtIndex:i];
            }
        }
    }
    if (![[mainDelegate.arrOfResult objectAtIndex:2] isEqualToString:@""]){
        for (int i = 0; i < [arrForTable count]; i++){
            if(!(((Order *)[arrForTable objectAtIndex:i]).category == [[mainDelegate.arrOfResult objectAtIndex:2] integerValue])){
                [arrForTable removeObjectAtIndex:i];
            }
        }
    }
    if ([[mainDelegate.arrOfResult objectAtIndex:0] isEqualToString:@"Сначала дешевые"]){
        arrForTable = [arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"cost" ascending: true]]];
    }
    if ([[mainDelegate.arrOfResult objectAtIndex:0] isEqualToString:@"Сначала дорогие"]){
        arrForTable = [arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"cost" ascending: false]]];
    }
    if ([[mainDelegate.arrOfResult objectAtIndex:0] isEqualToString:@"Сначала старые"]){
        arrForTable = [arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"dateOrder" ascending: true]]];
    }
    if ([[mainDelegate.arrOfResult objectAtIndex:0] isEqualToString:@"Сначала новые"]){
        arrForTable = [arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"dateOrder" ascending: false]]];
    }
    if ([[mainDelegate.arrOfResult objectAtIndex:0] isEqualToString:@"Сначала срочные"]){
        arrForTable = [arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending: true]]];
    }
    [mainTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
