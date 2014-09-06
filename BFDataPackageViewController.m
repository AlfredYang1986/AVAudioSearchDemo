//
//  BFDataPackageViewController.m
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFDataPackageViewController.h"
#import "BFDataPackageXMLParser.h"

@interface BFDataPackageViewController ()

@end

@implementation BFDataPackageViewController {
    BFDataPackageXMLParser * par;
}

#pragma mark -- view synthesize
@synthesize packageNameLabel = _packageNameLabel;
@synthesize urlTextField = _urlTextField;
@synthesize messageTextField = _messageTextField;
@synthesize authTokenLabel = _authTokenLabel;

#pragma mark -- other args synthesize
@synthesize bDownload = _bDownload;
@synthesize pathHelper = _pathHelper;

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
    if (par == nil) {
        par = [[BFDataPackageXMLParser alloc]init];
    }
    [self resetView];
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

#pragma mark -- private mesthods

- (IBAction)downloadDataPackage
{
    [self.pathHelper downloadDataPackage];
    [self resetView];
}

- (IBAction)deleteDataPackage
{
    [self.pathHelper deleteDataPackage];
    [self resetView];
}

-(void)resetView
{
    NSDictionary* attrs = [par parserWithURL:[self.pathHelper getDownloadDataPackagePathWithName:@"megawardrobe.xml"]];
    
    self.packageNameLabel.text = @"megawardrobe";
    self.urlTextField.text = [attrs objectForKey:@"url"];
    self.authTokenLabel.text = @"test";
    self.messageTextField.text = @"input";
}
@end