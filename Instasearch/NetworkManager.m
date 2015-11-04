//
//  NetworkManager.m
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "NetworkManager.h"

#import "AFHTTPRequestOperationManager.h"

@interface NetworkManager()

@property (strong, nonatomic) NSString *accessToken;

@end

@implementation NetworkManager

static NSString *const baseURL = @"https://api.instagram.com/v1/";
static NSString *const usersFeedPath = @"users/self/feed";

+ (NetworkManager *)manager {
    static NetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[NetworkManager alloc] init];
    });
    
    return manager;
}

- (void)setAccessToken:(NSString *)accessToken {
    [NetworkManager manager].accessToken = accessToken;
//    self.accessToken = accessToken;
}

- (void)getUsersFeedWithCompletion:(void (^) (UIImage *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *path = [NSString stringWithFormat:@"%@%@", baseURL, usersFeedPath];
    NSDictionary *params = @{@"access_token" : self.accessToken, @"count" : @20};
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"SUCCESS: %@", responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"FAILURE: %@", error);
    }];
}

@end
