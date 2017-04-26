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
@synthesize messageTxtView, mainView, scroller, messageView, order_id, right1, msgTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self aMethod];
    
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (mainDelegate.currentUser._id == mainDelegate.currentOrder.customer._id){
        currentСompanionId = mainDelegate.currentOrder.performer._id;
    }else{
        currentСompanionId = mainDelegate.currentOrder.customer._id;
    }
    
    msgTextView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(40, 7, 240, 33)];
    msgTextView.isScrollable = NO;
    msgTextView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    msgTextView.minNumberOfLines = 1;
    msgTextView.maxNumberOfLines = 4;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    msgTextView.returnKeyType = UIReturnKeyGo; //just as an example
    msgTextView.font = [UIFont systemFontOfSize:15.0f];
    msgTextView.delegate = self;
    msgTextView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    msgTextView.backgroundColor = [UIColor whiteColor];
    msgTextView.placeholder = @"Type to see the textView grow!";
    msgTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [messageView addSubview:msgTextView];
    
     messageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    /*messageTxtView.autocorrectionType = UITextAutocorrectionTypeNo;
    messageTxtView.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
    scroller.contentSize = CGSizeMake(320, 464);
    //messageTxtView.layer.cornerRadius = 5;
    messageTxtView.scrollEnabled = NO;*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(keyPressed:)
                                                 name: UITextViewTextDidChangeNotification
                                               object: nil];
    
    right1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    
    NSArray *actionButtonItemsRight = @[right1];
    self.navigationItem.rightBarButtonItems = actionButtonItemsRight;
    
    UILabel *label = (UILabel *)[self.navigationController.navigationBar viewWithTag:1];
    label.text = @"Serega";
    
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = messageView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    messageView.frame = r;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGPoint bottomOffset = CGPointMake(0, scroller.contentSize.height - scroller.bounds.size.height);
    [scroller setContentOffset:bottomOffset animated:YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}*/


/*- (void)textViewDidChange:(UITextView *)textView{
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame=frame;
    frame = keyboardView.frame;
    frame.size.height = textView.contentSize.height + 10;
    keyboardView.frame = frame;
    messageTxtView.inputAccessoryView = keyboardView;
}*/

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
        frame = scroller.frame;
        frame.size.height = scroller.frame.size.height - keyboardSize;
        frame.origin.y = scroller.frame.origin.y + keyboardSize;
        scroller.frame = frame;
    }
    else{
        CGRect frame = mainView.frame;
        frame.origin.y = mainView.frame.origin.y + keyboardSize;
        mainView.frame=frame;
        frame = scroller.frame;
        frame.size.height = scroller.frame.size.height + keyboardSize;
        frame.origin.y = scroller.frame.origin.y - keyboardSize;
        scroller.frame = frame;
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
    msgLbl.frame = CGRectMake(170*isRight, scroller.contentSize.height, 140, height + 40);
    scroller.contentSize = CGSizeMake(320, scroller.contentSize.height + height + 60);
    [scroller addSubview:msgLbl];
    CGPoint bottomOffset = CGPointMake(0, scroller.contentSize.height - scroller.bounds.size.height);
    [scroller setContentOffset:bottomOffset animated:YES];
}

-(IBAction)keyPressed:(id)sender{
    
    /*CGSize newSize = [messageTxtView.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:14] constrainedToSize:CGSizeMake(208.279f,9999) lineBreakMode:UILineBreakModeWordWrap];
    NSInteger newSizeH = newSize.height;
    NSLog(@"width = %f", newSize.width);
    
    
    if (messageTxtView.hasText)
    {
        if (newSizeH <= 95)
        {
            messageTxtView.scrollEnabled = NO;
            [messageTxtView scrollRectToVisible:CGRectMake(0,0,1,1) animated:NO];
            CGRect messageBoxFrame = messageTxtView.frame;
            messageBoxFrame.size.height = newSizeH + 13;
            NSLog(@"size  = %ld", newSizeH);
            messageTxtView.frame = messageBoxFrame;
            
            CGRect formFrame = messageView.frame;
            formFrame.size.height = 30 + newSizeH;
            formFrame.origin.y = 522 - (newSizeH - 16);
            messageView.frame = formFrame;
            
            formFrame = add.frame;
            formFrame.origin.y = newSizeH - 3;
            add.frame = formFrame;
            
            formFrame = send.frame;
            formFrame.origin.y = newSizeH - 3;
            send.frame = formFrame;
        }
        if (newSizeH > 95)
        {
            messageTxtView.scrollEnabled = YES;
        }
    }*/
    
    
}


@end
