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
            }
            else {
                NSLog(@"%@%@%@", prefix, @"├── ", key);
            }
            id item = folderInfo[key];
            
            if (isEndNode) {
                [self log:item level:level+1 isEndNode:NO prefix:[NSString stringWithFormat:@"%@    ", prefix]];
            }
            else {
                [self log:item level:level+1 isEndNode:NO prefix:[NSString stringWithFormat:@"%@│   ", prefix]];
            }
        }
    }
    else if ([folderInfo isKindOfClass:[NSArray class]]) {
        NSInteger i = 0;
        for (NSString *item in folderInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                if (i<[folderInfo count]-1) {
                    [self log:item level:level isEndNode:NO prefix:prefix];
                }
                else {
                    [self log:item level:level isEndNode:YES prefix:prefix];
                }
            }
            else if([item isKindOfClass:[NSString class]]) {
                if (i<[folderInfo count]-1) {
                    NSLog(@"%@%@%@", prefix, @"├── ", item);
                }
                else {
                    NSLog(@"%@%@%@", prefix, @"└── ", item);
                }
            }
            i++;
        }
    }
    
    return result;
}

+(void)logTree:(NSURL *)url {
    NSDictionary *res = [Tree getAllFilesInFolder:url];
    [self log:res level:0 isEndNode:YES prefix:@""];
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
