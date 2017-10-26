//
//  SearchViewController.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "SearchViewController.h"
#import <MapKit/MapKit.h>
#import "Cat.h"

@interface SearchViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *locSwitch;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite) CLLocationCoordinate2D userCoordinate;

@property (strong, nonatomic) NSString *apiKey;
//
@property (strong, nonatomic) NSArray <Cat*> *catPhotosArr;
//
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.apiKey = @"56078fa33f4872fefaa96478954f2929";
    //location manager stuff
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
    self.locationManager.delegate = self;
    //end location manager stuff
    
    self.textField.delegate = self;
    
    self.locationBool = NO;
}

#pragma mark - search button
- (IBAction)saveInfo:(UIButton *)sender
{
    if (self.locationBool == YES){
        [self getImageForLocation];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSString * text = self.textField.text;
        [self.delegate textDidUpdate:text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - cancel button
- (IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - location manager stuff

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (IBAction)locationSwitch:(UISwitch *)sender
{
    if ([sender isOn])
    {
        self.locationBool = YES;
        [self.locationManager requestWhenInUseAuthorization];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            self.locationManager.delegate = self;
            [self.locationManager requestLocation];
        }
    }

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.userCoordinate = [[locations lastObject] coordinate];
}

-(void)getImageForLocation
{
    NSString *string = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&has_geo=1&lat=%f&lon=%f&radius=&format=json&nojsoncallback=1", self.apiKey, self.textField.text, self.userCoordinate.latitude, self.userCoordinate.longitude];

    NSURL *url = [NSURL URLWithString:string];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDataTask *dataTask =  [urlSession dataTaskWithRequest:urlRequest
                completionHandler:^(NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error)
    {
       if (error)
       {
           NSLog(@"Error gathering data");
       } else
       {

           NSError *jsonError = nil;
           NSDictionary *catDict = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
           if(jsonError)
           {
               NSLog(@"jsonError: %@", jsonError.localizedDescription);
           }

           NSMutableArray *temp = [@[] mutableCopy];
           NSDictionary *cats = catDict[@"photos"];
           NSArray * catArr = cats[@"photo"];

           for (NSDictionary *info in catArr){
               Cat *cat = [[Cat alloc]initWithInfo:info];
               [temp addObject:cat];
           }

           self.catPhotosArr = [temp copy];

           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               [self.delegate returnLocationBasedPhotos:self.catPhotosArr];
           }];
       }
    }];

    [dataTask resume];

}
@end
