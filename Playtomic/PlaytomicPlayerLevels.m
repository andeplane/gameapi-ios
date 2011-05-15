//
//  PlaytomicPlayerLevels.m
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

#import "PlaytomicLevel.h"
#import "PlaytomicResponse.h"
#import "Playtomic.h"
#import "JSON/JSON.h"
#import "ASI/ASIFormDataRequest.h"
#import "ASI/ASIHTTPRequest.h"

@implementation PlaytomicPlayerLevels

-(PlaytomicResponse*) load:(NSString*) levelid
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/playerlevels/load.aspx?swfid=%d&js=m&levelid=%@", [Playtomic getGameGuid], [Playtomic getGameId], levelid];

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
    
    // level list completed
    NSDictionary* level = [data valueForKey: @"Data"];
    NSMutableArray* md = [[NSMutableArray alloc] init];
    
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    [nf setFormatterBehavior:NSNumberFormatterDecimalStyle];

    NSString* playerid = [level valueForKey: @"PlayerId"];
    NSString* playername = [[level valueForKey: @"PlayerName"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* playersource = [level valueForKey: @"PlayerSource"];
    NSString* name = [[level valueForKey: @"Name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* ldata = [[level valueForKey: @"Data"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* lthumb = [level valueForKey: @"Thumb"];
    NSInteger plays = [[level valueForKey: @"Plays"] integerValue];
    NSInteger votes = [[level valueForKey: @"Votes"] integerValue];
    NSInteger score = [[level valueForKey: @"Score"] integerValue];
    NSDecimalNumber* rating = [level valueForKey: @"Rating"];
    NSString* relativedate = [level valueForKey: @"RDate"];
    NSDate* date = [df dateFromString: [level valueForKey: @"SDate"]];   
    NSMutableDictionary* customdata = [[NSMutableDictionary alloc] init]; 
    NSDictionary* returnedcustomdata = [level valueForKey: @"CustomData"];
    
    for(id key in returnedcustomdata)
    {
        NSString* cvalue = [[returnedcustomdata valueForKey: key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        [customdata setObject: cvalue forKey: key];
    }
    
    [md addObject: [[PlaytomicLevel alloc] initWithName:name andPlayerName:playername andPlayerId:playerid andPlayerSource: playersource andData:ldata andThumb: lthumb andVotes:votes andPlays:plays andRating:rating andScore:score andDate:date andRelativeDate:relativedate andCustomData:customdata andLevelId: levelid]];

    return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: 0 andData: md andNumResults: 1];
}

-(PlaytomicResponse*) rate:(NSString*) levelid andRating: (NSInteger) rating
{
    if(rating < 1 || rating > 10)
    {
        return [[PlaytomicResponse alloc] initWithError: 401];
    }
    
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/playerlevels/rate.aspx?swfid=%d&js=m&levelid=%@&rating=%d", [Playtomic getGameGuid], [Playtomic getGameId], levelid, rating];
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
    NSInteger errorcode = [[data valueForKey: @"ErrorCode"] integerValue];
    
    // failed on the server side
    if(status != 1)
    {
        return [[PlaytomicResponse alloc] initWithError: errorcode];
    }
    
    return [[PlaytomicResponse alloc] initWithSuccess: YES andErrorCode: errorcode];
}

-(PlaytomicResponse*) list:(NSString*) mode andPage:(NSInteger) page andPerPage:(NSInteger) perpage andIncludeData: (Boolean) includedata andIncludeThumbs: (Boolean) includethumbs andCustomFilter: (NSDictionary*) customfilter;
{
    return [self listWithDateRange: mode andPage: page andPerPage: perpage andIncludeData: includedata andIncludeThumbs: includethumbs andCustomFilter: customfilter andDateMin: nil andDateMax: nil];
}

-(PlaytomicResponse*) listWithDateRange:(NSString*) mode andPage:(NSInteger) page andPerPage:(NSInteger) perpage andIncludeData: (Boolean) includedata andIncludeThumbs: (Boolean) includethumbs andCustomFilter: (NSDictionary*) customfilter andDateMin: (NSDate*) datemin andDateMax: (NSDate*) datemax
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    NSString *modesafe = mode == nil ? @"popular" : (mode == @"newest" || mode == @"popular" ? mode : @"popular");
    NSString *datasafe = includedata ? @"y" : @"n";
    NSString *thumbsafe = includethumbs ? @"y" : @"n";
    NSString *dateminsafe = datemin == nil ? @"" : [df stringFromDate:datemin];
    NSString *datemaxsafe = datemax == nil ? @"" : [df stringFromDate:datemax];
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/playerlevels/list.aspx?swfid=%d&js=m&mode=%@&page=%d&perpage=%d&data=%@&thumbs=%@&datemin=%@&datemax=%@&filters=%d", [Playtomic getGameGuid], [Playtomic getGameId], modesafe, page, perpage, datasafe, thumbsafe, dateminsafe, datemaxsafe, numfilters];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL: [NSURL URLWithString: url]];
    
    if(customfilter != nil)
    {
        NSInteger fieldnumber = 0;
            
        for(id customfield in customfilter)
        {
            NSString* ckey = [NSString stringWithFormat: @"ckey%d", fieldnumber];
            NSString* cdata = [NSString stringWithFormat: @"cdata%d", fieldnumber];
            NSString* value = [customfilter objectForKey: customfield];
            fieldnumber++;
            
            [request setPostValue: customfield forKey: ckey];
            [request setPostValue: value forKey: cdata];
        }
    }
    
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
    
    // level list completed
    NSDictionary* dvars = [data valueForKey: @"Data"];
    NSArray* levels = [dvars valueForKey: @"Levels"];
    NSInteger numlevels = [[dvars valueForKey: @"NumLevels"] integerValue];  
    NSMutableArray* md = [[NSMutableArray alloc] init];
        
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    [nf setFormatterBehavior:NSNumberFormatterDecimalStyle];
    
    for(id level in levels)
    {
        NSString* levelid = [level valueForKey: @"LevelId"];
        NSString* playerid = [level valueForKey: @"PlayerId"];
        NSString* playername = [[level valueForKey: @"PlayerName"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* playersource = [level valueForKey: @"PlayerSource"];
        NSString* name = [[level valueForKey: @"Name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* ldata = [[level valueForKey: @"Data"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* lthumb = [level valueForKey: @"Thumb"];
        NSInteger plays = [[level valueForKey: @"Plays"] integerValue];
        NSInteger votes = [[level valueForKey: @"Votes"] integerValue];
        NSInteger score = [[level valueForKey: @"Score"] integerValue];
        NSDecimalNumber* rating = [level valueForKey: @"Rating"];
        NSString* relativedate = [level valueForKey: @"RDate"];
        NSDate* date = [df dateFromString: [level valueForKey: @"SDate"]];   
        NSMutableDictionary* customdata = [[NSMutableDictionary alloc] init]; 
        NSDictionary* returnedcustomdata = [level valueForKey: @"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString* cvalue = [[returnedcustomdata valueForKey: key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject: cvalue forKey: key];
        }
        
        [md addObject: [[PlaytomicLevel alloc] initWithName:name andPlayerName:playername andPlayerId:playerid andPlayerSource: playersource andData:ldata andThumb: lthumb andVotes:votes andPlays:plays andRating:rating andScore:score andDate:date andRelativeDate:relativedate andCustomData:customdata andLevelId: levelid]];
    }
    
    return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: 0 andData: md andNumResults: numlevels];
}

-(PlaytomicResponse*) save:(PlaytomicLevel*) level
{
     NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/playerlevels/save.aspx?swfid=%d&js=y&url=%@", [Playtomic getGameGuid], [Playtomic getGameId], [Playtomic getSourceUrl]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[level getData] forKey:@"data"];
    [request setPostValue:[level getPlayerId] forKey:@"playerid"];
    [request setPostValue:[level getPlayerName] forKey:@"playername"];
    [request setPostValue:[Playtomic getBaseUrl] forKey:@"playersource"];
    [request setPostValue:[level getName] forKey:@"name"];
    [request setPostValue:@"y" forKey:@"nothumb"];
    
    NSDictionary* customdata = [level getCustomData];
    [request setPostValue: [NSString stringWithFormat: @"%d", [customdata count]] forKey: @"customfields"];
    
    NSInteger fieldnumber = 0;
    
    for(id customfield in customdata)
    {
        NSString* ckey = [NSString stringWithFormat: @"ckey%d", fieldnumber];
        NSString* cdata = [NSString stringWithFormat: @"cdata%d", fieldnumber];
        NSString* value = [customdata objectForKey: customfield];
        fieldnumber++;
        
        [request setPostValue: customfield forKey: ckey];
        [request setPostValue: value forKey: cdata];
    }
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if(error)
    {
        return [[PlaytomicResponse alloc] initWithError: 1];
    }
    
    NSString *response = [request responseString];       
    NSString *json = [[NSString alloc] initWithString: response];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *data = [parser objectWithString:json error:nil];
    NSInteger status = [[data valueForKey: @"Status"] integerValue];
    NSInteger errorcode = [[data valueForKey: @"ErrorCode"] integerValue];

    if(status == 1)
    {
        NSDictionary* dvars = [data valueForKey: @"Data"];
        NSString *levelid = [dvars valueForKey: @"LevelId"];
        
        NSMutableDictionary* md = [[NSMutableDictionary alloc] init];
        [md setValue: levelid forKey: @"LevelId"];
                
        return [[PlaytomicResponse alloc] initWithSuccess:YES andErrorCode: errorcode andDict: md];
    }
    else
    {
        return [[PlaytomicResponse alloc] initWithError: errorcode];
    }
}

-(void) start: (NSString*) levelid
{
    [[Playtomic Log] playerLevelStart: levelid];
}

-(void) retry: (NSString*) levelid
{
    [[Playtomic Log] playerLevelRetry: levelid];
}

-(void) win: (NSString*) levelid
{
    [[Playtomic Log] playerLevelWin: levelid];
}

-(void) quit: (NSString*) levelid
{
    [[Playtomic Log] playerLevelQuit: levelid];
}

-(void) flag: (NSString*) levelid
{
    [[Playtomic Log] playerLevelFlag: levelid];
}

- (NSString*) clean: (NSString*) string
{    
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"\\"];
    string = [string stringByReplacingOccurrencesOfString:@"~" withString:@"-"];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}

@end
