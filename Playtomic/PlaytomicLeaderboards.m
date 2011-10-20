//
//  Leaderboards.m
//  ObjectiveCTest
//
//  This file is part of the official Playtomic API for iOS games.  
//  Playtomic is a real time analytics platform for casual games 
//  and services that go in casual games.  If you haven't used it 
//  before check it out:
//  http://playtomic.com/
//
//  Created by ben at the above domain on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//
//  Documentation is available at:
//  http://playtomic.com/api/ios
//
// PLEASE NOTE:
// You may modify this SDK if you wish but be kind to our servers.  Be
// careful about modifying the analytics stuff as it may give you 
// borked reports.
//
// If you make any awesome improvements feel free to let us know!
//
// -------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY PLAYTOMIC, LLC "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PlaytomicLeaderboards.h"
#import "PlaytomicResponse.h"
#import "Playtomic.h"
#import "PlaytomicScore.h"
#import "PlaytomicEncrypt.h"
#import "JSON/JSON.h"
#import "ASI/ASIFormDataRequest.h"
#import "ASI/ASIHTTPRequest.h"

@interface PlaytomicLeaderboards() 

- (void)requestSaveFinished:(ASIHTTPRequest*)request;
- (void)requestListFinished:(ASIHTTPRequest*)request;
- (void)requestSaveAndListFinished:(ASIHTTPRequest*)request;

@end

@implementation PlaytomicLeaderboards

// synchronous calls
//

- (PlaytomicResponse*)saveTable:(NSString*)table 
                       andScore:(PlaytomicScore*)score 
                     andHighest:(Boolean)highest 
             andAllowDuplicates:(Boolean)allowduplicates
{        
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/save.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" :@"n") forKey:@"highest"];
    [request setPostValue:[score getName] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat:@"%d", [score getPoints]] forKey:@"points"];
    [request setPostValue:(allowduplicates ? @"y" :@"n") forKey:@"allowduplicates"];
    [request setPostValue:[PlaytomicEncrypt md5:[NSString stringWithFormat:@"%@%d"
                                                                            , [Playtomic getSourceUrl]
                                                                            , [score getPoints]]] 
                   forKey:@"auth"];
    
    NSDictionary* customdata = [score getCustomData];
    [request setPostValue:[NSString stringWithFormat:@"%d", [customdata count]] 
                   forKey:@"customfields"];
   
    NSInteger fieldnumber = 0;
    
    for(id customfield in customdata)
    {
        NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
        NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
        NSString *value = [customdata objectForKey:customfield];
        fieldnumber++;
 
        [request setPostValue:customfield forKey:ckey];
        [request setPostValue:value forKey:cdata];
    }
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if(error)
    {
        return [[[PlaytomicResponse alloc] initWithError:1] autorelease];
    }
    
    NSString *response = [request responseString];       
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [json release];
    [parser release];
    
    if(status == 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        return [[[PlaytomicResponse alloc] initWithSuccess:YES 
                                              andErrorCode:errorcode] autorelease]; 
    }
    else
    {
        //NSLog(@"failed here %@", response);
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        return [[[PlaytomicResponse alloc] initWithError:errorcode] autorelease];
    }
}

