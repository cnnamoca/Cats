//
//  SearchViewController.h
//  Cats
//
//  Created by Carlo Namoca on 2017-10-24.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol SearchDelegate <NSObject>
- (void)textDidUpdate:(NSString *)text;
- (void)returnLocationBasedPhotos: (NSArray *) photosArr;

@end

@interface SearchViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, weak) id <SearchDelegate> delegate;

@property (nonatomic) BOOL locationBool;


@end
