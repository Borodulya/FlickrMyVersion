//
//  SBServerManager.m
//  FlickrMyVersion
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBServerManager.h"
#import "AFNetworking.h"

@interface SBServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* operationManager;

@end

@implementation SBServerManager

+ (SBServerManager *) sharedManager {
    
    static SBServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SBServerManager alloc] init];
    });
    
    return manager;
}

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        NSURL* baseUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/"];
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
        
    }
    return self;
}

- (void) getPhotoWhithCount:(NSInteger)count
                  onSuccess:(void(^)(NSArray* photos))success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"b7feaac025b0fe2495172aaee44a6660", @"api_key",
                            @"url_n", @"extras",
                            @(count), @"per_page",nil];
    
    [self.operationManager
     GET:@"flickr.interestingness.getList"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
         
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
