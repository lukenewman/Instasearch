//
//  PhotoCollectionViewCell.m
//  Instasearch
//
//  Created by Luke Newman on 11/7/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Masonry.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.postImageView = [[UIImageView alloc] initWithImage:[UIImage new]];
        self.postImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.postImageView];
        [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
