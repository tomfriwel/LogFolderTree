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
    NSDictionary *res = [Tree getAllFilesInFolder:testUrl];
    NSString *json = convertToJsonString(res);
    
    NSLog(@"%@", res);
    NSLog(@"%@", json);
    
    [ViewController toString:res level:0];
    
    DLog(@"%@", @"testFolder/");
    DLog(@"%@", @"├── test 2.txt");
    DLog(@"%@", @"├── test 3.txt");
    DLog(@"%@", @"├── test.txt");
    DLog(@"%@", @"└── testChildFolder");
    DLog(@"%@", @"    ├── test 2.txt");
    DLog(@"%@", @"    └── test 3.txt");
}

+(NSString *)toString:(NSDictionary *)folderInfo level:(NSInteger)level {
    NSString *result = @"";
    NSString *pre = [@" " repeatTimes:level*4];
    
    for (NSString *key in folderInfo) {
        NSLog(@"key:%@", key);
        
        id item = folderInfo[key];
        
        if ([item isKindOfClass:[NSDictionary class]]) {
            [ViewController toString:item level:level+1];
        }
        else if([item isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", key);
        }
    }
    
    return result;
}

NSString *convertToJsonString(id json) {
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:(NSJSONWritingOptions)NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        NSLog(@"convertToJsonString error:%@", error.localizedDescription);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
