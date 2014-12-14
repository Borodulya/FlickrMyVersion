//
//  SBViewController.m
//  FlickrMyVersion
//
//  Created by Admin on 11.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBViewController.h"
#import "SBServerManager.h"
#import "SBModel.h"
#import "UIImageView+AFNetworking.h"

@interface SBViewController ()

@property (strong, nonatomic) NSMutableArray* photoArray;

@end

@implementation SBViewController

static NSInteger responsePhotoCount = 500;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* photoArray = [NSMutableArray array];
    
    self.photoArray = photoArray;

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
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    SBModel* photos = [self.photoArray objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", photos.title];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:photos.imageURL];
    
    __weak UITableViewCell* weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
    placeholderImage:nil
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakCell.imageView.image = image;
        [weakCell layoutSubviews];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
    return cell;
}

@end
