//
//  FilterViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterCell.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize mainTableView, pickerView, upperView, applyButton;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [filterGroups count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    
    FilterCell *cell = (FilterCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[FilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    cell.label.frame = CGRectMake(50, 0, self.view.frame.size.width, 60);
    cell.label.text = [filterGroups objectAtIndex:row];
    
    cell.label2.frame = CGRectMake(50, 40, self.view.frame.size.width, 30);
    cell.label2.text = [mainDelegate.arrOfResult objectAtIndex:row];
    
    if (![[mainDelegate.arrOfResult objectAtIndex:row] isEqualToString:@""]){
        cell.deleteBtn.frame = CGRectMake(0, 0, 50, 70);
        cell.deleteBtn.tag = row;
        cell.deleteBtn.hidden = NO;
        [cell.deleteBtn setTitle:@"del" forState:UIControlStateNormal];
        [cell.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.deleteBtn addTarget:self action:@selector(deleteFilter:) forControlEvents:UIControlEventTouchUpInside];
    }
    
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
    
    dataSource = [arrayOfFilter objectAtIndex:row];
    [pickerView reloadAllComponents];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    
    upperView.frame = CGRectMake(upperView.frame.origin.x, 166, upperView.frame.size.width, upperView.frame.size.height);
    
    [UIView commitAnimations];
    
    currentRow = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component
{
    return dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [dataSource objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [mainDelegate.arrOfResult replaceObjectAtIndex:currentRow withObject:[dataSource objectAtIndex:row]];
}

-(IBAction)apply:(UIButton *)sender{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.3f];
    
    upperView.frame = CGRectMake(upperView.frame.origin.x, 600, upperView.frame.size.width, upperView.frame.size.height);
    
    [UIView commitAnimations];
    [mainTableView reloadData];
    
}

-(IBAction)deleteFilter:(UIButton *)sender{
    [mainDelegate.arrOfResult replaceObjectAtIndex:sender.tag withObject:@""];
    [mainTableView reloadData];
    sender.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    filterGroups = [NSArray arrayWithObjects: @"Сортировка", @"Тип работы", @"Категория", nil];
    upperView.frame = CGRectMake(upperView.frame.origin.x, 600, upperView.frame.size.width, upperView.frame.size.height);
    
    arrayOfFilter = [[NSMutableArray alloc] init];
    [arrayOfFilter addObject:[NSArray arrayWithObjects: @"Сначала дешевые",
                              @"Сначала дорогие", @"Сначала новые", @"Сначала старые", @"Сначала срочные", nil]];
    [arrayOfFilter addObject:[NSArray arrayWithObjects: @"Домашняя работа",
                              @"Контрольная работа", @"Курсовая работа", nil]];
    [arrayOfFilter addObject:[NSArray arrayWithObjects: @"Математика",
                              @"Физика", @"Химия", @"Философия", nil]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
