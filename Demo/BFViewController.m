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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording {
    
    if (!bRecording) {
        NSLog(@"Start Recording ... ");
        
        //Begin the recording session.
        //Error handling removed.  Please add to your own code.
        
        //Setup the dictionary object with all the recording settings that this
        //Recording sessoin will use
        //Its not clear to me which of these are required and which are the bare minimum.
        //This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
        NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
        
//        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
        [recordSetting setValue :[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        
        [recordSetting setValue:[NSNumber numberWithFloat: 16000.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
        [recordSetting setValue:[NSNumber numberWithInt: 16] forKey:AVLinearPCMBitDepthKey];
        
        //Now that we have our settings we are going to instanciate an instance of our recorder instance.
        //Generate a temp file for use by the recording.
        //This sample was one I found online and seems to be a good choice for making a tmp file that
        //will not overwrite an existing one.
        //I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
        recordedTmpFile = [self.pathHelper getNextRecordingPath];
        NSLog(@"Using File called: %@", recordedTmpFile);
        //Setup the recorder to use this file and record to it.
        NSError *error = [[NSError alloc]init];
        recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error: (&error)];
        //Use the recorder to start the recording.
        //Im not sure why we set the delegate to self yet.
        //Found this in antother example, but Im fuzzy on this still.
        [recorder setDelegate:self];
        //We call this to start the recording process and initialize
        //the subsstems so that when we actually say "record" it starts right away.
        [recorder prepareToRecord];
        //Start the actual Recording
        [recorder record];
        //There is an optional method for doing the recording for a limited time see
        //[recorder recordForDuration:(NSTimeInterval) 10]
        
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
@end
