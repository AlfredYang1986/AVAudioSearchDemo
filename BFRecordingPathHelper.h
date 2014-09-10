//
//  BFRecordingPathHelper.h
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFRemoteRequest.h"

@interface BFRecordingPathHelper : NSObject

@property (nonatomic) NSInteger current;

-(id)init;
-(void)resetPathHelper;

#pragma mark -- for recording
-(int)getTotalRecordNumber;
-(NSURL*)getNextRecordingPath;
-(NSString*)getDirPath;
-(NSArray*)getEnumableRecordingPath;
-(BOOL)createRecordingDirectory;
-(NSURL*)getCurrentRecordingPath;
-(NSString*)getCurrentRecordingFilename;
-(void)deleteFileWithFileName:(NSString*)fileName;
-(void)deleteFileWithIndex:(NSInteger)index;

#pragma mark -- for downloading
-(NSString*)getDownloadDir;
-(BOOL)createDownloadDirectory;
-(BOOL)downloadDataPackage;
-(void)deleteDataPackage;
-(NSDictionary*)getDatePackageAttribute;
-(NSURL*)getDownloadDataPackagePathWithName:(NSString*)fileName;
-(NSString*)getDownloadDataPackageStringWithName:(NSString*)fileName;

#pragma mark -- for upload
-(void)uploadAudioFileWithFilename:(NSString*)fileName;

#pragma mark -- for json search result
-(NSArray*)searchResult;
-(NSArray*)searchResultWithWAVFile:(NSString*)fileName;
@end
