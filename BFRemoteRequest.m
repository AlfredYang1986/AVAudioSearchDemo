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
    NSString *urlAsString = @"http://54.252.188.201:8080/Service.svc/File/megawardrobe/xml";
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
}

-(void)uploadFileWithURL:(NSURL*)url data:(NSData*)data
{
    // 1> 数据体
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:data];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2000.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
//    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
//    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }];
}

-(id)searchResultFormFile:(NSString*)fileName
{
    NSString* filePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"json"];
    
    NSData *response = [NSData dataWithContentsOfFile:filePath options:NSDataReadingUncached error:nil];
   
    return [self searchDataFromData:response];
}

-(id)searchResultFormURL:(NSURL*)url withWAVData:(NSData*)data
{
    // 1> 数据体
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:data];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2000.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    //    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    //    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", result);
//    }];

    NSError * error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    return [self searchDataFromData:response];
//    return nil;
}

-(id)searchDataFromData:(NSData*)data
{
    NSError * error = nil;
    NSDictionary * apperals = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:&error];
    if (apperals == nil) {
        NSLog(@"%@", error);
    }
    
    if ([apperals isKindOfClass:[NSDictionary class]]){
        NSDictionary *dictionary = (NSDictionary *)apperals;
        NSLog(@"Dersialized JSON Dictionary = %@", dictionary);
        return dictionary;
        
    }else if ([apperals isKindOfClass:[NSArray class]]){
        NSArray *nsArray = (NSArray *)apperals;
        NSLog(@"Dersialized JSON Array = %@", nsArray);
        return nsArray;
        
    } else {
        NSLog(@"An error happened while deserializing the JSON data.");
        return nil;
    }
}
@end