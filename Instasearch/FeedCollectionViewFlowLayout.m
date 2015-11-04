//
//  FeedCollectionViewFlowLayout.m
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "FeedCollectionViewFlowLayout.h"

@implementation FeedCollectionViewFlowLayout

- (FeedCollectionViewFlowLayout *)init {
    self = [super init];
    
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 20;
        self.itemSize = CGSizeMake(self.collectionView.bounds.size.width - 60, self.collectionView.bounds.size.height - 60);
    }
    
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
