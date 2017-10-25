//
//  ShowAllViewController.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "ShowAllViewController.h"


@interface ShowAllViewController()

@property (weak, nonatomic) IBOutlet MKMapView *showAllMapView;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.showAllMapView.mapType = MKMapTypeStandard;
//    [self.showAllMapView setZoomEnabled:YES];
//    [self.showAllMapView setRotateEnabled:true];
//    [self.showAllMapView setScrollEnabled:true];
//    [self.showAllMapView showsScale];
//    self.showAllMapView.delegate = self;
//
//    for (int i = 0; i < self.allCatsArr.count; i++){
//    NSString *string = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=39019b76a9155a057a3cb897b59c21fb&photo_id=%li&format=json&nojsoncallback=1", self.allCatsArr[i].catID];
//
//    NSURL *url = [NSURL URLWithString:string];
//
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
//
//    NSURLSessionDataTask *dataTask =  [urlSession dataTaskWithRequest:urlRequest
//                completionHandler:^(NSData * _Nullable data,
//                                    NSURLResponse * _Nullable response,
//                                    NSError * _Nullable error)
//    {
//       if (error)
//       {
//           NSLog(@"Error gathering data");
//       } else
//       {
//
//           NSError *jsonError = nil;
//           NSDictionary *geoDict = [NSJSONSerialization JSONObjectWithData:data
//                                                                   options:0
//                                                                     error:&jsonError];
//           if(jsonError)
//           {
//               NSLog(@"jsonError: %@", jsonError.localizedDescription);
//           }
//           
//           [self.allCatsArr[i] setMyCoordinate:CLLocationCoordinate2DMake([geoDict[@"photo"][@"location"][@"latitude"] floatValue], [geoDict[@"photo"][@"location"][@"longitude"] floatValue])];
//           MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
//           self.showAllMapView.region = MKCoordinateRegionMake(self.allCatsArr[i].coordinate, span);
//           MKPointAnnotation *catAnn = [MKPointAnnotation new];
//           catAnn.coordinate = self.allCatsArr[i].coordinate;
//           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//               self.showAllMapView.region = MKCoordinateRegionMake(self.allCatsArr[i].coordinate, span);
//               [self.showAllMapView addAnnotation:self.allCatsArr[i]];
//           }];
//       }
//    }];
//
//    [dataTask resume];
//    }
    
//    for (int i = 0; i < self.allCatsArr.count; i++)
//    {
//        MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
//        self.mapView.region = MKCoordinateRegionMake(self.allCatsArr[i].coordinate, span);
//        MKPointAnnotation *catAnn = [MKPointAnnotation new];
//        catAnn.coordinate = self.allCatsArr[i].coordinate;
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.mapView.region = MKCoordinateRegionMake(self.allCatsArr[i].coordinate, span);
//            [self.mapView addAnnotation:self.allCatsArr[i]];
//        }];
//    }
}


@end
