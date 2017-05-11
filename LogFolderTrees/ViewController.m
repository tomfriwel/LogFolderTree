//
//  ViewController.m
//  LogFolderTrees
//
//  Created by tomfriwel on 09/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#include <pstream.h>
//#include <string>
//#include <iostream>


@interface ViewController ()

@property NSMutableDictionary *photos;

@end

@implementation ViewController {
    id _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", NSHomeDirectory());
    
//    NSTask *task = [[NSTask alloc] init];
//    [task setLaunchPath:@"/bin/bash"];
//    [task setArguments:@[ @"-c", @"/usr/bin/killall Dock" ]];
//    [task launch];
    int status;
    char value[1024];
    FILE *fp = popen("tree /", "r");
    
    if (fp == NULL) exit(1); // handle error
    
    while (fgets(value, 1024, fp) != NULL) {
        printf("Value: %s", value);
    }
    
    status = pclose(fp);
    if (status == -1) {
        /* Error reported by pclose() */
    }
    else {
        /* Use macros described under wait() to inspect `status' in order
         to determine success/failure of command executed by popen() */
    }
    // run a process and create a streambuf that reads its stdout and stderr
    
    
    
    
//    [self getImageForCollectionView:^{
//        NSLog(@"arr:%@", self.photos);
//    }];
//    NSLog(@"123");
    
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // not in main block task
//        [weakSelf getImageForCollectionView];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // main block. change ui
//            NSLog(@"11:%@", self.photos);
//        });
//    });
    
//    NSLog(@"123111");
}


//
//- (void)getImageForCollectionView {
//    _library = [[ALAssetsLibrary alloc] init];
//    self.photos = [NSMutableDictionary dictionary];
//    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        if (group) {
//            NSMutableArray *array = [NSMutableArray array];
//            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                if (result) {
//                    [array addObject:result];
//                    NSLog(@"1");
//                }
//            }];
//            //                NSLog(@"array:%@", array);
//            [self.photos setValue:array forKey:[group valueForProperty:@"ALAssetsGroupPropertyName"]];
//        }
//    } failureBlock:^(NSError *error) {
//        
//    }];
//}
//
//- (void)getImageForCollectionView:(void(^)(void))callback {
//    _library = [[ALAssetsLibrary alloc] init];
//    self.photos = [NSMutableDictionary dictionary];
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//            if (group) {
//                NSMutableArray *array = [NSMutableArray array];
//                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                    if (result) {
//                        [array addObject:result];
//                        NSLog(@"1");
//                    }
//                }];
////                NSLog(@"array:%@", array);
//                [weakSelf.photos setValue:array forKey:[group valueForProperty:@"ALAssetsGroupPropertyName"]];
//            }
//        } failureBlock:^(NSError *error) {
//            
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            callback();
//        });
//    });
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
