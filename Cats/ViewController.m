//
//  ViewController.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-23.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "ViewController.h"
#import "myCollectionViewCell.h"
#import "DetailedViewController.h"
#import "SearchViewController.h"
#import "ShowAllViewController.m"
#import "Cat.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *myLayout;
@property (strong, nonatomic) NSArray <Cat*> *catPhotosArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup URL STUFF
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=39019b76a9155a057a3cb897b59c21fb&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1"];
    
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
                [self.collectionView reloadData];
            }];
        }
    }];
    
    [dataTask resume];
    //end URL setup
    
    
    self.collectionView.dataSource = self;
    
    [self setupMyLayout];
    self.collectionView.collectionViewLayout = self.myLayout;
    
    //tap gesture set up
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToDetails:)];
    [self.collectionView addGestureRecognizer:tapGesture];
    
    self.collectionView.userInteractionEnabled = YES;
    
}

#pragma mark - nav

- (IBAction)search:(id)sender
{
    [self performSegueWithIdentifier:@"searchSegue" sender:sender];
}

- (IBAction)showAll:(id)sender
{
    [self performSegueWithIdentifier:@"showAllSegue" sender:sender];
}


#pragma mark - tap gesture setup
-(void) goToDetails: (UITapGestureRecognizer *)sender
{
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
    [self performSegueWithIdentifier:@"mapSegue" sender:indexPath];
}

#pragma mark - segue methods
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mapSegue"])
    {
        DetailedViewController *detailedVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailedVC.cat = self.catPhotosArr[indexPath.row];

    }
    else if ([segue.identifier isEqualToString:@"showAllSegue"])
    {
//        #warning COME BACK TO FIX
        
        ShowAllViewController *showallVC = segue.destinationViewController;
        showallVC.allCatsArr = self.catPhotosArr;
    }
}

#pragma mark - collection view layout
-(void)setupMyLayout
{
    self.myLayout = [UICollectionViewFlowLayout new];
    self.myLayout.itemSize = CGSizeMake(200, 200);
    self.myLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.myLayout.minimumInteritemSpacing = 15;
    self.myLayout.minimumLineSpacing = 10;

}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.catPhotosArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    Cat *cat = self.catPhotosArr[indexPath.row];
    
    NSString *catURL = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%ld/%ld_%@.jpg", (long)cat.farm, (long)cat.server, (long)cat.catID, cat.secret];
    
    NSURL * url = [NSURL URLWithString:catURL];
    NSError * error;
    NSData * data = [NSData dataWithContentsOfURL:url
                                          options:NSDataReadingUncached
                                            error:&error];
    UIImage * image = [UIImage imageWithData:data];
    
    cat.image = image;
    
    cell.cat = self.catPhotosArr[indexPath.row];
    cell.label.text = cat.imageTitle;
    cell.imageView.image = cat.image;
    
    return cell;
}


@end
