//
//  ViewController.h
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/27/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASASquirrelModel.h"

@interface ASAInformationTabViewController : UIViewController

/**
* The squirrel to display.
*/
@property (nonatomic, strong) ASASquirrelModel* squirrelExampleObject;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *squirrelDescLabel;
@property (strong, nonatomic) IBOutlet UIImage *squirrelImage;



@end

