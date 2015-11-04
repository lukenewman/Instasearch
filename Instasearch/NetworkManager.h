//
//  NetworkManager.h
//  Instasearch
//
//  Created by Luke Newman on 11/3/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (NetworkManager *)manager;
- (void)setAccessToken:(NSString *)accessToken;

@end
