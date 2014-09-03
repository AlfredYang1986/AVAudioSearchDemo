//
//  BFRecordingPathHelper.h
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFRecordingPathHelper : NSObject

@property (nonatomic) NSInteger current;

-(id)init;
-(int)getTotalRecordNumber;
-(NSURL*)getNextRecordingPath;
-(NSString*)getDirPath;
-(NSArray*)getEnumableRecordingPath;
-(BOOL)createRecordingDirectory;
-(NSURL*)getCurrentRecordingPath;
@end
