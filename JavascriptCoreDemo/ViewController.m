//
//  ViewController.m
//  JavascriptCoreDemo
//
//  Created by Rick Chi on 1/19/19.
//  Copyright © 2019 Rick Chi. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString *jsCode = @"1+2";
    JSContext *context = [[JSContext alloc] init];
    JSValue *value = [context evaluateScript:jsCode];
    NSLog(@"SUM = %d", [value toInt32]);
    
}


@end
