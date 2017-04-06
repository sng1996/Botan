//
//  ChooseFilterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 06.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ChooseFilterViewController.h"

@interface ChooseFilterViewController ()

@end

@implementation ChooseFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mainDelegate.currentFilterArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    
    FilterCell *cell = (FilterCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[FilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    
    cell.label.text = [mainDelegate.currentFilterArray objectAtIndex:row];
    
    cell.accessoryType = UITableViewCellStyleDefault;
    
    if(mainDelegate.currentFilterObject == 0){
        if (row == mainDelegate.filter.science){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    else{
        if (row == mainDelegate.filter.type){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    if (mainDelegate.currentFilterObject == 0){
        mainDelegate.filter.science = row;
    }
    else{
        mainDelegate.filter.type = row;
    }
    
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
     FilterViewController *filterViewController =  (FilterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"filterViewController"];
     [self presentViewController:filterViewController animated:YES completion:nil];
    
}


-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}


@end
