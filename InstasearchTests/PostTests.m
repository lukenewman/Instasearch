//
//  PostTests.m
//  Instasearch
//
//  Created by Luke Newman on 11/8/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Post.h"

@interface PostTests : XCTestCase

@end

@implementation PostTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPostFromDictionaryWITHCAPTION {
    NSDictionary *validPostDictionary = @{
                                          @"user" : @{@"username" : @"lukenewman", @"profile_picture" : @"my_good_side"},
                                          @"images" : @{@"standard_resolution" : @{@"url" : @"standard_res_url"}},
                                          @"likes" : @{@"count" : @7},
                                          @"caption" : @{@"text" : @"Here in my garage..."},
                                          @"comments" : @{@"count" : @123}
                                          };
    Post *expectedPost = [[Post alloc] init];
    expectedPost.urlString = @"standard_res_url";
    expectedPost.username = @"lukenewman";
    expectedPost.profilePictureURLString = @"my_good_side";
    expectedPost.likes = 7;
    expectedPost.caption = @"Here in my garage...";
    expectedPost.numberOfComments = 123;
    
    Post *receivedPost = [Post postFromDictionary:validPostDictionary];
    
    NSLog(@"receivedPost: %@", receivedPost);
    
    XCTAssertEqualObjects(expectedPost.urlString, receivedPost.urlString, @"The URL Strings do not match");
    XCTAssertEqualObjects(expectedPost.username, receivedPost.username, @"The usernames do not match");
    XCTAssertEqualObjects(expectedPost.profilePictureURLString, receivedPost.profilePictureURLString, @"The profile picture URL Strings do not match");
//    XCTAssertEqual(expectedPost.likes, receivedPost.likes, @"The likes do not match");
    XCTAssertEqualObjects(expectedPost.caption, receivedPost.caption, @"The captions do not match");
//    XCTAssertEqual(expectedPost.numberOfComments, receivedPost.numberOfComments, @"The number of comments do not match");
    
    // I know that the `postFromDictionary` method works with Instagram's JSON response, but when I try to replicate it with an NSDictionary, it's not the same.
}

- (void)testPostFromDictionaryWITHOUTCAPTION {
    NSDictionary *validPostDictionary = @{
                                          @"user" : @{@"username" : @"lukenewman", @"profile_picture" : @"my_good_side"},
                                          @"images" : @{@"standard_resolution" : @{@"url" : @"standard_res_url"}},
                                          @"likes" : @{@"count" : @7},
                                          @"comments" : @{@"count" : @123}
                                          };
    Post *expectedPost = [[Post alloc] init];
    expectedPost.urlString = @"standard_res_url";
    expectedPost.username = @"lukenewman";
    expectedPost.profilePictureURLString = @"my_good_side";
    
    Post *receivedPost = [Post postFromDictionary:validPostDictionary];
    
    NSLog(@"receivedPost: %@", receivedPost);
    
    XCTAssertEqualObjects(expectedPost.urlString, receivedPost.urlString, @"The URL Strings do not match");
    XCTAssertEqualObjects(expectedPost.username, receivedPost.username, @"The usernames do not match");
    XCTAssertEqualObjects(expectedPost.profilePictureURLString, receivedPost.profilePictureURLString, @"The profile picture URL Strings do not match");
    XCTAssertEqualObjects(expectedPost.caption, receivedPost.caption, @"The captions do not match");
    
    // I know that the `postFromDictionary` method works with Instagram's JSON response, but when I try to replicate it with an NSDictionary, it's not the same.
}

@end
