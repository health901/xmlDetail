//
//  Channel.h
//  xmlDetail
//
//  Created by Viking VRobin on 12-8-13.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject <NSXMLParserDelegate>
{
    NSString *title;
    NSString *description;
    NSMutableArray *items;
    
    __unsafe_unretained id parentParserDelegate;
    
    NSMutableString *currentString;
}
@property (nonatomic,assign) id parentParserDelegate;

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,readonly) NSMutableArray *items;
@end
