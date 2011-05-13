//
//  GameVarResults.h
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlaytomicResponse : NSObject {
    Boolean responseSucceeded;
    NSInteger responseError;
    NSArray* responseData;
    NSDictionary* responseDict;
    NSInteger numResults;
}

-(id) initWithError: (NSInteger) errorcode;
-(id) initWithSuccess: (Boolean) success andErrorCode: (NSInteger) errorcode;
-(id) initWithSuccess: (Boolean) success andErrorCode: (NSInteger) errorcode andData: (NSArray*) data andNumResults: (NSInteger) numresults;
-(id) initWithSuccess: (Boolean) success andErrorCode: (NSInteger) errorcode andDict: (NSDictionary*) dict;
-(Boolean) success;
-(NSInteger) errorCode;
-(NSArray*) data;
-(NSString*) getValue: (NSString*) name;
-(NSInteger) getNumResults;

@end
