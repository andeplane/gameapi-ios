//
//  PlaytomicRequest.m
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "PlaytomicLogRequest.h"
#import "Playtomic.h"
#import "PlaytomicLog.h"
#import "ASI/ASIHTTPRequest.h"

@interface PlaytomicLogRequest ()
@property (nonatomic,copy) NSString *data;
@property (nonatomic,copy) NSString *trackUrl;
@end

@implementation PlaytomicLogRequest

@synthesize data;
@synthesize trackUrl;

- (id) initWithTrackUrl: (NSString*) url
{
    trackUrl = url;
    data = @"";
    return self;
}

-(void) queue: (NSString*) event
{
    if([data length] == 0)
    {
        data = event;
    }
    else
    {
        data = [data stringByAppendingString:@"~"];
        data = [data stringByAppendingString: event];
    }
}

-(void) massQueue:(NSMutableArray*) eventqueue
{
    while([eventqueue count] > 0)
    {
        id event = [eventqueue objectAtIndex: 0];
        [eventqueue removeObjectAtIndex: 0];
        
        if([data length] == 0)
        {
            data = event;

        }
        else
        {
            data = [data stringByAppendingString:@"~"];
            data = [data stringByAppendingString: event];
            
            if([data length] > 300)
            {
                [self send];
                
                PlaytomicLogRequest* request = [[PlaytomicLogRequest alloc] initWithTrackUrl: trackUrl];
                [request massQueue: eventqueue];
            }
        } 
    }
    
    [self send];
}


-(void) send
{
	NSString *fullurl = self.trackUrl;
    fullurl = [fullurl stringByAppendingString: self.data];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL: [NSURL URLWithString: fullurl]];
    [request HEADRequest];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
}

@end

