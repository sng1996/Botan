//
//  PerformerViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "PerformerViewController.h"

@interface PerformerViewController ()

@end

@implementation PerformerViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    performersArr = [[NSMutableArray alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/person/get_performers/?id=%ld", mainDelegate.currentOrder._id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [performersArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIdentifier = @"Cell";
    
    PerformerCell *cell = (PerformerCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[PerformerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    
    
    Performer *performer = [performersArr objectAtIndex:row];
    cell.avatarLbl.text = performer.name;
    cell.avatarView.backgroundColor = performer.color;
    cell.nameLbl.text = performer.name;
    cell.costLbl.text = [NSString stringWithFormat:@"%ld", performer.cost];
    cell.dateLbl.text = performer.date;
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
    NSInteger row = indexPath.row;
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/set_executor/?id_order=%ld&id_executor=%ld", mainDelegate.currentOrder._id, ((Performer *)[performersArr objectAtIndex:row])._id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    jsonData = data;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSInteger code = [[responseDic objectForKey:@"code"] intValue];
    
    switch(code){
            
        case 108:
            [self performSegueWithIdentifier:@"unwindToGetOrder" sender:self];
            break;
            
            
        case 107:
            [performersArr removeAllObjects];
            if ([NSJSONSerialization isValidJSONObject:responseDic])
            {
                NSArray *array = [responseDic objectForKey:@"response"];
                [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                    Performer *performer = [[Performer alloc] init];
                    performer._id = [[obj objectForKey:@"id"] integerValue];
                    performer.name = [obj objectForKey:@"name"];
                    performer.cost = [[obj objectForKey:@"cost"] integerValue];
                    performer.date = [obj objectForKey:@"date"];
                    performer.rating = [[obj objectForKey:@"rating"] integerValue];
                    //performer.color = generate color;
                    [performersArr addObject:performer];
                }];
            }
            [mainTableView reloadData];
            break;
    }
    

}

-(IBAction)back:(UIButton *)sender{
    [self performSegueWithIdentifier:@"unwindToGetOrder" sender:self];
}


@end
