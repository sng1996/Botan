//
//  TalkingViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 14.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRVStompClient.h"
#import "AppDelegate.h"
#import "HPGrowingTextView.h"
#import "HPTextViewInternal.h"

@interface TalkingViewController : UIViewController <UITextViewDelegate, HPGrowingTextViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITextView *messageTxtView;
    IBOutlet UIView *mainView;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIView *messageView;
    IBOutlet UIButton *add;
    IBOutlet UIButton *send;
    IBOutlet HPGrowingTextView *msgTextView;
    
    UITextView *txt;
    SRWebSocket *webSocket;
    NSInteger currentСompanionId;
    NSInteger order_id;
    
    

    
}

@property (nonatomic, strong) UIBarButtonItem *right1;
@property (nonatomic, strong) IBOutlet UITextView *messageTxtView;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UIView *messageView;
@property (nonatomic, strong) IBOutlet HPGrowingTextView *msgTextView;
@property NSInteger order_id;

-(CGFloat)sizeForText:(NSString *)text withFont:(UIFont *)font withWidth:(float)width;

@end
