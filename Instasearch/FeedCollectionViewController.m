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
#import "Masonry.h"
#import "LoginViewController.h"

@interface FeedCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *imageData;

@end

@implementation FeedCollectionViewController

static NSString * const photoCellReuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupCollectionView];
    
    self.imageData = [NSMutableArray array];
    
    NetworkManager *manager = [NetworkManager manager];
    [manager getUsersFeedWithCompletion:^(NSArray *posts) {
        [self.imageData addObjectsFromArray:posts];
        [self.collectionView reloadData];
    }];
}

- (void)setupNavigationBar {
    // Make nav bar flat/invisible
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    // Set title and font
    self.navigationItem.title = @"Main Feed";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Aleo-Regular" size:20]
                                                                      }];
}

- (void)setupCollectionView {
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:photoCellReuseIdentifier];
    self.collectionView.collectionViewLayout = [[FeedCollectionViewFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30);
}

- (IBAction)showLogout:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Do you want to sign out?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *logOutAction = [UIAlertAction actionWithTitle:@"Sign Out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self logOut];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:logOutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logOut {
    [self performSegueWithIdentifier:@"toLogin" sender:self];
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
        NetworkManager *manager = [NetworkManager manager];
        [manager getMorePhotosWithCompletion:^(NSArray *posts) {
            [self.imageData addObjectsFromArray:posts];
            [self.collectionView reloadData];
        }];
    }
    
    if (!post.image) {
        [cell.postImageView sd_setImageWithURL:[NSURL URLWithString:post.urlString]
                              placeholderImage:[UIImage new]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         cell.activityIndicatorView.hidden = YES;
                                         [cell.activityIndicatorView stopAnimating];
                                         post.image = image;
                                     }];
    } else {
        [cell.activityIndicatorView stopAnimating];
        cell.postImageView.image = post.image;
    }
    
    if (!post.profilePicture) {
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:post.profilePictureURLString]
                              placeholderImage:[UIImage new]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         post.profilePicture = image;
                                     }];
    } else {
        cell.userImageView.image = post.profilePicture;
    }
    
    CGFloat usernameWidth = [post.username boundingRectWithSize:cell.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:cell.usernameLabel.font } context:nil].size.width;
    CGFloat userImageViewTrailingOffset = (usernameWidth / 2.0);
    [cell.userImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(cell.mas_centerX).with.offset(-userImageViewTrailingOffset);
        make.top.equalTo(cell.mas_top).with.offset(70);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", post.username];
    cell.likesLabel.text = [NSString stringWithFormat:@"%d likes", post.likes];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%d comments", post.numberOfComments];
    cell.createdAtLabel.text = post.createdAt;
    cell.captionTextView.text = post.caption;
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
////    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:photoCellReuseIdentifier forIndexPath:indexPath];
//    
//    NSLog(@"select");
//    self.selectedIndexPath = indexPath;
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"deselect");
//    self.selectedIndexPath = nil;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"SHOULD SELECT - indexPath = %@", indexPath);
//    if (self.selectedIndexPath == indexPath) {
//        return NO;
//    }
//    self.selectedIndexPath = indexPath;
//    return YES;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"SHOULD DESELECT - indexPath = %@", indexPath);
//    if (self.selectedIndexPath == indexPath) {
//        return YES;
//    }
//    return NO;
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LoginViewController *loginVC = (LoginViewController *)segue.destinationViewController;
    [loginVC logOut];
}


@end
