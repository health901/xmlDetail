//
//  MasterViewController.m
//  xmlDetail
//
//  Created by Viking VRobin on 12-8-16.
//  Copyright (c) 2012年 Viking VRobin. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Channel.h"
#import "Item.h"
@interface MasterViewController ()
@end

@implementation MasterViewController
@synthesize listview;
- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [self fetchEntries];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 0;
    //NSLog(@"count:%d",[[channel items] count]);
    self.listview=tableView;
    return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Item *item=[[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
    return cell;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url=[[[channel items] objectAtIndex:[indexPath row]] link];
    [[self detailViewController] setDetailItem:url];
    NSLog(@"link:%@",self.detailViewController.detailItem);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.detailViewController=segue.destinationViewController;    
}


- (void)fetchEntries
{
    xmlData=[[NSMutableData alloc] init];
    NSURL *url=[NSURL URLWithString:@"http://cnbeta.feedsportal.com/c/34306/f/624776/index.rss"];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    connection=[[NSURLConnection alloc] initWithRequest:req delegate:self];
}
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    //NSString *check=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    //NSLog(@"数据:%@",check);
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    xmlData=nil;
    connection=nil;
    [listview reloadData];
    NSLog(@"\n channel:%@\n title:%@\n des:%@\n",channel,[channel title],[channel description]);
}
- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    connection=nil;
    xmlData=nil;
    NSString *errormsg=[NSString stringWithFormat:@"fetch error:\n%@",
                        [error localizedDescription]];
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"错误 error" message:errormsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}

#pragma mark - XML delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ LVC发现元素:%@",self,elementName);
    channel=[[Channel alloc] init];
    [channel setParentParserDelegate:self];
    [parser setDelegate:channel];
}
@end
