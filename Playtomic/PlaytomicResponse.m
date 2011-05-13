//
//  GameVarResults.m
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "PlaytomicResponse.h"

@interface PlaytomicResponse ()
@property (nonatomic, readwrite) NSInteger responseError;
@property (nonatomic, readwrite) Boolean responseSucceeded;
@property (nonatomic, retain) NSArray *responseData;
@property (nonatomic, retain) NSDictionary *responseDictionary;
@property (nonatomic, readwrite) NSInteger numResults;
@end


@implementation PlaytomicResponse

@synthesize responseError;
@synthesize responseSucceeded;
@synthesize responseData;
@synthesize responseDictionary;
@synthesize numResults;

-(id) initWithError: (NSInteger) errorcode
{
    self.responseSucceeded = NO;
    self.responseError = errorcode;
    return self;
}

-(id) initWithSuccess:(Boolean)success andErrorCode:(NSInteger)errorcode
{
    //NSLog(@"Creating PlaytomicResponse with success %d and error %d", success, errorcode);
    self.responseSucceeded = success;
    self.responseError = errorcode;
    return self;
}

-(id) initWithSuccess: (Boolean) success andErrorCode: (NSInteger) errorcode andData: (NSArray*) data andNumResults: (NSInteger) numresults
{
    //NSLog(@"Creating PlaytomicResponse with success %d and error %d", success, errorcode);
    self.responseSucceeded = success;
    self.responseError = errorcode;
    self.responseData = data;
    self.numResults = numresults;
    return self;
}

-(id) initWithSuccess: (Boolean) success andErrorCode: (NSInteger) errorcode andDict: (NSDictionary*) dict
{
    //NSLog(@"Creating PlaytomicResponse with success %d and error %d", success, errorcode);
    self.responseSucceeded = success;
    self.responseError = errorcode;
    self.responseDictionary = dict;
    return self;
}

-(Boolean) success
{
    return self.responseSucceeded;
}

-(NSInteger) errorCode
{
    return self.responseError;
}

- (NSArray*) data
{
    return self.responseData;
}

- (NSString*) getValue: (NSString*) name
{
    return [self.responseDictionary valueForKey:name];
}

- (NSInteger) getNumResults
{
    return self.numResults;
}
@end
