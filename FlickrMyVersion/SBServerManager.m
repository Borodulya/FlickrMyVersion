//
//  SBServerManager.m
//  FlickrMyVersion
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBServerManager.h"
#import "AFNetworking.h"
#import "SBModel.h"

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
        
        NSURL* baseUrl = [NSURL URLWithString:nil];
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
        
    }
    return self;
}

- (void) getPhotoWhithCount:(NSInteger)count
                  onSuccess:(void(^)(NSArray* photos))success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"url_z", @"extras",
                            @(count), @"per_page",nil];
    
    [self.operationManager
     GET:@"https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=b7feaac025b0fe2495172aaee44a6660&format=json&nojsoncallback=1"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSLog(@"JSON: %@", responseObject);
         
         NSDictionary* photoDict = [responseObject objectForKey:@"photos"];
         
         NSArray* photoArray = [photoDict objectForKey:@"photo"];
         
         NSMutableArray* photoMut = [NSMutableArray array];
         
         for (NSDictionary* dict in photoArray) {
             SBModel* model = [[SBModel alloc] initWithServerResponse:dict];
             [photoMut addObject:model];
         }
         
         NSLog(@"JSON: %@", photoMut);
         
         if (success) {
             success(photoMut);
         }
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }
        
    }];
    
}

@end
