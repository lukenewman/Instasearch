//
//  FeedCollectionViewController.m
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "FeedCollectionViewController.h"
#import "FeedCollectionViewFlowLayout.h"
#import "NetworkManager.h"
#import "Post.h"
#import "PhotoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FeedCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *imageData;

@end

@implementation FeedCollectionViewController

static NSString * const photoCellReuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideNavBar];
    self.navigationItem.title = @"Feed";
    
    [self setupCollectionView];
    
    self.imageData = [NSMutableArray array];
    
    NetworkManager *manager = [NetworkManager manager];
    [manager getUsersFeedWithCompletion:^(NSArray *posts) {
        [self.imageData addObjectsFromArray:posts];
        [self.collectionView reloadData];
    }];
}

- (void)hideNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)setupCollectionView {
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:photoCellReuseIdentifier];
    self.collectionView.collectionViewLayout = [[FeedCollectionViewFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:photoCellReuseIdentifier forIndexPath:indexPath];
    Post *post = (Post *)[self.imageData objectAtIndex:indexPath.row];
    
    // Load more images if we're 5 away from the end.
    if (indexPath.row + 5 == self.imageData.count) {
        NSLog(@"Loading more photos...");
        NetworkManager *manager = [NetworkManager manager];
        [manager getMorePhotosWithCompletion:^(NSArray *posts) {
            [self.imageData addObjectsFromArray:posts];
            [self.collectionView reloadData];
        }];
    }
    
    [cell.postImageView sd_setImageWithURL:[NSURL URLWithString:post.urlString]
                          placeholderImage:[UIImage new]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     post.image = image;
                                 }];
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
