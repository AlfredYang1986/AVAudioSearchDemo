//
//  BFRemoteRequest.h
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFRemoteRequest : NSObject
-(BOOL)downloadDataPackageToPath:(NSString*)path;
-(void)uploadFileWithURL:(NSURL*)url data:(NSData*)data;

#pragma mark -- json parser
-(id)searchResultFormFile:(NSString*)fileName;
-(id)searchResultFormURL:(NSString*)hostUrl withWAVFile:(NSString*)fileName;
@end
