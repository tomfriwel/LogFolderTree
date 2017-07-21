//
//  ViewController.m
//  LogFolderTreesCocoa
//
//  Created by tomfriwel on 11/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import "Tree.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *testDir = @"/Users/Shared/testFolder";
    NSURL *testUrl = [NSURL URLWithString:testDir];
    [Tree logTree:testUrl];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
