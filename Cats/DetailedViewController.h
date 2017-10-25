//
//  DetailedViewController.h
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Cat.h"

@interface DetailedViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) Cat *cat;

@end
