//
//  BFResultDetailViewController.m
//  Demo
//
//  Created by Alfred Yang on 7/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFResultDetailViewController.h"

@interface BFResultDetailViewController ()

@end

@implementation BFResultDetailViewController

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize brandLabel = _brandLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize priceLabel = _priceLabel;
@synthesize detail = _detail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = [self.detail objectForKey:@"Title"];
    self.brandLabel.text = [self.detail objectForKey:@"Brand"];
    self.categoryLabel.text = [self.detail objectForKey:@"Category"];
    self.priceLabel.text = [NSString stringWithFormat:@"%@", (NSNumber*)[self.detail objectForKey:@"Price"]];
   
    NSURL* url = [NSURL URLWithString:[self.detail objectForKeyedSubscript:@"ImageURL"]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [self.imageView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
