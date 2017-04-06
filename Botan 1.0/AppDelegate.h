//
//  AppDelegate.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "Person.h"
#import "CRVStompClient.h"
#import <Pusher/Pusher.h>


@class CRVStompClient;
@protocol CRVStompClientDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate, SRWebSocketDelegate>{
    NSMutableArray *orders; //MainViewController
    NSMutableArray *myOrders; //CabinetViewController
    NSMutableArray *categories;
    NSMutableArray *types;
    NSMutableArray *arrOfResult; //MainViewController
    SRWebSocket *webSocket;
    NSInteger category; //AddOrderViewController
    NSInteger type; //AddOrderViewController
    NSString *date; //not nessasary
    NSData *jsonData;
    NSMutableArray *arrOfPictures;
    NSMutableArray *imageArray; //for cameraViewController
    Person *currentUser;
    Order *currentOrder;
    Boolean isEdit; //for connection between GetOrderViewController and AddOrderViewController
    float viewWidth;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *arrOfResult;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *types;
@property NSInteger category;
@property NSInteger type;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSData *jsonData;
@property (strong, nonatomic) NSMutableArray *arrOfPictures;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) Person *currentUser;
@property (strong, nonatomic) Order *currentOrder;
@property Boolean isEdit;
@property float viewWidth;

- (void)sendMessage:(NSString *) string;

@end

