//
//  NetworkManager.h
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

@property (strong, nonatomic) NSString *accessToken;

+ (NetworkManager *)manager;
- (void)getUsersFeedWithCompletion:(void (^) (NSArray *))completion;
- (void)getMorePhotosWithCompletion:(void (^) (NSArray *))completion;

@end
