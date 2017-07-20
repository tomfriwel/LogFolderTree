//
//  NSString+Repeat.m
//  LogFolderTrees
//
//  Created by tomfriwel on 20/07/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "NSString+Repeat.h"

@implementation NSString (Repeat)

- (NSString *)repeatTimes:(NSUInteger)times {
    return [@"" stringByPaddingToLength:times * [self length] withString:self startingAtIndex:0];
}

@end
