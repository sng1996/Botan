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
    cell.endDateLabel.text = order.date;
    cell.beginDateLabel.text = order.dateOrder;
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
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /*if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }*/
    
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    /*mainDelegate.currentOrder = [arrForTable objectAtIndex:(NSInteger)indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GetOrderViewController *getOrderViewController =  (GetOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"getOrderViewController"];
    [self presentViewController:getOrderViewController animated:YES completion:nil];*/
    
}


-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    mainDelegate.viewWidth = self.view.frame.size.width;
    arrForTable = [[NSMutableArray alloc] init];
    Order *order = [[Order alloc] init];
    order.subject = @"Аналитическая геометрия";
    order.type = 0;
    order.date = @"Завтра, 19:00";
    order.dateOrder = @"03.01";
    order.cost = 1500;
    [arrForTable addObject:order];
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
            order.customer = [[Person alloc] init];
            order.performer = [[Person alloc] init];
            order._id = [[obj objectForKey:@"id"] integerValue];
            NSLog(@"order._id = %d", order._id);
            order.category = [[obj objectForKey:@"category"] integerValue];
            order.foto = NULL;
            order.description = [obj objectForKey:@"description"];
            order.cost = [[obj objectForKey:@"cost"] integerValue];
            order.date = [obj objectForKey:@"end_date"];
            order.customer._id = [[obj objectForKey:@"client"] integerValue];
            NSLog(@"order.customer._id = %d", order.customer._id);
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
    /*NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/get_all_orders"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
    [mainTableView reloadData];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
