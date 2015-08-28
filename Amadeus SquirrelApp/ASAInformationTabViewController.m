//
//  ViewController.m
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/27/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import "ASAInformationTabViewController.h"
#import "ASASquirrelModel.h"
#import "ASASquirrelManager.h"
#import "ASASquirrelInformationTableViewCell.h"
#import <ODRefreshControl/ODRefreshControl.h>

@interface ASAInformationTabViewController (){
    NSMutableArray *squirrelArray;
}
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *squirrelListTableView;

@end

@implementation ASAInformationTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setUpSquirrelList];
    //Add drag to refresh function
    self.refreshControl = [[ODRefreshControl alloc]initInScrollView:self.squirrelListTableView];
    self.refreshControl.tintColor = [UIColor colorWithRed:46.0/255 green:172.0/255 blue:247.0/255 alpha:1];
    [self.refreshControl addTarget:self action:@selector(dragToRefreshAction:) forControlEvents:UIControlEventValueChanged];
}




-(void)viewWillAppear:(BOOL)animated
{

}

-(void)setUpSquirrelList
{
    __weak UITableView* weaktable = self.squirrelListTableView;
    [[ASASquirrelManager instance] listSquirrels:^(NSString *response, NSMutableArray *result) {
    
    
        if ([response isEqualToString:CODE_SUCCESS]) {
            squirrelArray = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weaktable) {
                    [weaktable reloadData];
                }
            });
    }
    
    }];
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ASASquirrelInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squirrelIdentifier"];
        ASASquirrelModel *squirrelLocal = squirrelArray[indexPath.row];
        cell.squirrelTitleLabel.text = squirrelLocal.title;
        cell.squirrelDescLabel.text = squirrelLocal.desc;
//        cell.squirrelImage = squirrelLocal.image
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:
                         [NSURL URLWithString:squirrelLocal.image]];
    cell.squirrelImage.image = [UIImage imageWithData:imageData];

    return cell;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return squirrelArray.count;

}


-(void)dragToRefreshAction:(id)sender{
    
    __weak ASAInformationTabViewController* weakself = self;
    [[ASASquirrelManager instance] listSquirrels:^(NSString *response, NSMutableArray *result) {
        
        if ([response isEqualToString:CODE_SUCCESS]) {
            squirrelArray = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakself) {
                    [weakself.refreshControl endRefreshing];
                    
                    [weakself.squirrelListTableView reloadData];
                }
            });
        }
        
    }];
}


@end
