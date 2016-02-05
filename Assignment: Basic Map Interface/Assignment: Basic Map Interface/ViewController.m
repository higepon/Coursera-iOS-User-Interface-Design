//
//  ViewController.m
//  Assignment: Basic Map Interface
//
//  Created by Taro Minowa on 1/28/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) MKPointAnnotation *tokyoAnno;
@property (strong, nonatomic) MKPointAnnotation *londonAnno;
@property (strong, nonatomic) MKPointAnnotation *sanFranciscoAnno;
@property (strong, nonatomic) MKPointAnnotation *currentAnno;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.mapIsMoving = NO;
    [self addAnnotations];
}

- (void)addAnnotations {
    self.tokyoAnno = [[MKPointAnnotation alloc] init];
    self.tokyoAnno.coordinate = CLLocationCoordinate2DMake(35.6735408, 139.570303);
    self.tokyoAnno.title = @"Tokyo";

    self.londonAnno = [[MKPointAnnotation alloc] init];
    self.londonAnno.coordinate = CLLocationCoordinate2DMake(51.5287718, -0.2416816);
    self.londonAnno.title = @"London";

    self.sanFranciscoAnno = [[MKPointAnnotation alloc] init];
    self.sanFranciscoAnno.coordinate = CLLocationCoordinate2DMake(37.757815, -122.5076401);
    self.sanFranciscoAnno.title = @"San Franciso";

    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnno.title = @"Current";

    [self.mapView addAnnotations:@[self.tokyoAnno, self.londonAnno, self.sanFranciscoAnno]];
}

- (IBAction)switchChanged:(id)sender {
    if (self.switchField.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    } else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    if (!self.mapIsMoving) {
        [self centerMap:self.currentAnno];
    }
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

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.mapIsMoving = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.mapIsMoving = NO;
}

@end
