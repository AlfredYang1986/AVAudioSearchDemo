//
//  BFSearchResultModel.h
//  Demo
//
//  Created by Alfred Yang on 6/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFSearchResultModel : NSObject
#pragma mark -- json parser
-(NSDictionary*)searchResultFormFile:(NSString*)fileName;
-(NSDictionary*)searchResultFormURL:(NSString*)hostUrl;
@end
