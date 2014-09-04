//
//  BFRemoteRequest.m
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFRemoteRequest.h"

@implementation BFRemoteRequest

-(BOOL)downloadDataPackageToPath:(NSString*)path
{
    NSString *urlAsString = @"http://dev.megawardrobe.com:8080/Service.svc/File/megawardrobe/xml";
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];

    /* downloading ... */
    if (data != nil){
        NSLog(@"download success");
        if ([data writeToFile:path atomically:YES]) {
            NSLog(@"save success.");
        }
        else
        {
            NSLog(@"save failed.");
            return false;
        }
    } else {
        NSLog(@"%@", error);
        return false;
    }
    
    return true;
};
@end
