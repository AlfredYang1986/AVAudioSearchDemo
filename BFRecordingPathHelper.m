//
//  BFRecordingPathHelper.m
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFRecordingPathHelper.h"

@implementation BFRecordingPathHelper {
    NSArray* recordings;
}

@synthesize current = _current;

#pragma mark -- constructor

-(id)init
{
    if ([self createRecordingDirectory]) {
        [self resetRecordingEnumable];
    }
    return self;
}

#pragma mark -- public

-(int)getTotalRecordNumber
{
    if (recordings == nil) {
        [self resetRecordingEnumable];
    }
    return [recordings count];
}

-(NSURL*)getNextRecordingPath
{
    NSString *documentsPath = NSHomeDirectory();//[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
}

-(NSString*)getDirPath
{
    NSString *documentsPath = NSHomeDirectory();//[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    
    return testDirectory;
}

-(NSArray*)getEnumableRecordingPath
{
    if (recordings == nil) {
        [self resetRecordingEnumable];
    }
    return recordings;
}

-(BOOL)createRecordingDirectory
{
    if ([self isRecordingDirExist]) {
        return true;
    }
    
    NSString *documentsPath = NSHomeDirectory();//[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"Create Directory Success!");
    }else {
        NSLog(@"Create Directtory Failed!");
    }
    return res;
}

-(NSURL*)getCurrentRecordingPath
{
    NSString *documentsPath = NSHomeDirectory();//[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: [recordings objectAtIndex:self.current]]];
}

#pragma mark -- private

-(BOOL)isRecordingDirExist
{
    NSString *documentsPath = NSHomeDirectory();//[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    
    return [fileManager fileExistsAtPath:testDirectory];
}

-(void)resetRecordingEnumable
{
    NSString* strDir = [self getDirPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *contents = [fileManager contentsOfDirectoryAtPath:strDir error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    
    NSMutableArray* reVal = [[NSMutableArray alloc]init];
    
    NSString *filename;
    while ((filename = [e nextObject])) {
        [reVal addObject:filename];
    }
    recordings = [reVal copy];
}
@end