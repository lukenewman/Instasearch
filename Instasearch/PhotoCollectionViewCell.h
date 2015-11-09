//
//  PhotoCollectionViewCell.h
//  Instasearch
//
//  Created by Luke Newman on 11/7/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *postImageView;
@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *likesLabel;
@property (strong, nonatomic) UILabel *commentsLabel;
@property (strong, nonatomic) UILabel *createdAtLabel;
@property (strong, nonatomic) UITextView *captionTextView;

@end
