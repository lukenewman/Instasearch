//
//  NetworkManager.m
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "NetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "Post.h"

@interface NetworkManager()

@property (strong, nonatomic) NSString *nextURLString;

@end

@implementation NetworkManager

@synthesize accessToken;

static NSString *const baseURL = @"https://api.instagram.com/v1/";
static NSString *const usersFeedPath = @"users/self/feed";

+ (NetworkManager *)manager {
    static NetworkManager *manager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)setAccessToken:(NSString *)newAccessToken {
    accessToken = newAccessToken;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accessToken forKey:@"INSTASEARCHaccessToken"];
    [userDefaults synchronize];
}

- (NSString *)accessToken {
    if (!accessToken) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        accessToken = [userDefaults objectForKey:@"INSTASEARCHaccessToken"];
    }
    return accessToken;
}

- (void)getUsersFeedWithCompletion:(void (^) (NSArray *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *path = [NSString stringWithFormat:@"%@%@", baseURL, usersFeedPath];
    NSDictionary *params = @{@"access_token" : self.accessToken, @"count" : @20};
    
    __block NSMutableArray *fetchedPosts = [NSMutableArray array];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"SUCCESS: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            
            self.nextURLString = responseDict[@"pagination"][@"next_url"];
            
            NSArray *data = responseDict[@"data"];
            for (NSDictionary *post in data) {
                if ([post[@"type"] isEqualToString:@"image"]) {
                    Post *fetchedPost = [Post postFromDictionary:post];
                    [fetchedPosts addObject:fetchedPost];
                }
            }
            
            NSLog(@"returning %lu fetched posts", (unsigned long)fetchedPosts.count);
            completion(fetchedPosts);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"FAILURE: %@", error);
    }];
}

- (void)getMorePhotosWithCompletion:(void (^) (NSArray *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"access_token" : self.accessToken, @"count" : @20};
    
    __block NSMutableArray *fetchedPosts = [NSMutableArray array];
    
    [manager GET:self.nextURLString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            NSArray *data = responseDict[@"data"];
            for (NSDictionary *post in data) {
                if ([post[@"type"] isEqualToString:@"image"]) {
                    Post *fetchedPost = [Post postFromDictionary:post];
                    [fetchedPosts addObject:fetchedPost];
                }
            }
            
            NSLog(@"returning %lu fetched posts", (unsigned long)fetchedPosts.count);
            completion(fetchedPosts);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"FAILURE: %@", error);
    }];
}

@end
