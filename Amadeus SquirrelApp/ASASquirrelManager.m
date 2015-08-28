//
//  ASASquirrelManager.m
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import "ASASquirrelManager.h"
#import "ASASquirrelModel.h"

@implementation ASASquirrelManager

#define ENDPOINT @"https://mobile.wolfgang.com/Squirrel"

static ASASquirrelManager * _instance;


+(ASASquirrelManager *)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [ASASquirrelManager new];
    });
    return _instance;
}

/**
 * A method to create NSURLRequest with given path, http method and parameters.
 */
-(NSURLRequest*)createURLWithPath:(NSString*)path Method:(NSString*)httpMethod Param:(NSString*)param{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[ENDPOINT stringByAppendingString:path]]];
    [request setHTTPMethod:httpMethod];
    if (param) {
        [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    return request;
}


-(void)listSquirrels:(finishAction)finish{
    NSURLRequest* request = [self createURLWithPath:@"/squirrel.json" Method:@"GET" Param:nil];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (finish==nil) {
            return;
        }
        //Connection error occurs
        if (connectionError) {
            finish(connectionError.localizedDescription, nil);
            return;
        }
        
        NSMutableArray* arraySquirrels = [self retrieveSquirrelsInfoFromJSONData:data];
        
        finish(CODE_SUCCESS, arraySquirrels);
    }];
    
}

-(void)fetchSquirrel:(NSString *)squirrelURL onFinish:(finishAction)finish{
    if (squirrelURL==nil) {
        finish(@"ERROR", nil);
        return;
    }
    NSURLRequest* request = [self createURLWithPath:squirrelURL Method:@"GET" Param:nil];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (finish==nil) {
            return;
        }
        //Connection error occurs
        if (connectionError) {
            finish(connectionError.localizedDescription, nil);
            return;
        }
        
        NSMutableArray* arraySquirrels = [self retrieveSquirrelsInfoFromJSONData:data];
        
        finish(CODE_SUCCESS, arraySquirrels);
    }];
}


/**
 * Create an array of Squirrels from JSON data.
 * If the given data is not valid, an empty array will be returned.
 */
-(NSMutableArray*)retrieveSquirrelsInfoFromJSONData:(NSData*)jsondata{
    NSError* error;
    id JSONData = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableArray* arraySquirrels = [NSMutableArray new];
    
    if ([JSONData isKindOfClass:[NSDictionary class]])
    {
        ASASquirrelModel *squirrelManagerObject = [ASASquirrelModel new];
        [squirrelManagerObject setSquirrelInfoWithDict:(NSDictionary*)JSONData];
        [arraySquirrels addObject:squirrelManagerObject];
    }else if ([JSONData isKindOfClass:[NSArray class]])
    {
        NSArray *squirrelCollection = (NSArray*)JSONData;
        for (NSDictionary* squirrelInDict in squirrelCollection) {
            ASASquirrelModel *squirrelManagerCollectionObject = [ASASquirrelModel new];
            [squirrelManagerCollectionObject setSquirrelInfoWithDict:squirrelInDict];
            [arraySquirrels addObject:squirrelManagerCollectionObject];
        }
    }
    return arraySquirrels;
}






@end
