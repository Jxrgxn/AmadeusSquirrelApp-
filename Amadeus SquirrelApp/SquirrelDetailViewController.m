//
//  SquirrelDetailViewController.m
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import "SquirrelDetailViewController.h"

@interface SquirrelDetailViewController () <UIWebViewDelegate> 

@end

@implementation SquirrelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.urlstr = [NSURL URLWithString:self.urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.urlstr];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
