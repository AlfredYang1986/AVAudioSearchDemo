//
//  BFDataPackageViewController.h
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRecordingPathHelper.h"

@interface BFDataPackageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *urlTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;
@property (weak, nonatomic) IBOutlet UILabel *authTokenLabel;

@property (nonatomic) BOOL bDownload;
@property (nonatomic, weak) BFRecordingPathHelper * pathHelper;
@end
