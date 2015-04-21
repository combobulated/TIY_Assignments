//
//  ViewController.m
//  SpaceAppsTest2
//
//  Created by Jim on 4/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //load html content into webview
    NSString *embedHTML = @"<html><head></head><body><h2>UIWebView Sample App</h2><p>1.Display a web site.<br>2.Load and html file.<br>3.load an html data.<br></p></body></html>";
   
    
    [self.webview loadHTMLString:embedHTML baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
