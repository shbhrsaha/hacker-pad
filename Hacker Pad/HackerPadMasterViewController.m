//
//  HackerPadMasterViewController.m
//  Hacker Pad
//
//  Created by Shubhro Saha on 1/29/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import "HackerPadMasterViewController.h"
#import "HackerPadDetailViewController.h"
#import "Story.h"

@interface HackerPadMasterViewController () {
    NSMutableArray *_stories;
}
@end

@implementation HackerPadMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshStories];
    
    // time to get some pull to refresh action
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
}

- (void)refreshStories {
    // Load the JSON
    NSURL *url = [NSURL URLWithString:@"http://api.ihackernews.com/page"];
    
    // Process JSON in a background queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
        
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _stories = [[NSMutableArray alloc] init];
        NSArray *array = [jsonDictionary objectForKey:@"items"];
        
        for (NSDictionary *dict in array) {
            Story *story = [[Story alloc] initWithJSONDictionary:dict];
            [_stories addObject:story];
        }
        
        // reload the table data in the main thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
    });
    
    
}

- (void)refresh:(id)sender
{
    [self refreshStories];
    [(UIRefreshControl *)sender endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Story *story = [_stories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = story.title;
    
    NSString *captionStart = [[story.points stringValue] stringByAppendingString:@" points   "];
    
    // error handling because story.postedAgo might be nil
    @try {
        cell.detailTextLabel.text = [captionStart stringByAppendingString:story.postedAgo];
    }
    
    @catch ( NSException *e ) {
        cell.detailTextLabel.text = captionStart;
    }
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HackerPadDetailViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    vc.story = [_stories objectAtIndex:indexPath.row];
}

@end
