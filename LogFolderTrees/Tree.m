//
//  Tree.m
//  LogFolderTrees
//
//  Created by tomfriwel on 12/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "Tree.h"

#define CENTER @"├── "

#define BOTTOM @"└── "

#define LINE @"│   "

#define EMPTY @"    "

@implementation Tree

+(NSDictionary *)getAllFilesInFolder:(NSURL *)folderURL {
    NSMutableArray *files = [[NSMutableArray alloc] init];
    NSMutableDictionary *currentTree = [[NSMutableDictionary alloc] init];
    
    NSString *folderName = [folderURL lastPathComponent];
    
    NSArray *contentOfMyFolder = [[NSFileManager defaultManager]
                                    contentsOfDirectoryAtURL:folderURL
                                    includingPropertiesForKeys:@[
                                                            NSURLContentModificationDateKey,
                                                            NSURLLocalizedNameKey
                                                        ]
                                    options:NSDirectoryEnumerationSkipsHiddenFiles
                                    error:nil
                                  ];
    
    for (NSURL *item in contentOfMyFolder) {
        NSString *path = [item path];
        BOOL isDir;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
            NSString *name = [item lastPathComponent];
            
            if (isDir) {
                NSDictionary *tempFolderInfo = [self getAllFilesInFolder:item];
                [files addObject:tempFolderInfo];
            } else {
                [files addObject:name];
            }
        }
    }
    [currentTree setObject:files forKey:folderName];
    
    return currentTree;
}

+(NSString *)log:(id)folderInfo level:(NSInteger)level isEndNode:(BOOL)isEndNode prefix:(NSString *)prefix {
    NSString *result = @"";
    
    if ([folderInfo isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in folderInfo) {
            if (isEndNode) {
                NSLog(@"%@%@%@", prefix, @"└── ", key);
                
                NSString *temp = [NSString stringWithFormat:@"%@%@%@", prefix, @"└── ", key];
                
                result = [result stringByAppendingString:temp];
                result = [result stringByAppendingString:@"\n"];
            }
            else {
                NSLog(@"%@%@%@", prefix, @"├── ", key);
                
                NSString *temp = [NSString stringWithFormat:@"%@%@%@", prefix, @"├── ", key];
                
                result = [result stringByAppendingString:temp];
                result = [result stringByAppendingString:@"\n"];
            }
            id item = folderInfo[key];
            
            if (isEndNode) {
                NSString *temp = [self log:item level:level+1 isEndNode:NO prefix:[NSString stringWithFormat:@"%@    ", prefix]];
                
                result = [result stringByAppendingString:temp];
            }
            else {
                NSString *temp = [self log:item level:level+1 isEndNode:NO prefix:[NSString stringWithFormat:@"%@│   ", prefix]];
                
                result = [result stringByAppendingString:temp];
            }
        }
    }
    else if ([folderInfo isKindOfClass:[NSArray class]]) {
        NSInteger i = 0;
        for (NSString *item in folderInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                if (i<[folderInfo count]-1) {
                    NSString *temp = [self log:item level:level isEndNode:NO prefix:prefix];
                    
                    result = [result stringByAppendingString:temp];
                }
                else {
                    NSString *temp = [self log:item level:level isEndNode:YES prefix:prefix];
                    
                    result = [result stringByAppendingString:temp];
                }
            }
            else if([item isKindOfClass:[NSString class]]) {
                if (i<[folderInfo count]-1) {
                    NSLog(@"%@%@%@", prefix, @"├── ", item);
                    
                    NSString *temp = [NSString stringWithFormat:@"%@%@%@", prefix, @"├── ", item];
                    
                    result = [result stringByAppendingString:temp];
                    result = [result stringByAppendingString:@"\n"];
                }
                else {
                    NSLog(@"%@%@%@", prefix, @"└── ", item);
                    
                    NSString *temp = [NSString stringWithFormat:@"%@%@%@", prefix, @"└── ", item];
                    
                    result = [result stringByAppendingString:temp];
                    result = [result stringByAppendingString:@"\n"];
                }
            }
            i++;
        }
    }
//    NSLog(@"\n%@", result);
    
    return result;
}

+(void)logTree:(NSURL *)url {
    NSDictionary *res = [Tree getAllFilesInFolder:url];
    NSString *treeString = [self log:res level:0 isEndNode:YES prefix:@""];
    NSLog(@"\n%@", treeString);
}

//+(NSString *)convertToJsonString:(id)json {
//    NSString *jsonString = @"";
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:(NSJSONWritingOptions)NSJSONWritingPrettyPrinted error:&error];
//    
//    if (!jsonData) {
//        NSLog(@"convertToJsonString error:%@", error.localizedDescription);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    return jsonString;
//}

@end
