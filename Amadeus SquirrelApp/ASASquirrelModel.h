//
//  ASASquirrelModel.h
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASASquirrelModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *image;

/**
 * Setup the squirrel entry info with given dictionary.
 */
-(void)setSquirrelInfoWithDict:(NSDictionary*)dict;

/**
 * Returns a string containing this string information that is URL encoded.
 * Note the url parameter is not included.
 */
-(NSString*)URLEncodedString;


@end
