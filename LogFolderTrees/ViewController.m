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
    
    [ViewController toString:res level:0 isEndNode:YES];
    
//    DLog(@"%@", @"testFolder/");
//    DLog(@"%@", @"├── test 2.txt");
//    DLog(@"%@", @"├── test 3.txt");
//    DLog(@"%@", @"├── test.txt");
//    DLog(@"%@", @"└── testChildFolder");
//    DLog(@"%@", @"    ├── test 2.txt");
//    DLog(@"%@", @"    └── test 3.txt");
}
//static int isFirst = 1;

+(NSString *)toString:(id)folderInfo level:(NSInteger)level isEndNode:(BOOL)isEndNode {
    NSString *result = @"";
    NSString *pre = [@" " repeatTimes:level*4];
    
    if ([folderInfo isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in folderInfo) {
//            if (isFirst) {
//                NSLog(@"%@%@%@", pre, @"─── ", key);
//                isFirst = 0;
//            }
//            else {
                if (isEndNode) {
                    NSLog(@"%@%@%@", pre, @"└── ", key);
                }
                else {
                    NSLog(@"%@%@%@", pre, @"├── ", key);
                }
//            }
            id item = folderInfo[key];
            
            if ([item isKindOfClass:[NSDictionary class]]) {
                [ViewController toString:item level:level isEndNode:NO];
            }
            else if([item isKindOfClass:[NSArray class]]) {
                [ViewController toString:item level:level+1 isEndNode:NO];
            }
            else if([item isKindOfClass:[NSString class]]) {
                NSLog(@"%@%@%@", pre, @"└── ", item);
            }
        }
    }
    else if ([folderInfo isKindOfClass:[NSArray class]]) {
        NSInteger i = 0;
        for (NSString *item in folderInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                if (i<[folderInfo count]-1) {
                    [ViewController toString:item level:level isEndNode:NO];
                }
                else {
                    [ViewController toString:item level:level isEndNode:YES];
                }
            }
            else if([item isKindOfClass:[NSArray class]]) {
                [ViewController toString:item level:level+1 isEndNode:NO];
            }
            else if([item isKindOfClass:[NSString class]]) {
                if (i<[folderInfo count]-1) {
                    NSLog(@"%@%@%@", pre, @"├── ", item);
                }
                else {
                    NSLog(@"%@%@%@", pre, @"└── ", item);
                }
            }
            i++;
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
