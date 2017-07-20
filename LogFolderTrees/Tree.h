//
//  Tree.h
//  LogFolderTrees
//
//  Created by tomfriwel on 12/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tree : NSObject

//递归遍历文件夹path, 获取文件夹下所有files
+(NSDictionary *)getAllFilesInFolder:(NSURL *)folderURL;

//获取文件夹下所有files
+(NSArray *)getFilesInFolder:(NSURL *)folderURL;

@end
