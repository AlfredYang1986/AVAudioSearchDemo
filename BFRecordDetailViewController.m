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
    self.recordNameLabel.text = [[self.pathHelper getEnumableRecordingPath]objectAtIndex:self.pathHelper.current];
    self.recordFormatLabel.text = [[self.pathHelper getEnumableRecordingPath]objectAtIndex:self.pathHelper.current];
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
    /*添加音频结束时的回调*/
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished, (__bridge void *)(sample));
    /*开始播放*/
    AudioServicesPlaySystemSound(soundID);
    CFRunLoopRun();
    
}

- (IBAction)searchWithCurrentRecord
{
    NSLog(@"search with current record");
}

- (IBAction)changeFormatToFlic
{
    NSLog(@"change format of current record for google sapi");
}

#pragma mark -- private

void SoundFinished(SystemSoundID soundID,void* sample){
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID((unsigned long)sample);
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}
@end
