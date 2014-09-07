//
//  BFResultDetailViewController.h
//  Demo
//
//  Created by Alfred Yang on 7/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFResultDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIWebView *imageView;

@property (strong, nonatomic) NSDictionary* detail;
@end
