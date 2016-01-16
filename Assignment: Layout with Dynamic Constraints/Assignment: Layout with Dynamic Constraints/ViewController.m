//
//  ViewController.m
//  Assignment: Layout with Dynamic Constraints
//
//  Created by Taro Minowa on 1/16/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MapKit/Mapkit.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the web page
    NSString *webURL = @"https://twitter.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [self.webView loadRequest:request];
}


@end
