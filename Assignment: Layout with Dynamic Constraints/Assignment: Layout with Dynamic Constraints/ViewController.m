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

    // Center the map to Twitter HQ location
    CLLocationDegrees latitude = 37.776692;
    CLLocationDegrees longititude = -122.4189706;

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longititude);
    annotation.title = @"Twitter HQ";
    [self.mapView addAnnotation:annotation];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 10000, 10000);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjustedRegion];
}

@end
