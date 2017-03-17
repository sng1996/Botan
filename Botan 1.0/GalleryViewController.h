//
//  GalleryViewController.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 10.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AppDelegate.h"

@interface GalleryViewController : UIViewController{
    
    AppDelegate *mainDelegate;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
    ALAssetsLibrary *library;
}

@end
