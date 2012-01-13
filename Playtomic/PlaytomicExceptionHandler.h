//
//  PlaytomicExceptionHandler.h
//  ObjectiveCTest
//
//  Created by matias on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaytomicExceptionHandler : NSObject


+ (void) registerDefaultHandlers;

+ (void) unregisterDefaultHandlers;

+ (PlaytomicExceptionHandler*) getInstance;

- (void) sendReportArray:(NSArray*)array;
                                 
@end
