//
//  GetOrderViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "GetOrderViewController.h"
#import "AddOrderViewController.h"
#import "TalkingViewController.h"
#import "MainViewController.h"
#import "ChooseExecutorViewController.h"

@interface GetOrderViewController ()

@end

@implementation GetOrderViewController
@synthesize typeLbl, beginDateLbl, endDateLbl, costLbl, descriptionLbl, scroller, pageControl;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];

    //init labels
    costLbl.text = [NSString stringWithFormat:@"%ld ₽", (long)mainDelegate.currentOrder.cost];
    typeLbl.text = [mainDelegate.types objectAtIndex: mainDelegate.currentOrder.type];
    beginDateLbl.text = mainDelegate.currentOrder.beginDate;
    endDateLbl.text = mainDelegate.currentOrder.endDate;
    descriptionLbl.text = mainDelegate.currentOrder.description;
    
    //init array of images
    imagesArray = [[NSMutableArray alloc] init];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageNamed:@"glass.jpg"];
    [imagesArray addObject:image];
    [imagesArray addObject:image];
    [imagesArray addObject:image];
    [imagesArray addObject:image];
    
    //init scrollView
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    for(int i = 0; i < imagesArray.count; i++){
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*scroller.frame.size.width, 0, scroller.frame.size.width, scroller.frame.size.height)];
        imageView.image = [imagesArray objectAtIndex:i];
        [scroller addSubview:imageView];
    }
    scroller.contentSize = CGSizeMake(imagesArray.count*scroller.frame.size.width, scroller.frame.size.height);
    pageControl.numberOfPages = imagesArray.count;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    switch (code){
            
        case 101: // заказ успешно удален
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
        case 102: // заказ успешно сменил статус
            mainDelegate.currentOrder.status = 2;
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
        case 103: // готов выполнить заказ
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            mainViewController =  (MainViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
            break;
    }
    
    
}

-(void)sendToServer:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    
}

-(IBAction)showBottomMenu:(id)sender{
    
    UIActionSheet *actionSheet;
    
    if (mainDelegate.currentOrder.customer._id == mainDelegate.currentUser._id){
        if (mainDelegate.currentOrder.status > 0){
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Botan 1.0"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Отмена"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Чат", @"Редактировать", @"Удалить", nil];
            currentStatus = 1;
        }
        else{
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Botan 1.0"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Отмена"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Выбрать исполнителя", @"Редактировать", @"Удалить", nil];
            currentStatus = 2;
        }
        
    }
    else{
        if (mainDelegate.currentOrder.performer._id == mainDelegate.currentUser._id){
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Botan 1.0"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Отмена"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Чат", @"Завершить", @"Отказаться", nil];
            currentStatus = 3;
        }
        else{
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Botan 1.0"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Отмена"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Взять заказ", @"Дать свою цену", nil];
            currentStatus = 4;
        }
    }
    
    
    
    
    
    SEL selector = NSSelectorFromString(@"_alertController");
    if ([actionSheet respondsToSelector:selector])
    {
        UIAlertController *alertController = [actionSheet valueForKey:@"_alertController"];
        if ([alertController isKindOfClass:[UIAlertController class]])
        {
            alertController.view.tintColor = [UIColor colorWithRed:56.0f/255.0f green:188.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
        }
    }
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (currentStatus) {
        case 1:
            [self status1: buttonIndex];
            break;
        case 2:
            [self status2: buttonIndex];
            break;
        case 3:
            [self status3: buttonIndex];
            break;
        default:
            [self status4: buttonIndex];
            break;
    }
    
}

-(void)status1:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self goToChat];
            break;
        case 1:
            [self editOrder];
            break;
        default:
            [self deleteOrder];
            break;
    }
    
}

-(void)status2:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self choosePerformer];
            break;
        case 1:
            [self editOrder];
            break;
        default:
            [self deleteOrder];
            break;
    }
    
}

-(void)status3:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self goToChat];
            break;
        case 1:
            [self finishOrder];
            break;
        default:
            [self decline];
            break;
    }
    
}

-(void)status4:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self takeOrder];
            break;
        default:
            [self offerNewCost];
            break;
    }
    
}

-(void)deleteOrder{
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/remove/?id=%ld", (long)mainDelegate.currentOrder._id];
    [self sendToServer:url];
    
}

-(void)editOrder{
    
    mainDelegate.isEdit = YES;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddOrderViewController *addOrderViewController =  (AddOrderViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"addOrderViewController"];
    [self presentViewController:addOrderViewController animated:YES completion:nil];
    
}

-(void)goToChat{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TalkingViewController *talkingViewController =  (TalkingViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"talkingViewController"];
    [self presentViewController:talkingViewController animated:YES completion:nil];
    
}

-(void)finishOrder{
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/change_status/?id=%ld&status=%ld", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentOrder.status];
    [self sendToServer:url];
    
}

-(void)takeOrder{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/take/?id=%ld&executor=%ld&cost=%ld&date=%@", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentUser._id, (long)mainDelegate.currentOrder.cost, strDate];
    [self sendToServer:url];
    
}

-(void)choosePerformer{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PerformerViewController *performerViewController =  (PerformerViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"performerViewController"];
    [self presentViewController:performerViewController animated:YES completion:nil];
    
}

-(void)offerNewCost{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @""
                                                          message: @"Введите новую цену"
                                                   preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"цена, ₽";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
        NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/order/take/?id=%ld&executor=%ld&cost=%ld&date=%@", (long)mainDelegate.currentOrder._id, (long)mainDelegate.currentUser._id, (long)alertController.textFields[0].text, strDate];
        [self sendToServer:url];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)decline{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender{
    
}



@end
