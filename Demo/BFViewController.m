//
//  BFViewController.m
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "BFRecordingPathHelper.h"
#import "BFRecordsTableViewController.h"
#import "BFDataPackageViewController.h"

@interface BFViewController () <AVAudioRecorderDelegate>
@property (nonatomic, strong) BFRecordingPathHelper* pathHelper;
@end

@implementation BFViewController {
    BOOL bRecording;
    
    //Variable setup for access in the class
    NSURL *recordedTmpFile;
    AVAudioRecorder *recorder;
    
    BOOL bCanRecord;

    AVAudioSession * audioSession;
}

@synthesize statusView = _statusView;
@synthesize startButton = _startButton;
@synthesize stopButton = _stopButton;
@synthesize pathHelper = _pathHelper;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    bRecording = false;
    [self.stopButton setEnabled:false];
    self.pathHelper = [[BFRecordingPathHelper alloc]init];
    
    NSError * error = nil;
    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error]; //设置音频类别，这里表示当应用启动，停掉后台其他音频
    [audioSession setActive:YES error: &error];//设置当前应用音频活跃性
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording {
    
    if (!bRecording) {
        
        if (![self canRecord]) {
            [[[UIAlertView alloc] initWithTitle:nil
                              message:[NSString stringWithFormat:@"%@需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风", @"Demo"]
                              delegate:nil
                              cancelButtonTitle:@"好"
                              otherButtonTitles:nil] show];
            return;
        }
        
        
        NSLog(@"Start Recording ... ");
        
        //This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 16000.0],AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                  [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                  [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                  [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                  [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,nil];
        
        recordedTmpFile = [self.pathHelper getNextRecordingPath];
        NSLog(@"Using File called: %@", recordedTmpFile);
        //Setup the recorder to use this file and record to it.
        NSError *error = [[NSError alloc]init];
        recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error: (&error)];
        [recorder setDelegate:self];
        BOOL re = [recorder prepareToRecord];
        NSLog(@"%d", re);
        
        [recorder record];
        NSLog(@"%d", re);
        
        bRecording = true;
        [self.startButton setEnabled:false];
        [self.stopButton setEnabled:true];
    }
    
}

- (IBAction)stopRecording {
    
    if (bRecording) {
        NSLog(@"Stop Recording ... ");
        NSLog(@"Using File called: %@",recordedTmpFile);
        //Stop the recorder.
        [recorder stop];
        [self.startButton setEnabled:true];
        [self.stopButton setEnabled:false];
        bRecording = false;
        self.pathHelper = [[BFRecordingPathHelper alloc]init];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Records"]) {
        ((BFRecordsTableViewController*)segue.destinationViewController).pathHelper = self.pathHelper;
    } else {
        ((BFDataPackageViewController*)segue.destinationViewController).pathHelper = self.pathHelper;
    }
}

///新增api,获取录音权限. 返回值,YES为无拒绝,NO为拒绝录音.
- (BOOL)canRecord
{
//    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}
@end
