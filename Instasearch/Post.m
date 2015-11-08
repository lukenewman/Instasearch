//
//  Post.m
//  Instasearch
//
//  Created by Luke Newman on 11/7/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "Post.h"

@implementation Post

+ (id)postFromDictionary:(NSDictionary *)data {
    Post *newPost = [[Post alloc] init];
    
    newPost.urlString = data[@"images"][@"standard_resolution"][@"url"];
    newPost.username = data[@"user"][@"username"];
    newPost.profilePictureURLString = data[@"user"][@"profile_picture"];
    newPost.likes = (int)data[@"likes"][@"count"];
    newPost.caption = data[@"caption"][@"text"];
    newPost.createdAt = [NSDate dateWithTimeIntervalSince1970: (int)data[@"created_time"]];
    
    return newPost;
}

@end
