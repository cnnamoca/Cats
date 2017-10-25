//
//  Cat.h
//  Cats
//
//  Created by Carlo Namoca on 2017-10-23.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Cat : NSObject <MKAnnotation>

@property (assign, nonatomic) NSInteger catID;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *secret;
@property (assign, nonatomic) NSInteger server;
@property (assign, nonatomic) NSInteger farm;
@property (strong, nonatomic) NSString *imageTitle;

@property (strong, nonatomic) UIImage *image;

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(instancetype)initWithInfo:(NSDictionary*)infoDict;
- (void)setMyCoordinate:(CLLocationCoordinate2D)myCoordinate;

@end
