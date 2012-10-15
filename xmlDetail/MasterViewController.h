//
//  MasterViewController.h
//  xmlDetail
//
//  Created by Viking VRobin on 12-8-16.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class Channel;
@interface MasterViewController : UITableViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    Channel *channel;
    DetailViewController *detailViewController;
}
@property (nonatomic,strong) DetailViewController *detailViewController;
@property (nonatomic,weak) UITableView *listview;
- (void)fetchEntries;

@end
