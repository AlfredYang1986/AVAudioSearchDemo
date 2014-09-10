//
//  BFRecordingPathHelper.m
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFRecordingPathHelper.h"
#import "BFDataPackageXMLParser.h"

@interface BFRecordingPathHelper ()
@property (nonatomic, strong) BFRemoteRequest * requestInstance;
@end

@implementation BFRecordingPathHelper {
    NSArray* recordings;
}

@synthesize current = _current;
@synthesize requestInstance = _requestInstance;

#pragma mark -- constructor

-(id)init
{
    [self resetPathHelper];
    return self;
}

-(void)resetPathHelper
{
    if ([self createRecordingDirectory]) {
        [self resetRecordingEnumable];
    }
    [self createDownloadDirectory];
    self.requestInstance = [[BFRemoteRequest alloc]init];
}

#pragma mark -- public

-(NSInteger)getTotalRecordNumber
{
    if (recordings == nil) {
        [self resetRecordingEnumable];
    }
    return [recordings count];
}

-(NSURL*)getNextRecordingPath
{
    NSString *documentsPath = [self getDocumentDir];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"wav"]]];
//    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
}

-(NSString*)getDirPath
{
    return [self getDirPathWithName:@"RecordingDemo"];
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
    return [self createDirWithName:@"RecordingDemo"];
}

-(NSURL*)getCurrentRecordingPath
{
    NSString *documentsPath = [self getDocumentDir];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"RecordingDemo"];
    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: [recordings objectAtIndex:self.current]]];
}

-(NSString*)getDownloadDir
{
    return [self getDirPathWithName:@"Downloads"];
}

-(BOOL)createDownloadDirectory
{
    return [self createDirWithName:@"Downloads"];
}

-(BOOL)downloadDataPackage
{
    [self.requestInstance downloadDataPackageToPath:[self getDownloadDataPackageStringWithName:@"megawardrobe"]];
    return false;
}

-(NSDictionary*)getDatePackageAttribute
{
    return nil;
}

-(NSURL*)getDownloadDataPackagePathWithName:(NSString*)fileName
{
    NSString *documentsPath = [self getDocumentDir];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"Downloads"];
    return [NSURL fileURLWithPath:[testDirectory stringByAppendingPathComponent: fileName]];
}

-(NSString*)getDownloadDataPackageStringWithName:(NSString*)fileName
{
    NSString *documentsPath = [self getDocumentDir];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"Downloads"];
    NSString *testfile = [testDirectory stringByAppendingPathComponent:fileName];
    NSString *path = [testfile stringByAppendingPathExtension:@"xml"];
    return path;
}

-(void)deleteDataPackage
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL* path = [self getDownloadDataPackagePathWithName:@"megawardrobe"];
    [fileManager removeItemAtURL:path error:nil];
}

-(void)uploadAudioFileWithFilename:(NSString*)fileName
{
    NSString * url = [@"http://54.252.188.201:8080/Service.svc/UploadFile?fileName=" stringByAppendingString:fileName];
    
    NSURL* path = [self getCurrentRecordingPath];
    NSData *data = [NSData dataWithContentsOfURL:path];
    [self.requestInstance uploadFileWithURL:[NSURL URLWithString:url] data:data];
}

-(NSString*)getCurrentRecordingFilename
{
    return [recordings objectAtIndex:self.current];
}

-(NSArray*)searchResult
{
    return [self.requestInstance searchResultFormFile:@"AppSearchDemoData"];
}

-(NSArray*)searchResultWithWAVFile:(NSString*)fileName
{
    NSString * URL = [@"http://54.252.188.201:8080/Service.svc/AppSearchDemoWithAVAudio?fileName=" stringByAppendingString:fileName];
    
    NSURL* path = [self getCurrentRecordingPath];
    NSData *data = [NSData dataWithContentsOfURL:path];
    return [self.requestInstance searchResultFormURL:[NSURL URLWithString:URL] withWAVData:data];
}

#pragma mark -- private

-(BOOL)isDirExist:(NSString*)dir
{
    NSString *documentsPath = [self getDocumentDir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dir];
    
    return [fileManager fileExistsAtPath:testDirectory];
}

-(BOOL)createDirWithName:(NSString*)dir
{
    if ([self isDirExist:dir]) {
        return true;
    }
    
    NSString *documentsPath = [self getDocumentDir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dir];
    
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"Create Directory Success!");
    }else {
        NSLog(@"Create Directtory Failed!");
    }
    return res;
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

-(NSString*)getDirPathWithName:(NSString*)dir
{
    NSString *documentsPath = [self getDocumentDir];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:dir];
    
    return testDirectory;
}

-(void)deleteFileWithFileName:(NSString*)fileName
{
    [self deleteFileWithIndex:[recordings indexOfObject:fileName]];
}

-(void)deleteFileWithIndex:(NSInteger)index
{
    self.current = index;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:[self getCurrentRecordingPath] error:nil];
}

-(NSString*)getDocumentDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
@end