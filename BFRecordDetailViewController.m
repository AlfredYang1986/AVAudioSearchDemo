//
//  BFRecordDetailViewController.m
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFRecordDetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreFoundation/CoreFoundation.h>
#import "BFSearchResultViewController.h"

@interface BFRecordDetailViewController ()

@end

@implementation BFRecordDetailViewController

@synthesize pathHelper = _pathHelper;
@synthesize recordNameLabel = _recordNameLabel;
@synthesize recordLengthLabel = _recordLengthLabel;
@synthesize recordFormatLabel = _recordFormatLabel;

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
    NSString* fileName = [[self.pathHelper getEnumableRecordingPath]objectAtIndex:self.pathHelper.current];
    self.recordNameLabel.text = fileName;
    self.recordFormatLabel.text = [fileName substringFromIndex:[fileName rangeOfString:@"."].location];
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

#pragma mark -- public

- (IBAction)playCurrentRecord
{
    NSLog(@"play current record");
    SystemSoundID soundID;
    NSURL* sample = [self.pathHelper getCurrentRecordingPath];
    NSLog(@"%@", sample);
    
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(sample), &soundID);
    if (err) {
        NSLog(@"Error occurred assigning system sound!");
    }
    /*callback when finish*/
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished, (__bridge void *)(sample));
    /*start play record*/
    AudioServicesPlaySystemSound(soundID);
    CFRunLoopRun();
    
}

- (IBAction)searchWithCurrentRecord
{
    NSLog(@"search with current record");
    [self.pathHelper uploadAudioFileWithFilename:[self.pathHelper getCurrentRecordingFilename]];
}

#pragma mark -- private

void SoundFinished(SystemSoundID soundID,void* sample){
    /*release all the resource when finishing playing*/
    AudioServicesDisposeSystemSoundID((unsigned long)sample);
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (IBAction)showResultTest
{
    [self performSegueWithIdentifier:@"SearchResult" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchResult"]) {
        ((BFSearchResultViewController*)segue.destinationViewController).resultData = [self.pathHelper searchResult];
    }
}
@end
