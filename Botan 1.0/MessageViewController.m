//
//  MessageViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 14.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize mainTableView;

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
    
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = indexPath.row;

    
    Message *message = [arrForTable objectAtIndex:row];
    cell.nameLbl.text = message.contact_name;
    cell.dateLbl.text = message.date;
    cell.msgLbl.text =  message.message;
    
    
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
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TalkingViewController *talkingViewController =  (TalkingViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"talkingViewController"];
    /*talkingViewController.order_id = ((Message *)[arrForTable objectAtIndex:row]).order_id;*/
    [self.navigationController pushViewController:talkingViewController animated:YES];
    
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    arrForTable = [[NSMutableArray alloc] init];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    /*UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    [navView setBackgroundColor:[UIColor greenColor]];
    [self.navigationController.navigationBar addSubview:navView];*/
    
    UILabel *navTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 200, self.navigationController.navigationBar.frame.size.height)];
    navTitle.text = @"Сообщения";
    navTitle.textColor = [UIColor blackColor];
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.tag = 1;
    [self.navigationController.navigationBar addSubview:navTitle];
    
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/message/get_contacts/?id=%ld", (long)mainDelegate.currentUser._id];
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
    
    [arrForTable removeAllObjects];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSArray *array = [responseDic objectForKey:@"response"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            Message *message = [[Message alloc] init];
            message.order_id = [[obj objectForKey:@"order_id"] integerValue];
            message.is_my = [[obj objectForKey:@"is_my"] boolValue];
            message.message = [obj objectForKey:@"message"];
            message.contact_name = [obj objectForKey:@"name"];
            message.date = [obj objectForKey:@"date"];
            [arrForTable addObject:message];
        }];
        
    }
    [mainTableView reloadData];
    
    
}

@end
