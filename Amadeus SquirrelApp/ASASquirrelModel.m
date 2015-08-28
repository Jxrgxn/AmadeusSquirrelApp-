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

-(NSString*)description{
    
    return [NSString stringWithFormat:@"Title: %@\nDesc::%@",self.title, self.desc];
}


-(void)setSquirrelInfoWithDict:(NSDictionary *)dict{
    self.title             = nilOrJSONObjectForKey(dict, @"title");
    self.desc              = nilOrJSONObjectForKey(dict, @"desc");
    self.url               = nilOrJSONObjectForKey(dict, @"url");
    self.image             = nilOrJSONObjectForKey(dict, @"image");
}


-(NSString *)URLEncodedString{
    NSMutableString* urlencodedstr = [NSMutableString new];
    if (self.title) {
        [urlencodedstr appendFormat:@"title=%@&", [self urlencode:self.title]];
    }
    if (self.desc) {
        [urlencodedstr appendFormat:@"desc=%@&", [self urlencode:self.desc]];
    }
    if (urlencodedstr.length>0) {
        //Remove the last & symbol
        [urlencodedstr deleteCharactersInRange:NSMakeRange(urlencodedstr.length-1, 1)];
    }
    return [NSString stringWithString:urlencodedstr];
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
