//
//  ViewController.m
//  Assignment: Basic Map Interface
//
//  Created by Taro Minowa on 1/28/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *tokyoAnno;
@property (strong, nonatomic) MKPointAnnotation *londonAnno;
@property (strong, nonatomic) MKPointAnnotation *sanFranciscoAnno;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAnnotations];

}

- (void)addAnnotations {
    self.tokyoAnno = [[MKPointAnnotation alloc] init];
    self.tokyoAnno.coordinate = CLLocationCoordinate2DMake(35.6735408, 139.570303);
    self.tokyoAnno.title = @"Tokyo";

    self.londonAnno = [[MKPointAnnotation alloc] init];
    self.londonAnno.coordinate = CLLocationCoordinate2DMake(51.5287718,-0.2416816);
    self.londonAnno.title = @"London";

    self.sanFranciscoAnno = [[MKPointAnnotation alloc] init];
    self.sanFranciscoAnno.coordinate = CLLocationCoordinate2DMake(37.757815,-122.5076401);
    self.sanFranciscoAnno.title = @"San Franciso";

    [self.mapView addAnnotations:@[self.tokyoAnno, self.londonAnno, self.sanFranciscoAnno]];
}

- (IBAction)tokyoTapped:(id)sender {
    [self centerMap:self.tokyoAnno];
}

- (IBAction)londonTapped:(id)sender {
    [self centerMap:self.londonAnno];
}

- (IBAction)sanFranciscoTapped:(id)sender {
    [self centerMap:self.sanFranciscoAnno];
}

- (void)centerMap:(MKPointAnnotation *)centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}

@end
