//
//  Story.m
//  Hacker Pad
//
//  Created by Shubhro Saha on 1/29/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import "Story.h"

@implementation Story

/*
    Creates a story object from a JSON dictionary
 */
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    
    if (self = [self init]) {
        _title = [jsonDictionary objectForKey:@"title"];
        _points = [jsonDictionary objectForKey:@"points"];
        _url = [jsonDictionary objectForKey:@"url"];
        _postedAgo = [jsonDictionary objectForKey:@"postedAgo"];
    }
    
    return self;
    
}

@end