- (PlaytomicResponse*)listTable:(NSString*)table 
                     andHighest:(Boolean)highest 
                        andMode:(NSString*)mode 
                        andPage:(NSInteger)page 
                     andPerPage:(NSInteger)perpage 
                andCustomFilter:(NSDictionary*)customfilter
{
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/list.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];

    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    [request setPostValue:mode forKey:@"mode"];
    [request setPostValue:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [request setPostValue:[NSString stringWithFormat:@"%d", perpage] forKey:@"perpage"];
    [request setPostValue:[NSString stringWithFormat:@"%d", numfilters] forKey:@"numfilters"];

    if(numfilters > 0)
    {
        NSInteger fieldnumber = 0;
        
        for(id customfield in customfilter)
        {
            NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
            NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
            NSString *value = [customfilter objectForKey:customfield];
            fieldnumber++;
            
            [request setPostValue:customfield forKey:ckey];
            [request setPostValue:value forKey:cdata];
        }
    }
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    // failed on the client / connectivty side
    if(error)
    {
        return [[PlaytomicResponse alloc] initWithError:1];
    }

    // we got a response of some kind
    NSString *response = [request responseString];
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [request release];
    [json release];
    [parser release];
    
    // failed on the server side
    if(status != 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        return [[[PlaytomicResponse alloc] initWithError:errorcode] autorelease];
    }
    
    // score list completed
    NSDictionary *dvars = [data valueForKey:@"Data"];
    NSArray *scores = [dvars valueForKey:@"Scores"];
    NSInteger numscores = [[dvars valueForKey:@"NumScores"] integerValue];  
    NSMutableArray *md = [[NSMutableArray alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    for(id score in scores)
    {
        NSString *username = [score valueForKey:@"Name"];
        NSInteger points = [[score valueForKey:@"Points"] integerValue];
        NSString *relativedate = [score valueForKey:@"RDate"];
        NSDate *date = [df dateFromString:[score valueForKey:@"SDate"]];
        long rank = [[score valueForKey:@"Rank"] doubleValue];
        NSMutableDictionary *customdata = [[NSMutableDictionary alloc] init];
        
        NSDictionary *returnedcustomdata = [score valueForKey:@"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString *cvalue = [[returnedcustomdata valueForKey:key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject:cvalue forKey:key];
        }
        
        [md addObject:[[PlaytomicScore alloc] initWithName:username 
                                                  andPoints:points 
                                                    andDate:date 
                                            andRelativeDate:relativedate 
                                              andCustomData:customdata 
                                                    andRank:rank]];
    }
    
    PlaytomicResponse *playtomicResponse = [[PlaytomicResponse alloc] initWithSuccess:YES 
                                                                         andErrorCode:0 
                                                                              andData:md 
                                                                        andNumResults:numscores];
    [playtomicResponse autorelease];
    [df release];
    [md release];
    
    return playtomicResponse;
}

- (PlaytomicResponse*)saveAndListTable:(NSString*)table 
                              andScore:(PlaytomicScore*)score 
                            andHighest:(Boolean)highest 
                    andAllowDuplicates:(Boolean)allowduplicates 
                               andMode:(NSString*)mode 
                            andPerPage:(NSInteger)perpage 
                       andCustomFilter:(NSDictionary*) customfilter
{
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/saveandlist.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    // common fields
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    
    // save fields
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:[score getName] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat:@"%d", [score getPoints]] forKey:@"points"];
    [request setPostValue:(allowduplicates ? @"y" : @"n") forKey:@"allowduplicates"];
    [request setPostValue:[PlaytomicEncrypt md5:[NSString stringWithFormat:@"%@%d"
                                                        , [Playtomic getSourceUrl]
                                                        , [score getPoints]]] 
                   forKey:@"auth"];
    
    NSDictionary* customdata = [score getCustomData];
    [request setPostValue: [NSString stringWithFormat:@"%d", [customdata count]] 
                   forKey:@"numfields"];
    
    NSInteger fieldnumber = 0;
    
    for(id customfield in customdata)
    {
        NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
        NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
        NSString *value = [customdata objectForKey:customfield];
        fieldnumber++;
        
        [request setPostValue:customfield forKey:ckey];
        [request setPostValue:value forKey:cdata];
    }
    
    // list fields
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    [request setPostValue:mode forKey:@"mode"];
    [request setPostValue:[NSString stringWithFormat:@"%d", perpage] forKey:@"perpage"];
    [request setPostValue:[NSString stringWithFormat:@"%d", numfilters] forKey:@"numfilters"];
    
    if(numfilters > 0)
    {
        NSInteger fieldnumber = 0;
        
        for(id customfield in customfilter)
        {
            NSString *ckey = [NSString stringWithFormat:@"lkey%d", fieldnumber];
            NSString *cdata = [NSString stringWithFormat:@"ldata%d", fieldnumber];
            NSString *value = [customfilter objectForKey:customfield];
            fieldnumber++;
            
            [request setPostValue:customfield forKey:ckey];
            [request setPostValue:value forKey:cdata];
        }
    }
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if(error)
    {
        return [[[PlaytomicResponse alloc] initWithError:1] autorelease];
    }
    
    NSString *response = [request responseString];       
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [json release];
    [parser release];
    
    // failed on the server side
    if(status != 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        return [[[PlaytomicResponse alloc] initWithError:errorcode] autorelease];
    }
    
    // score list completed
    NSDictionary *dvars = [data valueForKey:@"Data"];
    NSArray *scores = [dvars valueForKey:@"Scores"];
    NSInteger numscores = [[dvars valueForKey:@"NumScores"] integerValue];  
    NSMutableArray *md = [[NSMutableArray alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    for(id score in scores)
    {
        NSString *username = [score valueForKey:@"Name"];
        NSInteger points = [[score valueForKey:@"Points"] integerValue];
        NSString *relativedate = [score valueForKey:@"RDate"];
        NSDate *date = [df dateFromString:[score valueForKey:@"SDate"]];
        long rank = [[score valueForKey:@"Rank"] doubleValue];
        NSMutableDictionary *customdata = [[NSMutableDictionary alloc] init];
        
        NSDictionary *returnedcustomdata = [score valueForKey:@"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString *cvalue = [[returnedcustomdata valueForKey:key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject:cvalue forKey:key];
        }
        
        [md addObject:[[PlaytomicScore alloc] initWithName:username 
                                                 andPoints:points 
                                                   andDate:date 
                                           andRelativeDate:relativedate 
                                             andCustomData:customdata 
                                                   andRank:rank]];        
        [customdata release];
    }
    
    PlaytomicResponse *playtomicResponse = [[PlaytomicResponse alloc] initWithSuccess:YES 
                                                                         andErrorCode:0 
                                                                              andData:md 
                                                                        andNumResults:numscores];
    [playtomicResponse autorelease];
    [df release];
    [md release];
    
    return playtomicResponse;
}

// asynchronous calls
//
- (void)saveAsyncTable:(NSString*)table 
              andScore:(PlaytomicScore*)score 
            andHighest:(Boolean)highest 
    andAllowDuplicates:(Boolean)allowduplicates 
           andDelegate:(id<PlaytomicDelegate>)aDelegate;
{        
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/save.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    [request setPostValue:[score getName] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat:@"%d", [score getPoints]] forKey:@"points"];
    [request setPostValue:(allowduplicates ? @"y" : @"n") forKey:@"allowduplicates"];
    [request setPostValue:[PlaytomicEncrypt md5:[NSString stringWithFormat:@"%@%d"
                                                            , [Playtomic getSourceUrl]
                                                            , [score getPoints]]] 
                   forKey:@"auth"];
    
    NSDictionary* customdata = [score getCustomData];
    [request setPostValue: [NSString stringWithFormat:@"%d", [customdata count]] 
                   forKey:@"numfields"];
    
    NSInteger fieldnumber = 0;
    
    for(id customfield in customdata)
    {
        NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
        NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
        NSString *value = [customdata objectForKey:customfield];
        fieldnumber++;
        
        [request setPostValue:customfield forKey:ckey];
        [request setPostValue:value forKey:cdata];
    }
    
    delegate = aDelegate;
    
    [request setDelegate:self];
    request.didFinishSelector = @selector(requestSaveFinished:);
    [request startAsynchronous];
}

- (void)requestSaveFinished:(ASIHTTPRequest*)request
{
    if (!(delegate && [delegate respondsToSelector:@selector(requestSaveLeaderboardFinished:)])) {
        return;
    }
    
    NSError *error = [request error];
    
    if(error)
    {
        [delegate requestSaveLeaderboardFinished:[[[PlaytomicResponse alloc] initWithError:1] autorelease]];
        return;
    }
    
    NSString *response = [request responseString];       
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [json release];
    [parser release];
    
    if(status == 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        [delegate requestSaveLeaderboardFinished:[[[PlaytomicResponse alloc] initWithSuccess:YES 
                                                                                andErrorCode:errorcode] autorelease]]; 
    }
    else
    {
        //NSLog(@"failed here %@", response);
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        [delegate requestSaveLeaderboardFinished:[[[PlaytomicResponse alloc] initWithError:errorcode] autorelease]];
    }
}

- (void)listAsyncTable:(NSString*)table 
            andHighest:(Boolean)highest 
               andMode:(NSString*)mode 
               andPage:(NSInteger)page 
            andPerPage:(NSInteger)perpage 
       andCustomFilter:(NSDictionary*)customfilter 
           andDelegate:(id<PlaytomicDelegate>)aDelegate
{
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/list.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    [request setPostValue:mode forKey:@"mode"];
    [request setPostValue:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [request setPostValue:[NSString stringWithFormat:@"%d", perpage] forKey:@"perpage"];
    [request setPostValue:[NSString stringWithFormat:@"%d", numfilters] forKey:@"numfilters"];
    
    if(numfilters > 0)
    {
        NSInteger fieldnumber = 0;
        
        for(id customfield in customfilter)
        {
            NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
            NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
            NSString *value = [customfilter objectForKey:customfield];
            fieldnumber++;
            
            [request setPostValue:customfield forKey:ckey];
            [request setPostValue:value forKey:cdata];
        }
    }
    
    delegate = aDelegate;
    
    [request setDelegate:self];
    request.didFinishSelector = @selector(requestListFinished:);
    [request startAsynchronous];    
}

- (void)requestListFinished:(ASIHTTPRequest*)request
{
    if (!(delegate && [delegate respondsToSelector:@selector(requestListLeaderboardFinished:)])) {
        return;
    }

    NSError *error = [request error];
    
    // failed on the client / connectivty side
    if(error)
    {
        [delegate requestListLeaderboardFinished:[[PlaytomicResponse alloc] initWithError:1]];
        return;
    }
    
    // we got a response of some kind
    NSString *response = [request responseString];
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [request release];
    [json release];
    [parser release];
    
    // failed on the server side
    if(status != 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        [delegate requestListLeaderboardFinished:[[[PlaytomicResponse alloc] initWithError:errorcode] autorelease]];
         return;
    }
    
    // score list completed
    NSDictionary *dvars = [data valueForKey:@"Data"];
    NSArray *scores = [dvars valueForKey:@"Scores"];
    NSInteger numscores = [[dvars valueForKey:@"NumScores"] integerValue];  
    NSMutableArray *md = [[NSMutableArray alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    for(id score in scores)
    {
        NSString *username = [score valueForKey:@"Name"];
        NSInteger points = [[score valueForKey:@"Points"] integerValue];
        NSString *relativedate = [score valueForKey:@"RDate"];
        NSDate *date = [df dateFromString:[score valueForKey:@"SDate"]];
        long rank = [[score valueForKey:@"Rank"] doubleValue];
        NSMutableDictionary *customdata = [[NSMutableDictionary alloc] init];
        
        NSDictionary *returnedcustomdata = [score valueForKey:@"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString *cvalue = [[returnedcustomdata valueForKey:key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject:cvalue forKey:key];
        }
        
        [md addObject:[[PlaytomicScore alloc] initWithName:username 
                                                 andPoints:points 
                                                   andDate:date 
                                           andRelativeDate:relativedate 
                                             andCustomData:customdata 
                                                   andRank:rank]];
    }
    
    PlaytomicResponse *playtomicResponse = [[PlaytomicResponse alloc] initWithSuccess:YES 
                                                                         andErrorCode:0 
                                                                              andData:md 
                                                                        andNumResults:numscores];
    [playtomicResponse autorelease];
    [df release];
    [md release];
    
    [delegate requestListLeaderboardFinished: playtomicResponse];    
}

- (void)saveAndListAsyncTable:(NSString*)table 
                     andScore:(PlaytomicScore*)score 
                   andHighest:(Boolean)highest 
           andAllowDuplicates:(Boolean)allowduplicates 
                      andMode:(NSString*)mode 
                   andPerPage:(NSInteger)perpage 
              andCustomFilter:(NSDictionary*)customfilter 
                  andDelegate:(id<PlaytomicDelegate>)aDelegate
{
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/v2/leaderboards/saveandlist.aspx?swfid=%d&js=y"
                                                , [Playtomic getGameGuid]
                                                , [Playtomic getGameId]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    // common fields
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    
    // save fields
    [request setPostValue:[Playtomic getSourceUrl] forKey:@"url"];
    [request setPostValue:[score getName] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat:@"%d", [score getPoints]] forKey:@"points"];
    [request setPostValue:(allowduplicates ? @"y" : @"n") forKey:@"allowduplicates"];
    [request setPostValue:[PlaytomicEncrypt md5:[NSString stringWithFormat:@"%@%d"
                                                            , [Playtomic getSourceUrl]
                                                            , [score getPoints]]] 
                   forKey:@"auth"];
    
    NSDictionary *customdata = [score getCustomData];
    [request setPostValue:[NSString stringWithFormat:@"%d", [customdata count]] 
                   forKey:@"numfields"];
    
    NSInteger fieldnumber = 0;
    
    for(id customfield in customdata)
    {
        NSString *ckey = [NSString stringWithFormat:@"ckey%d", fieldnumber];
        NSString *cdata = [NSString stringWithFormat:@"cdata%d", fieldnumber];
        NSString *value = [customdata objectForKey:customfield];
        fieldnumber++;
        
        [request setPostValue:customfield forKey:ckey];
        [request setPostValue:value forKey:cdata];
    }
    
    // list fields
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    [request setPostValue:mode forKey:@"mode"];
    [request setPostValue:[NSString stringWithFormat:@"%d", perpage] forKey:@"perpage"];
    [request setPostValue:[NSString stringWithFormat:@"%d", numfilters] forKey:@"numfilters"];
    
    if(numfilters > 0)
    {
        NSInteger fieldnumber = 0;
        
        for(id customfield in customfilter)
        {
            NSString *ckey = [NSString stringWithFormat:@"lkey%d", fieldnumber];
            NSString *cdata = [NSString stringWithFormat:@"ldata%d", fieldnumber];
            NSString *value = [customfilter objectForKey:customfield];
            fieldnumber++;
            
            [request setPostValue:customfield forKey:ckey];
            [request setPostValue:value forKey:cdata];
        }
    }
    
    delegate = aDelegate;
    
    [request setDelegate:self];
    request.didFinishSelector = @selector(requestSaveAndListFinished:);
    [request startAsynchronous];    
}

- (void)requestSaveAndListFinished:(ASIHTTPRequest*)request
{
    if (!(delegate && [delegate respondsToSelector:@selector(requestSaveAndListLeaderboardFinished:)])) {
        return;
    }

    NSError *error = [request error];
    
    if(error)
    {
        [delegate requestSaveAndListLeaderboardFinished:[[[PlaytomicResponse alloc] initWithError:1] autorelease]];
        return;
    }
    
    NSString *response = [request responseString];       
    NSString *json = [[NSString alloc] initWithString:response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey:@"Status"] integerValue];
    
    [json release];
    [parser release];
    
    // failed on the server side
    if(status != 1)
    {
        NSInteger errorcode = [[data valueForKey:@"ErrorCode"] integerValue];
        [delegate requestSaveAndListLeaderboardFinished:[[[PlaytomicResponse alloc] initWithError:errorcode] autorelease]];
        return;
    }
    
    // score list completed
    NSDictionary *dvars = [data valueForKey:@"Data"];
    NSArray *scores = [dvars valueForKey:@"Scores"];
    NSInteger numscores = [[dvars valueForKey:@"NumScores"] integerValue];  
    NSMutableArray *md = [[NSMutableArray alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    for(id score in scores)
    {
        NSString *username = [score valueForKey:@"Name"];
        NSInteger points = [[score valueForKey:@"Points"] integerValue];
        NSString *relativedate = [score valueForKey:@"RDate"];
        NSDate *date = [df dateFromString:[score valueForKey:@"SDate"]];
        long rank = [[score valueForKey:@"Rank"] doubleValue];
        NSMutableDictionary *customdata = [[NSMutableDictionary alloc] init];
        
        NSDictionary *returnedcustomdata = [score valueForKey:@"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString *cvalue = [[returnedcustomdata valueForKey:key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject:cvalue forKey:key];
        }
        
        [md addObject:[[PlaytomicScore alloc] initWithName:username 
                                                 andPoints:points 
                                                   andDate:date 
                                           andRelativeDate:relativedate 
                                             andCustomData:customdata 
                                                   andRank:rank]];
        
        [customdata release];
    }
    
    PlaytomicResponse *playtomicResponse = [[PlaytomicResponse alloc] initWithSuccess:YES 
                                                                         andErrorCode:0 
                                                                              andData:md 
                                                                        andNumResults:numscores];
    [playtomicResponse autorelease];
    [df release];
    [md release];
    
    [delegate requestSaveAndListLeaderboardFinished:playtomicResponse];
}
@end
