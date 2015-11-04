//
//  DetailViewController.h
//  Instasearch
//
//  Created by Luke Newman on 10/31/15.
//  Copyright © 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

