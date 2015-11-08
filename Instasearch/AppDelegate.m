//
//  AppDelegate.m
//  Instasearch
//
//  Created by Luke Newman on 10/31/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedCollectionViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [userDefaults objectForKey:@"INSTASEARCHaccessToken"];
    
    if (accessToken) {
        // Set initial view controller to FeedCollectionViewController
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedCollectionViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        self.window.rootViewController = feedVC;
        [self.window makeKeyAndVisible];
    }

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"openURL: %@", url);
    NSLog(@"sourceApplication: %@", sourceApplication);
    if ([sourceApplication isEqualToString:@"com.apple.SafariViewService"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCloseSafariViewControllerNotification" object:url];
    }
    return YES;
}

@end
