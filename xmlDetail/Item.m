//
//  Item.m
//  xml
//
//  Created by Viking VRobin on 12-8-13.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize link,title,description,parentParserDelegate;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%@ I发现元素:%@",self,elementName);
    if([elementName isEqual:@"title"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setTitle:currentString];
        //NSLog(@"\n标题：%@",[self title]);
    }
    else if ([elementName isEqual:@"description"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setDescription:currentString];
    }
    else if ([elementName isEqual:@"link"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setLink:currentString];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //发现结束符号时将代理交还父节点
    currentString=nil;
    if([elementName isEqual:@"item"])
    {
        //NSLog(@"\n标题：%@",[self title]);
        [parser setDelegate:parentParserDelegate];
    }
}
@end
