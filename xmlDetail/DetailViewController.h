//
//  DetailViewController.h
//  xmlDetail
//
//  Created by Viking VRobin on 12-8-16.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
@end
