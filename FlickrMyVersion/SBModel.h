//
//  SBModel.h
//  FlickrMyVersion
//
//  Created by Admin on 12.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBModel : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSURL* imageURL;

- (id)initWithServerResponse:(NSDictionary *)photoDict;

@end
