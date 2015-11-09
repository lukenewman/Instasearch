//
//  PhotoCollectionViewCell.m
//  Instasearch
//
//  Created by Luke Newman on 11/7/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Masonry.h"
#import <ChameleonFramework/Chameleon.h>

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Post image view.
        self.postImageView = [[UIImageView alloc] initWithImage:[UIImage new]];
        self.postImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.postImageView];
        [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        // Shadow
        CALayer *layer = self.postImageView.layer;
        layer.shadowColor = FlatGrayDark.CGColor;
        layer.shadowOffset = CGSizeMake(0, 5);
        layer.shadowRadius = 5.0f;
        layer.shadowOpacity = 0.5f;
        
        // Username image view.
        CGRect userImageViewFrame = CGRectMake(0, 0, 30, 30);
        self.userImageView = [[UIImageView alloc] initWithFrame:userImageViewFrame];
        self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2.0;
        self.userImageView.layer.borderColor = FlatGray.CGColor;
        self.userImageView.layer.borderWidth = 0.5;
        self.userImageView.clipsToBounds = YES;
        [self addSubview:self.userImageView];
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self.mas_top).with.offset(70);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
        }];
        
        // Username label.
        CGRect labelFrame = CGRectMake(0, 0, self.bounds.size.width, 30);
        self.usernameLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.usernameLabel.textAlignment = NSTextAlignmentCenter;
        self.usernameLabel.font = [UIFont fontWithName:@"Aleo-Light" size:15];
        self.usernameLabel.textColor = FlatGray;
        [self addSubview:self.usernameLabel];
        [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).with.offset(25);
            make.trailing.equalTo(self);
            make.top.equalTo(self.mas_top).with.offset(70);
            make.height.equalTo(@30);
        }];
        
        // Likes label.
        labelFrame = CGRectMake(0, 0, self.bounds.size.width / 2, 15);
        UIFont *aleo12 = [UIFont fontWithName:@"Aleo-Light" size:12];
        self.likesLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.likesLabel.textAlignment = NSTextAlignmentLeft;
        self.likesLabel.font = aleo12;
        self.likesLabel.textColor = FlatGray;
        [self addSubview:self.likesLabel];
        [self.likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_bottom).with.offset(-90);
            make.height.equalTo(@15);
        }];
        
        // Comments label.
        self.commentsLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.commentsLabel.textAlignment = NSTextAlignmentRight;
        self.commentsLabel.font = aleo12;
        self.commentsLabel.textColor = FlatGray;
        [self addSubview:self.commentsLabel];
        [self.commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_centerX);
            make.trailing.equalTo(self);
            make.top.equalTo(self.mas_bottom).with.offset(-90);
            make.height.equalTo(@15);
        }];
        
        // CreatedAt label.
        self.createdAtLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.createdAtLabel.textAlignment = NSTextAlignmentCenter;
        self.createdAtLabel.font = aleo12;
        self.createdAtLabel.textColor = FlatGray;
        [self addSubview:self.createdAtLabel];
        [self.createdAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).with.offset(-90);
            make.height.equalTo(@15);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        // Caption text view.
        CGRect captionFrame = CGRectMake(0, 0, self.bounds.size.width, 100);
        self.captionTextView = [[UITextView alloc] initWithFrame:captionFrame];
        self.captionTextView.font = aleo12;
        self.captionTextView.textColor = FlatGrayDark;
        self.captionTextView.editable = NO;
        [self addSubview:self.captionTextView];
        [self.captionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likesLabel.mas_bottom);
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        // Activity indicator.
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallScale tintColor:FlatGrayDark size:40.0f];
        self.activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
        [self addSubview:self.activityIndicatorView];
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).centerOffset(CGPointMake(-20, -20));
        }];
        [self.activityIndicatorView startAnimating];
        
        self.userImageView.alpha = 0.0;
        self.usernameLabel.alpha = 0.0;
        self.likesLabel.alpha = 0.0;
        self.commentsLabel.alpha = 0.0;
        self.createdAtLabel.alpha = 0.0;
        self.captionTextView.alpha = 0.0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    NSLog(@"setSelected: %@", selected ? @"YES" : @"NO");
    CGFloat newAlpha = selected ? 1.0 : 0.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.usernameLabel.alpha = newAlpha;
        self.userImageView.alpha = newAlpha;
        self.likesLabel.alpha = newAlpha;
        self.commentsLabel.alpha = newAlpha;
        self.createdAtLabel.alpha = newAlpha;
        self.captionTextView.alpha = newAlpha;
    }];
}

@end
