//
//  Story.h
//  Hacker Pad
//
//  Created by Shubhro Saha on 1/29/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (readonly) NSString *title;
@property (readonly) NSNumber *points;
@property (readonly) NSString *postedAgo;
@property (readonly) NSString *url;

@end
