//
//  ViewController.m
//  LogFolderTrees
//
//  Created by tomfriwel on 09/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Repeat.h"
#import "Tree.h"

#define DLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", NSHomeDirectory());
//    
//    NSURL *homeUrl = [NSURL URLWithString:NSHomeDirectory()];
//    NSLog(@"%@", [Tree getAllFilesInFolder:homeUrl]);
//    
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    NSURL *docUrl = [NSURL URLWithString:documentsDirectory];
//    NSLog(@"%@", [Tree getAllFilesInFolder:docUrl]);
    
    NSString *testDir = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"testFolder"];
    NSURL *testUrl = [NSURL URLWithString:testDir];
    
    [Tree logTree:testUrl];
    
    
//    DLog(@"%@", @"testFolder/");
//    DLog(@"%@", @"├── test 2.txt");
//    DLog(@"%@", @"├── test 3.txt");
//    DLog(@"%@", @"├── test.txt");
//    DLog(@"%@", @"└── testChildFolder");
//    DLog(@"%@", @"    ├── test 2.txt");
//    DLog(@"%@", @"    └── test 3.txt");
}
//static int isFirst = 1;
//prefix:(NSString *)prefix



@end
