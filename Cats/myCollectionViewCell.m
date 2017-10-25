//
//  myCollectionViewCell.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-23.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "myCollectionViewCell.h"

@implementation myCollectionViewCell

-(void)makeCat:(Cat *)cat
{
    self.label.text = cat.imageTitle;
    self.imageView.image = cat.image;
    _cat = cat;
}

@end
