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
@synthesize  nickLbl, balanceBtn, balanceLbl, currentWorkBtn, currentOrdersBtn, archiveBtn, reviewsBtn, scroller, pageLineView;

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/profile/more_info/?id=%ld", (long)mainDelegate.currentOrder.customer._id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    
    buttonsArr = [[NSMutableArray alloc] init];
    tablesArr = [[NSMutableArray alloc] init];
    dataArr = [[NSMutableArray alloc] init];
    
    [buttonsArr addObject:currentWorkBtn];
    [buttonsArr addObject:currentOrdersBtn];
    [buttonsArr addObject:archiveBtn];
    [buttonsArr addObject:reviewsBtn];

    
    for(int i = 0; i < 4; i++){
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(i*scroller.frame.size.width, 0, scroller.frame.size.width, scroller.frame.size.height) style:UITableViewStyleGrouped];
        [table setTag:i];
        [scroller addSubview:table];
        [tablesArr addObject:table];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [dataArr addObject:array];
    }
    
    scroller.contentSize = CGSizeMake(4*scroller.frame.size.width, scroller.frame.size.height);
    
    //init labels
    nickLbl.text = mainDelegate.currentUser.name;
    balanceLbl.text = [NSString stringWithFormat:@"%ld", mainDelegate.currentUser.balance];
    for(int i = 0; i < 4; i++){
        
        [[buttonsArr objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%ld", ((NSMutableArray *)[dataArr objectAtIndex:i]).count] forState:UIControlStateNormal];
        
    }

}

-(void)viewDidAppear:(BOOL)animated{
    for(int i = 0; i < 4; i++){
        UIButton *button = [buttonsArr objectAtIndex:i];
        [button.titleLabel setTextColor:[UIColor colorWithRed:148.0f/255.0f green:148.0f/255.0f blue:148.0f/255.0f alpha:1.0f]];
    }
    [((UIButton *)[buttonsArr objectAtIndex:0]).titleLabel setTextColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*-(IBAction)quit:(UIButton *)sender{
    
    mainDelegate.currentUser = NULL;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EnterViewController *enterViewController =  (EnterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"enterViewController"];
    [self presentViewController:enterViewController animated:YES completion:nil];
    
}*/

/*- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
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
    
}*/

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    
    NSLog(@"page = %ld", page);
    
    for(int i = 0; i < 4; i++){
        UIButton *button = [buttonsArr objectAtIndex:i];
        [button.titleLabel setTextColor:[UIColor colorWithRed:148.0f/255.0f green:148.0f/255.0f blue:148.0f/255.0f alpha:1.0f]];
    }
    
    [((UIButton *)[buttonsArr objectAtIndex:page]).titleLabel setTextColor:[UIColor blackColor]];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2f];
    
    pageLineView.frame = CGRectMake(page*pageLineView.frame.size.width, pageLineView.frame.origin.y, pageLineView.frame.size.width, pageLineView.frame.size.height);
    
    [UIView commitAnimations];
    
}

-(IBAction)changePage:(UIButton *)sender{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2f];
    
    scroller.contentOffset = (CGPoint){sender.tag*scroller.frame.size.width, 0};
    
    [UIView commitAnimations];
    
    /*for(int i = 0; i < 4; i++){
        UIButton *button = [buttonsArr objectAtIndex:i];
        if (sender.tag == i){
            NSLog(@"WORLD");
            [button.titleLabel setTextColor:[UIColor redColor]];
        }
        else{
            [button.titleLabel setTextColor:[UIColor colorWithRed:148.0f/255.0f green:148.0f/255.0f blue:148.0f/255.0f alpha:1.0f]];
        }
        
    }*/
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[dataArr objectAtIndex:tableView.tag] count];
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
    ReviewCell *reviewCell;
    SiteCell *siteCell;
    NSInteger row;
    Review *review;
    Order *order;
    
    switch (tableView.tag) {
        case 3:
            reviewCell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if(reviewCell == nil){
                reviewCell = [[ReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            row = indexPath.row;
            
            review = [[dataArr objectAtIndex:3] objectAtIndex:row];
            reviewCell.headLabel.text = [NSString stringWithFormat:@"%@", review.head];
            reviewCell.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", review.name, review.date];;
            reviewCell.textLabel.text = [NSString stringWithFormat:@"%@", review.text];
            [reviewCell setBackgroundColor:[UIColor whiteColor]];
            
            reviewCell.accessoryType = UITableViewCellStyleDefault;
            reviewCell.selectedBackgroundView = [[UIView alloc] init];
            reviewCell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:104/255.0f green:202/255.0f blue:255/255.0f alpha:0.2f];
            reviewCell.backgroundColor = [UIColor whiteColor];
            reviewCell.layer.cornerRadius = 0;
            reviewCell.clipsToBounds = YES;
            
            return reviewCell;
            
        default:
            siteCell = (SiteCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if(siteCell == nil){
                siteCell = [[SiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            row = indexPath.row;
            
            order = [[dataArr objectAtIndex:tableView.tag] objectAtIndex:row];
            siteCell.typeLabel.text = [NSString stringWithFormat:@"%@", [mainDelegate.types objectAtIndex:order.type]];
            siteCell.subjectLabel.text = order.subject;
            siteCell.endDateLabel.text = order.endDate;
            siteCell.beginDateLabel.text = order.beginDate;
            siteCell.costLabel.text = [NSString stringWithFormat:@"%ld", (long)order.cost];
            [siteCell setBackgroundColor:[UIColor whiteColor]];
            
            siteCell.accessoryType = UITableViewCellStyleDefault;
            siteCell.selectedBackgroundView = [[UIView alloc] init];
            siteCell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:104/255.0f green:202/255.0f blue:255/255.0f alpha:0.2f];
            siteCell.backgroundColor = [UIColor whiteColor];
            siteCell.layer.cornerRadius = 0;
            siteCell.clipsToBounds = YES;
            
            return siteCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*mainDelegate.currentOrder = [arrForTable objectAtIndex:(NSInteger)indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GetOrderViewController *getOrderViewController =  (GetOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"getOrderViewController"];
    [self presentViewController:getOrderViewController animated:YES completion:nil];*/
    
}

@end
