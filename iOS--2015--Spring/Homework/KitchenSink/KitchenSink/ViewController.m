//
//  ViewController.m
//  KitchenSink
//
//  Created by Jim on 4/22/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import "ViewController.h"

@import iAd;

@interface ViewController ()
{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, 50)];

    _adBanner.delegate = self;
    _bannerIsVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Ad Banner View Delegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if(!_bannerIsVisible)
    {
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
         // make banner rise
        [UIView animateWithDuration:0.5 animations:^{
                banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
         }];
         _bannerIsVisible = YES;
        
    }
}
- (void)bannerView:(ADBannerView *)banner
    didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to receive ad.");
    
    if(_bannerIsVisible)
    {
        [UIView animateWithDuration:0.5 animations:^{
            banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        }];
        
        _bannerIsVisible = NO;
        
    }
}

@end
