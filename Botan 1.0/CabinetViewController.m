//
//  CabinetViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 11.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "CabinetViewController.h"

@interface CabinetViewController ()

@end

@implementation CabinetViewController
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
    
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
