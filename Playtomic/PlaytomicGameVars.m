//
//  GameVars.m
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "Playtomic.h"
#import "PlaytomicGameVars.h"
#import "PlaytomicResponse.h"
#import "JSON/JSON.h"
#import "ASI/ASIHTTPRequest.h"

@implementation PlaytomicGameVars

- (PlaytomicResponse*) load
{
    //NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/gamevars/load.aspx?swfid=%d&js=y", [Playtomic getGameGuid], [Playtomic getGameId]];
    NSString *url = [NSString stringWithFormat:@"http://playtomictestapi.apphb.com/gamevars/load.aspx?swfid=%d&guid=%@&js=m", [Playtomic getGameId], [Playtomic getGameGuid]];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL: [NSURL URLWithString: url]];
    [request startSynchronous];
    
    NSError *error = [request error];
    
    // failed on the client / connectivty side
    if(error)
    {
        return [[PlaytomicResponse alloc] initWithError: 1];
    }
    
    // we got a response of some kind
    NSString *response = [request responseString];
    NSString *json = [[NSString alloc] initWithString: response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey: @"Status"] integerValue];
    
    // failed on the server side
    if(status != 1)
    {
        NSInteger errorcode = [[data valueForKey: @"ErrorCode"] integerValue];
        return [[PlaytomicResponse alloc] initWithError: errorcode];
    }
    
    NSDictionary* dvars = [data valueForKey: @"Data"];
    NSMutableDictionary * md = [[NSMutableDictionary alloc] init];
    
    for(id key in dvars)
    {
        for(id name in key)
        {
            [md setObject: [key valueForKey: name] forKey: name];
        }
    }

    return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: 0 andDict: md];
}

@end
