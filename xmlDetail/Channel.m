//
//  Channel.m
//  xml
//
//  Created by Viking VRobin on 12-8-13.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import "Channel.h"
#import "Item.h"
@implementation Channel
@synthesize items, title, description,parentParserDelegate;

- (id)init
{
    self=[super init];
    if (self)
    {
        items=[[NSMutableArray alloc] init];
    }
    return self;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"C发现元素:%@",elementName);
    if([elementName isEqual:@"title"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"description"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setDescription:currentString];
    }
    else if ([elementName isEqual:@"item"])
    {
        Item *entry=[[Item alloc] init];
        [entry setParentParserDelegate:self];
        [parser setDelegate:entry];
        [items addObject:entry];
        //NSLog(@"items:%@",[[items objectAtIndex:0] title]);
        entry=nil;
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
    if([elementName isEqual:@"channel"])
    {
        [parser setDelegate:parentParserDelegate];
    }
}
@end
