//
//  GalleryViewController.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 10.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "GalleryViewController.h"

static int count=0;

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

     
    /*imageArray=[[NSArray alloc] init];
    mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
     
    library = [[ALAssetsLibrary alloc] init];*/
    

     
    /*void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSLog(@"HELLO3");
     
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                count = 5;
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             NSLog(@"HELLO4 %lu", (unsigned long)[mutableArray count]);
     
                             if ([mutableArray count]==count)
                             {
                                 NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 [self allPhotosCollected:imageArray];
                             }
                         }
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
     NSLog(@"HELLO5");
            }
        }
    };
     
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
     
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
            NSLog(@"HELLO6");
        }
    };
     
    assetGroups = [[NSMutableArray alloc] init];
     
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
    usingBlock:assetGroupEnumerator
    failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
    NSLog(@"HELLO7");*/
    
        imageArray=[[NSArray alloc] init];
        mutableArray =[[NSMutableArray alloc]init];
        NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
        
        library = [[ALAssetsLibrary alloc] init];
        
        void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            NSLog(@"hello1");
            if(result != nil) {
                NSLog(@"hello2");
                if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    NSLog(@"hello3");
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    
                    NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                    
                    [library assetForURL:url resultBlock:^(ALAsset *asset) {
                        if (asset != nil){
                                 [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                                 
                                 NSLog(@"hello");
                                 
                                 if ([mutableArray count]==count)
                                 {
                                     for(int i = 0; i < 40; i++){
                                         NSLog(@"WORLD");
                                     }
                                     imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                     [self allPhotosCollected:imageArray];
                                    
                                 }
                             }
                    }
                            failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                    NSLog(@"ali: %@",result);
                    
                }
            }
        };
        
        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
        
        void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
            if(group != nil) {
                [group enumerateAssetsUsingBlock:assetEnumerator];
                [assetGroups addObject:group];
                count=[group numberOfAssets];
                NSLog(@"GROUP!!! %d", count);
            }
        };
        
        assetGroups = [[NSMutableArray alloc] init];
        
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                               usingBlock:assetGroupEnumerator
                             failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

 
-(void)allPhotosCollected:(NSArray*)imgArray{
    NSLog(@"I'M HERE!!! %lu", (unsigned long)[imgArray count]);
    
     float pointX = 4.0f;
     float pointY = 68.0f;
     float pictureSize = 104.0f;
     UIButton *button;
     for (int i = 0; i <= imgArray.count/3; i++){
         for (int j = 0; j < 3; j++){
             if (3*i+j < imgArray.count){
                 button = [[UIButton alloc] initWithFrame:CGRectMake(pointX + j*pictureSize, pointY + i*pictureSize, pictureSize, pictureSize)];
                 [button setBackgroundImage:[imgArray objectAtIndex:3*i+j] forState:UIControlStateNormal];
                 [button addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
                 button.tag = 3*i+j;
                 [self.view addSubview:button];
                 break;
             }
             else{
                 break;
             }
         }
         break;
     }
}
 
- (IBAction)choosePicture:(UIButton *)sender{
    [sender setTitle:@"Added" forState:UIControlStateNormal];
    [mainDelegate.arrOfPictures addObject:[imageArray objectAtIndex:sender.tag]];
}



@end

