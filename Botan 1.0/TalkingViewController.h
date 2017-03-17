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

@interface TalkingViewController : UIViewController <UITextViewDelegate>{
    
    AppDelegate *mainDelegate;
    IBOutlet UITextView *messageTxtView;
    IBOutlet UIView *mainView;
    UITextView *txt;
    IBOutlet UIScrollView *scrollView;
    SRWebSocket *webSocket;
    NSInteger currentСompanionId;

    
}

-(CGFloat)sizeForText:(NSString *)text withFont:(UIFont *)font withWidth:(float)width;

@end
