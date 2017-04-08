//
//  AppDelegate.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "AppDelegate.h"
#import "Order.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize orders, arrOfResult, science, types, category, type, date, jsonData, arrOfPictures, imageArray, currentUser, currentOrder, isEdit, viewWidth, currentFilterArray, currentFilterObject, filter, lastFilter;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.orders = [[NSMutableArray alloc] init];
    self.arrOfPictures = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.arrOfResult = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    self.science = [[NSMutableArray alloc] initWithObjects:@"Все области", @"Математика", @"Физика", @"Программирование", nil];
    self.types = [[NSMutableArray alloc] initWithObjects:@"Все типы", @"Домашняя работа", @"Контрольная работа", @"Курсовой проект", nil];
    self.currentUser = [[Person alloc] init];
    self.filter = [[Filter alloc] init];
    self.lastFilter = [[Filter alloc] init];
    self.isEdit = NO;
    self.currentOrder = [[Order alloc] init];
    //[self aMethod];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    //self.messagesTextView.text = [NSString stringWithFormat:@"%@\n%@", self.messagesTextView.text, message];
    NSLog(@"MESSAGE %@", message);
}

- (void)sendMessage:(NSString *)string {
    [webSocket send:string];
}

@end
