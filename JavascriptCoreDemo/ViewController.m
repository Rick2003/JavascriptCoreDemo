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

    
    NSString *jsCode = @"var a = 1+2";
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:jsCode];
    
    JSValue *value = [context objectForKeyedSubscript:@"a"];
    NSLog(@"SUM = %d", [value toInt32]);
    
    JSValue *value1 = [context.globalObject objectForKeyedSubscript:@"a"];
    NSLog(@"SUM1 = %d", [value1 toInt32]);
    
    JSValue *value2 = context[@"a"];
    NSLog(@"SUM2 = %d", [value2 toInt32]);
    
    NSString *functionCode = @"var triple = function(value) { return value * 3 }";
    [context evaluateScript:functionCode];
    
    JSValue *triple = [context evaluateScript:@"triple(a)"];
    NSLog(@"TRIPLE = %d", [triple toInt32]);
    
    JSValue *triple1 = context[@"triple"];
    JSValue *result = [triple1 callWithArguments:@[value]];
    NSLog(@"TRIPLE1 = %d", [result toInt32]);

    [context evaluateScript:@"var console = {};"];
    context[@"console"][@"log"] = ^(NSString *message) {
        NSLog(@"%@", message);
    };
    
    [context evaluateScript:@"var color = {red:230, green:90, blue:100}"];
    context[@"color"] = @{@"red":@(0), @"green":@(0), @"blue":@(0)};
    [context evaluateScript:@"console.log('red:'+color.red+' green:'+color.green+' blue:'+color.blue)"];
    
    context[@"log"] = ^(NSString *message) {
        NSLog(@"%@", message);
    };
    [context evaluateScript:@"log(`demo text`)"];
    
    //React Native Process
    
    //Objective C bridge
    NSMutableDictionary *buttonDict = [NSMutableDictionary new];
    
    context[@"createButton"] = ^(NSString *identifier) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blackColor];
        [self.view addSubview:button];
        [buttonDict setObject:button forKey:identifier];
        NSLog(@"%@", identifier);
    };
    
    context[@"setFrame"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height, NSString *identifier) {
        NSLog(@"%@", identifier);
        UIButton *button = [buttonDict objectForKey:identifier];
        [button setFrame:CGRectMake(x, y, width, height)];
    };
    
    context[@"setColor"] = ^(NSString *color, NSString *identifier) {
        NSLog(@"%@", identifier);
        UIButton *button = [buttonDict objectForKey:identifier];
        if([color isEqualToString:@"red"]){
            button.backgroundColor = [UIColor redColor];
        }else if([color isEqualToString:@"blue"]) {
            button.backgroundColor = [UIColor blueColor];
        }
    };
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jscode" ofType:@"js"];
    NSError *error = nil;
    NSString *script = [[NSString alloc] initWithContentsOfFile:filePath
        encoding:NSUTF8StringEncoding
        error:&error];
    
    [context evaluateScript:script];
    
}


@end
