//
//  LoginViewControllerTests.m
//  Instasearch
//
//  Created by Luke Newman on 11/8/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"

@interface LoginViewControllerTests : XCTestCase

@property (nonatomic) LoginViewController *loginVC;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    [super setUp];
    self.loginVC = [[LoginViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogOut {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [userDefaults objectForKey:@"INSTASEARCHaccessToken"];
    if (accessToken) {
        [self.loginVC logOut];
        // Assert that accessToken isn't there.
        NSUserDefaults *newUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *accessToken = [newUserDefaults objectForKey:@"INSTASEARCHaccessToken"];
        XCTAssertEqualObjects(accessToken, nil);
    }
    XCTAssertEqual(1, 1);
}

- (void)testExtractAccessTokenERROR {
    NSString *stringWithoutAccessToken = @"AND THAT'S THE WAAAAAAAY... THE NEWS GOES";
    NSString *shouldBeERROR = [self.loginVC extractAccessToken:stringWithoutAccessToken];
    XCTAssertEqualObjects(shouldBeERROR, @"ERROR");
}

- (void)testExtractAccessTokenCORRECT {
    NSString *stringWithAccessToken = @"GRAAAASSSSSS... TASTES BAD access_token=M-m-m-morty";
    NSString *shouldBeMMMMorty = [self.loginVC extractAccessToken:stringWithAccessToken];
    XCTAssertEqualObjects(shouldBeMMMMorty, @"M-m-m-morty");
}

@end
