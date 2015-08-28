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

@interface ASAInformationTabViewController () <UITableViewDataSource, UITableViewDataSource>{
    NSMutableArray* squirrelArray;
    
}
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *squirrelListTableView;

@end

@implementation ASAInformationTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add drag to refresh function
    self.refreshControl = [[ODRefreshControl alloc]initInScrollView:self.squirrelListTableView];
    self.refreshControl.tintColor = [UIColor colorWithRed:46.0/255 green:172.0/255 blue:247.0/255 alpha:1];
    [self.refreshControl addTarget:self action:@selector(dragToRefreshAction:) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    __weak ASAInformationTabViewController* weakself = self;
    [[ASASquirrelManager instance] fetchSquirrel:self.squirrelExampleObject.url onFinish:^(NSString *response, NSArray *result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([response isEqualToString:CODE_SUCCESS] && result.count>0) {
                
                self.squirrelExampleObject = result[0];
                if (weakself) {
                    [weakself loadSquirrelInfo];
                }
            }else{
                //Show alert and go back to main screen
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Squirrel doesn't exist!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        });
    }];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ASASquirrelInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squirrel"];
        ASASquirrelModel *squirrel = squirrelArray[indexPath.row];
//        cell.squirrelTitleLabel.text = self.squirrelExampleObject.title;
//        cell.squirrelDescLabel.text = self.squirrelExampleObject.desc;
        return cell;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return squirrelArray.count;
}

-(void)loadSquirrelInfo{
    self.titleLabel.text = self.squirrelExampleObject.title;
    self.squirrelDescLabel.text = self.squirrelExampleObject.desc;
}





@end
