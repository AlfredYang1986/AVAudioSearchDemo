//
//  BFRecordDetailViewController.h
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRecordingPathHelper.h"

@interface BFRecordDetailViewController : UIViewController
@property (nonatomic, weak) BFRecordingPathHelper * pathHelper;
@property (weak, nonatomic) IBOutlet UILabel *recordNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordFormatLabel;
@end
