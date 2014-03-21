//
//  HackerPadDetailViewController.m
//  Hacker Pad
//
//  Created by Shubhro Saha on 1/29/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import "HackerPadDetailViewController.h"

@interface HackerPadDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation HackerPadDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.story.title;
    
    NSURL *url = [NSURL URLWithString:self.story.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
