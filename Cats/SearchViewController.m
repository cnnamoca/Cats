//
//  SearchViewController.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "SearchViewController.h"
#import <MapKit/MapKit.h>

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *locSwitch;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //location manager stuff
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
    self.locationManager.delegate = self;
    //end location manager stuff
}


#pragma mark - search button
- (IBAction)saveInfo:(UIButton *)sender
{
    
}

#pragma mark - cancel button
- (IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - location manager methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
}
@end
