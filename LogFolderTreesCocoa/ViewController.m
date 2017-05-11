//
//  ViewController.m
//  LogFolderTreesCocoa
//
//  Created by tomfriwel on 11/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    int status;
    char value[1024];
    FILE *fp = popen("tree ./", "r");
    
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
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
