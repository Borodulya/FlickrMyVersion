//
//  SBViewController.m
//  FlickrMyVersion
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBViewController.h"
#import "SBServerManager.h"

@interface SBViewController ()

@property (strong, nonatomic) NSMutableArray* photoArray;

@end

@implementation SBViewController

static NSInteger responsePhotoCount = 20;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoArray = [NSMutableArray array];

    [self getPhotoFromFlickr];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <Api>

- (void) getPhotoFromFlickr {
    
    [[SBServerManager sharedManager] getPhotoWhithCount:responsePhotoCount
                                              onSuccess:^(NSArray *photos) {
                                                  [self.photoArray addObjectsFromArray:photos];
                                                  [self.tableView reloadData];
                                              }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
                                                  NSLog(@"%@, %d", error, statusCode);
                                              }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    return cell;
}

@end
