//
//  ASASquirrelManager.h
//  Amadeus SquirrelApp
//
//  Created by Basel Farag on 8/28/15.
//  Copyright (c) 2015 Basel Farag. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MSG_SQUIRRELNEEDUPDATE @"updateSquirrel"
@class ASASquirrelModel;

/**
 * Block used for callbacks.
 * @para response Code of response, can be success or else.
 * @para result An array of Squirrel instance.
 */
typedef void(^finishAction)(NSString* response, NSMutableArray* result);

#define CODE_SUCCESS @"success"

@interface ASASquirrelManager : NSObject

/**
 * Returns the instance of the manager.
 */
+(ASASquirrelManager*)instance;

/**
 * List all the squirls on the server.
 * The block will return the retrieved squirrels.
 * Note the block is not dispatched in main queue.
 */
-(void)listSquirrels:(finishAction)finish;

/**
 * Retrieve a specific squirrel's information.
 */
-(void)fetchSquirrel:(NSString*)squirrelURL onFinish:(finishAction)finish;



@end
