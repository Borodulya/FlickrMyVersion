//
//  SBServerManager.h
//  FlickrMyVersion
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBServerManager : NSObject

+ (SBServerManager *) sharedManager;

- (void) getPhotoWhithCount:(NSInteger)count
                  onSuccess:(void(^)(NSArray* photos))success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
