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
    static int level = 0;
    
    NSMutableArray *files = [[NSMutableArray alloc] init];
    NSMutableDictionary *currentTree = [[NSMutableDictionary alloc] init];
    
    NSString *folderName = [folderURL lastPathComponent];
    
//    [currentTree setObject:folderName forKey:@"folder"];
    
    NSArray *contentOfMyFolder = [[NSFileManager defaultManager]
                                    contentsOfDirectoryAtURL:folderURL
                                    includingPropertiesForKeys:@[
                                                            NSURLContentModificationDateKey,
                                                            NSURLLocalizedNameKey
                                                        ]
                                    options:NSDirectoryEnumerationSkipsHiddenFiles
                                    error:nil
                                  ];
    NSInteger count = contentOfMyFolder.count;
    
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
        } else {
        }
    }
    level++;
    
    [currentTree setObject:files forKey:folderName];
    
    return currentTree;
}

//获取文件夹下所有files
+(NSArray *)getFilesInFolder:(NSURL *)folderURL {
    //    NSLog(@"getAllFilesInFolder");
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSArray *contentOfMyFolder = [[NSFileManager defaultManager]
                                  contentsOfDirectoryAtURL:folderURL
                                  includingPropertiesForKeys:@[NSURLContentModificationDateKey, NSURLLocalizedNameKey]
                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                                  error:nil];
    for (NSURL *item in contentOfMyFolder) {
        NSString *path = [item path];
        BOOL isDir;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
            if (isDir) {
                continue;
            } else {
                [res addObject:item];
            }
        } else {
        }
    }
    return res;
}

@end
