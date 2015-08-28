//
//  ASASquirrelModel.m
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import "ASASquirrelModel.h"

@interface ASASquirrelModel ()

#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]

@end

@implementation ASASquirrelModel




-(void)setSquirrelInfoWithDict:(NSDictionary *)dict{
    self.title             = nilOrJSONObjectForKey(dict, @"author");
    self.desc              = nilOrJSONObjectForKey(dict, @"categories");
    self.title             = nilOrJSONObjectForKey(dict, @"title");
    self.image             = nilOrJSONObjectForKey(dict, @"image");
}



/**
 * Helper function to url encode a string
 */
- (NSString *)urlencode:(NSString*)str {
    if (str==nil) {
        return @"";
    }
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)str,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}

@end
