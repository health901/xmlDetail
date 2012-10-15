//
//  Item.h
//  xml
//
//  Created by Viking VRobin on 12-8-13.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSXMLParserDelegate>
{
    NSString *title;
    NSString *link;
    NSString *description;

    __unsafe_unretained id parentParserDelegate;
    NSMutableString *currentString;
}
@property (nonatomic,assign) id parentParserDelegate;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *link;
@end
