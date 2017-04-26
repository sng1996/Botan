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
    
    
    Order *order = [arrForTable objectAtIndex:row];
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", [mainDelegate.types objectAtIndex:order.type]];
    cell.subjectLabel.text = order.subject;
    cell.endDateLabel.text = order.endDate;
    cell.beginDateLabel.text = order.beginDate;
    cell.costLabel.text = [NSString stringWithFormat:@"%ld", (long)order.cost];
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    
    cell.accessoryType = UITableViewCellStyleDefault;
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:104/255.0f green:202/255.0f blue:255/255.0f alpha:0.2f];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 0;
    cell.clipsToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    mainDelegate.currentOrder = [arrForTable objectAtIndex:(NSInteger)indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GetOrderViewController *getOrderViewController =  (GetOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"getOrderViewController"];
    [self presentViewController:getOrderViewController animated:YES completion:nil];
    
}


-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    mainDelegate.viewWidth = self.view.frame.size.width;
    arrForTable = [[NSMutableArray alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/get_all_orders"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    jsonData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [mainDelegate.orders removeAllObjects];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSArray *array = [responseDic objectForKey:@"response"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            Order *order = [[Order alloc] init];
            order.customer = [[Person alloc] init];
            order.performer = [[Person alloc] init];
            order._id = [[obj objectForKey:@"id"] integerValue];
            order.science = [[obj objectForKey:@"category"] integerValue];
            order.foto = NULL;
            order.description = [obj objectForKey:@"description"];
            order.cost = [[obj objectForKey:@"cost"] integerValue];
            order.endDate = [obj objectForKey:@"end_date"];
            order.customer._id = [[obj objectForKey:@"client"] integerValue];
            order.performer._id = [[obj objectForKey:@"executor"] integerValue];
            order.beginDate = [obj objectForKey:@"create_date"];
            order.type = [[obj objectForKey:@"type"] integerValue];
            order.subject = [obj objectForKey:@"subject"];
            [mainDelegate.orders addObject:order];
        }];
        
    }
    arrForTable = [mainDelegate.orders mutableCopy];
    [mainTableView reloadData];
    
    
}

-(IBAction)deleteFilter:(UIButton *)sender{
    [mainDelegate.arrOfResult replaceObjectAtIndex:sender.tag withObject:@""];
    sender.hidden = YES;
}


-(void)viewDidAppear:(BOOL)animated{
    
    arrForTable = [mainDelegate.orders mutableCopy];
    
    if (mainDelegate.lastFilter.type != 0){
        for (int i = 0; i < [arrForTable count]; i++){
            if(!(((Order *)[arrForTable objectAtIndex:i]).type == mainDelegate.lastFilter.type)){
                [arrForTable removeObjectAtIndex:i];
            }
        }
    }
    if (mainDelegate.lastFilter.science != 0){
        for (int i = 0; i < [arrForTable count]; i++){
            if(!(((Order *)[arrForTable objectAtIndex:i]).science == mainDelegate.lastFilter.science)){
                [arrForTable removeObjectAtIndex:i];
            }
        }
    }
    if (mainDelegate.lastFilter.maxCost != 0){
        for (int i = 0; i < [arrForTable count]; i++){
            if((((Order *)[arrForTable objectAtIndex:i]).cost < mainDelegate.lastFilter.minCost) || (((Order *)[arrForTable objectAtIndex:i]).cost > mainDelegate.lastFilter.maxCost)){
                [arrForTable removeObjectAtIndex:i];
            }
        }
    }
    switch (mainDelegate.lastFilter.sortSubject) {
        case 0:
            arrForTable = (NSMutableArray *)[arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"beginDate" ascending: !mainDelegate.lastFilter.sort]]];
            break;
        case 1:
            arrForTable = (NSMutableArray *)[arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"cost" ascending: !mainDelegate.lastFilter.sort]]];
            break;
        default:
            arrForTable = (NSMutableArray *)[arrForTable sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"endDate" ascending: !mainDelegate.lastFilter.sort]]];
            break;
    }
    
    
    [mainTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)goToFilter:(UIButton *)sender{
    
    mainDelegate.filter = [mainDelegate.lastFilter copy];
    
}

-(IBAction)update:(id)sender{
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/get_all_orders"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(IBAction)quit:(UIButton *)sender{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EnterViewController *enterViewController =  (EnterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"enterViewController"];
    [self presentViewController:enterViewController animated:YES completion:nil];
    
}

@end
