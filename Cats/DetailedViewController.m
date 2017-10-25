//
//  DetailedViewController.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *currentLocation;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard;
    [self.mapView setZoomEnabled:YES];
    [self.mapView setRotateEnabled:true];
    [self.mapView setScrollEnabled:true];
    [self.mapView showsScale];
    self.mapView.delegate = self;
    
    //setup url stuff
    NSString *string = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=39019b76a9155a057a3cb897b59c21fb&photo_id=%li&format=json&nojsoncallback=1", self.cat.catID];
    
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
           NSDictionary *geoDict = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
           if(jsonError)
           {
               NSLog(@"jsonError: %@", jsonError.localizedDescription);
           }
           
           [self.cat setMyCoordinate:CLLocationCoordinate2DMake([geoDict[@"photo"][@"location"][@"latitude"] floatValue], [geoDict[@"photo"][@"location"][@"longitude"] floatValue])];
           MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
           MKPointAnnotation *catAnn = [MKPointAnnotation new];
           catAnn.coordinate = self.cat.coordinate;
           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               self.mapView.region = MKCoordinateRegionMake(self.cat.coordinate, span);
               [self.mapView addAnnotation:self.cat];
           }];
       }
   }];

    [dataTask resume];
    //end setup url stuff
    
}


@end
