//
//  SBModel.m
//  FlickrMyVersion
//
//  Created by Admin on 12.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBModel.h"
#import "SBServerManager.h"

@implementation SBModel

- (id)initWithServerResponse:(NSDictionary *)photoDict {
    
    self = [super init];
    
    self.title = [photoDict objectForKey:@"title"];
    
    NSString* urlString = [photoDict objectForKey:@"url_z"];
    
    if (urlString) {
        self.imageURL = [NSURL URLWithString:urlString];
    }
    
    
    return self;
}


@end
