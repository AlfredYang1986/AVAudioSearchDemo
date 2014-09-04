//
//  BFDataPackageXMLParser.h
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDataPackageXMLParser : NSObject <NSXMLParserDelegate>
-(NSDictionary*)parserWithStream:(NSStream*)stream;
-(NSDictionary*)parserWithURL:(NSURL*)url;
@end
