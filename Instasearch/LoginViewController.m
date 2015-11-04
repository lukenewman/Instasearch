//
//  LoginViewController.m
//  Instasearch
//
//  Created by Luke Newman on 10/31/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import "LoginViewController.h"
#import <SafariServices/SafariServices.h>
#import "NetworkManager.h"

@interface LoginViewController () <SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property SFSafariViewController *safariVC;

@end

@implementation LoginViewController

static NSString *kCLIENT_ID = @"bb83a2ab165140f285d15ee4e57885e9";
static NSString *kCLIENT_SECRET = @"aee089ed0c7e42d78ec901908fc24938";
static NSString *kREDIRECT_URI = @"instasearch://";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signInButton.layer.cornerRadius = self.signInButton.frame.size.height / 2.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(safariRedirect:) name:@"kCloseSafariViewControllerNotification" object:nil];
}

- (IBAction)signIn:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=basic+likes", kCLIENT_ID, kREDIRECT_URI];
    NSURL *url = [NSURL URLWithString:urlString];
    
    self.safariVC = [[SFSafariViewController alloc] initWithURL:url];
    self.safariVC.delegate = self;
    
    [self presentViewController:self.safariVC animated:YES completion:nil];
}

- (void)safariRedirect:(NSNotification *)notification {
    [self.safariVC dismissViewControllerAnimated:YES completion:nil];
    NSString *accessToken = [self extractAccessToken: [notification.object absoluteString]];
    
    if ([accessToken isEqualToString:@"ERROR"]) {
        // ALERT: Error retreiving access token.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Oops! Something went wrong when we talked to Instagram..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"It's not your fault!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        NetworkManager *manager = [NetworkManager manager];
        [manager setAccessToken: accessToken];
        [self performSegueWithIdentifier:@"showFeed" sender:self];
    }
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)extractAccessToken:(NSString *)url {
    NSRange accessTokenRange = [url rangeOfString:@"access_token="];
    if (accessTokenRange.length > 0) {
        NSString *accessToken = [url componentsSeparatedByString:@"access_token="][1];
        NSLog(@"extracted access token: %@", accessToken);
        return accessToken;
    } else {
        return @"ERROR";
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"segueing...");
}


@end
