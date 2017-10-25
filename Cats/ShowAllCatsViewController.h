//
//  ShowAllCatsViewController.h
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Cat.h"

@interface ShowAllCatsViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) NSArray<Cat *> *allCatsArr;

@end
