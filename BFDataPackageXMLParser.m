//
//  BFDataPackageXMLParser.m
//  Demo
//
//  Created by Alfred Yang on 4/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFDataPackageXMLParser.h"

@implementation BFDataPackageXMLParser {
    NSMutableDictionary * dataPackageAttrs;
}

-(NSDictionary*)parserWithStream:(NSStream*)stream;
{
    return nil;
}

-(NSDictionary*)parserWithURL:(NSURL*)url
{
    NSXMLParser* parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    return [dataPackageAttrs copy];
}

#pragma mark xmlparser

//step 1：准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start Parser");
    if (dataPackageAttrs) {
        [dataPackageAttrs removeAllObjects];
    } else {
        dataPackageAttrs = [[NSMutableDictionary alloc]init];
    }
}

//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Start Node");
    NSLog(@"%@", elementName);
    NSLog(@"%@", namespaceURI);
    NSLog(@"%@", qName);
    
    if ([elementName isEqualToString:@"endpoint"]) {
        [dataPackageAttrs setObject:[attributeDict objectForKey:@"url"] forKey:@"url"];
    }
}

//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"Start step 3");
    NSLog(@"%@", string);
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"End Node");
    NSLog(@"%@", elementName);
    NSLog(@"%@", namespaceURI);
    NSLog(@"%@", qName);
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"End Parser");
}

//获取cdata块数据
//- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
//{
//    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
//}
@end
