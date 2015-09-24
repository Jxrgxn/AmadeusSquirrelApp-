//
//  SquirrelDetailViewController.h
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquirrelDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURL *urlstr;
@property (nonatomic, strong) NSString *urlString; 



@end
