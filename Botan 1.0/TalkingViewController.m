//
//  TalkingViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 14.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "TalkingViewController.h"

@interface TalkingViewController ()

@end

@implementation TalkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self aMethod];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (mainDelegate.currentUser._id == 1){
        currentСompanionId = 15;
    }else{
        currentСompanionId = 1;
    }
    
    messageTxtView.autocorrectionType = UITextAutocorrectionTypeNo;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    scrollView.contentSize = CGSizeMake(320, 464);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.bounds.size.height);
    [scrollView setContentOffset:bottomOffset animated:YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{
    /*CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame=frame;
    frame = keyboardView.frame;
    frame.size.height = textView.contentSize.height + 10;
    keyboardView.frame = frame;
    messageTxtView.inputAccessoryView = keyboardView;*/
}

- (IBAction)dismissKeyboard:(UIButton *)sender{
    
    [messageTxtView resignFirstResponder];
    
}

-(CGFloat)sizeForText:(NSString *)text withFont:(UIFont *)font withWidth:(float)width
{
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:font
                   constrainedToSize:constraint
                       lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

- (IBAction)send:(UIButton *)sender{
    
    [self sendMessageToClient:messageTxtView.text to_id:currentСompanionId];
    
    [self drawMessage:messageTxtView.text isRight:YES];
}

- (void)keyboardFrameChange:(NSNotification *)notification {
    
    CGRect begin         = [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect end           = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardSize = begin.size.height;
    BOOL isShowing       = begin.origin.y > end.origin.y;
    NSLog(@"isShowing = %d", isShowing);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if (isShowing){
        CGRect frame = mainView.frame;
        frame.origin.y = mainView.frame.origin.y - keyboardSize;
        mainView.frame=frame;
        frame = scrollView.frame;
        frame.size.height = scrollView.frame.size.height - keyboardSize;
        frame.origin.y = scrollView.frame.origin.y + keyboardSize;
        scrollView.frame = frame;
    }
    else{
        CGRect frame = mainView.frame;
        frame.origin.y = mainView.frame.origin.y + keyboardSize;
        mainView.frame=frame;
        frame = scrollView.frame;
        frame.size.height = scrollView.frame.size.height + keyboardSize;
        frame.origin.y = scrollView.frame.origin.y - keyboardSize;
        scrollView.frame = frame;
    }
    
    [UIView commitAnimations];
}

-(void) aMethod {
    
    NSString *urlString = @"ws://localhost:8080/gameapi";
    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    newWebSocket.delegate = self;
    
    [newWebSocket open];
    
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    webSocket = newWebSocket;
    //[webSocket send:[NSString stringWithFormat:@"Hello from %@", [UIDevice currentDevice].name]];
    NSLog(@"hello");
    [self registerSession:mainDelegate.currentUser._id];
}

- (void)webSocket:(SRWebSocket *)newWebSocket didFailWithError:(NSError *)error {
    //[self connectWebSocket];
    NSLog(@"ERROR %@", error);
}

- (void)webSocket:(SRWebSocket *)newWebSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    //[self connectWebSocket];
    NSLog(@"CLOSE %@", reason);
}

- (void)webSocket:(SRWebSocket *)newWebSocket didReceiveMessage:(id)message {
    NSLog(@"MESSAGE %@", message);
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic])
    {
        NSDictionary *dict = [responseDic objectForKey:@"response"];
        [self drawMessage:[dict objectForKey:@"message"] isRight:NO];
    }
}

- (void)sendMessage:(NSString *)string {
    [webSocket send:string];
}

- (void)sendMessageToClient:(NSString *)message to_id:(NSInteger)to_id{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInteger: to_id], @"to_id",
                          message, @"message",
                          [NSNumber numberWithInteger: mainDelegate.currentUser._id], @"from_id", nil];
    NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [NSNumber numberWithInteger: 1], @"code",
                              dict, @"response", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self sendMessage:jsonStr];
    NSLog(jsonStr);
}

- (void)registerSession:(NSInteger)id{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInteger: 2], @"code",
                          [NSNumber numberWithInteger: mainDelegate.currentUser._id], @"id", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self sendMessage:jsonStr];
}

- (void)drawMessage:(NSString *)message isRight:(BOOL)isRight{
    UILabel *msgLbl = [[UILabel alloc] init];
    
    CGFloat height = [self sizeForText:message withFont:[UIFont fontWithName:@"Helvetica" size:10] withWidth:140.0f];
    
    [msgLbl setBackgroundColor:[UIColor whiteColor]];
    msgLbl.text = message;
    msgLbl.numberOfLines = 0;
    messageTxtView.text = @"";
    msgLbl.frame = CGRectMake(170*isRight, scrollView.contentSize.height, 140, height + 40);
    scrollView.contentSize = CGSizeMake(320, scrollView.contentSize.height + height + 60);
    [scrollView addSubview:msgLbl];
    CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.bounds.size.height);
    [scrollView setContentOffset:bottomOffset animated:YES];
}


@end
