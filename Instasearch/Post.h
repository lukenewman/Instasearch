//
//  Post.h
//  Instasearch
//
//  Created by Luke Newman on 11/7/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Post : NSObject

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) UIImage *image;
@property int likes;
@property int numberOfComments;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *profilePictureURLString;
@property (nonatomic, strong) UIImage *profilePicture;
@property (nonatomic, strong) NSString *createdAt;

+ (id)postFromDictionary:(NSDictionary *)data;

@end
