//
//  myCollectionViewCell.h
//  Cats
//
//  Created by Carlo Namoca on 2017-10-23.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"

@interface myCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) Cat *cat;

-(void)makeCat: (Cat*)cat;


@end
