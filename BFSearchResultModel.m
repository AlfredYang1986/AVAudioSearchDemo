//
//  BFSearchResultModel.m
//  Demo
//
//  Created by Alfred Yang on 6/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFSearchResultModel.h"

@implementation BFSearchResultModel

-(NSDictionary*)searchResultFormFile:(NSString*)fileName
{
    NSError * error = nil;
    
    NSData *response = [NSData dataWithContentsOfFile:fileName options:NSDataReadingUncached error:&error];
    if (response == nil) {
        NSLog(@"%@", error);
    }
    
    NSDictionary * apperals = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (apperals == nil) {
        NSLog(@"%@", error);
    }
    
    return apperals;
}

-(NSDictionary*)searchResultFormURL:(NSString*)hostUrl
{
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101180601.html"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    NSLog(@"weatherInfo字典里面的内容为--》%@", weatherDic );
    return weatherInfo;
}

@end
