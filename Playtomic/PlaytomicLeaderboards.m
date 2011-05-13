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

@implementation PlaytomicLeaderboards

- (PlaytomicResponse*) save: (NSString*) table andScore:(PlaytomicScore*) score andHighest: (Boolean)highest andAllowDuplicates: (Boolean)allowduplicates
{        
    // NSLog(@"Setting up the url");
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/leaderboards/save.aspx?swfid=%d&js=y&url=%@", [Playtomic getGameGuid], [Playtomic getGameId], [Playtomic getSourceUrl]];

    //NSLog(@"Setting up the request");
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:table forKey:@"table"];
    [request setPostValue:(highest ? @"y" : @"n") forKey:@"highest"];
    [request setPostValue:[score getName] forKey:@"name"];
    [request setPostValue:[NSString stringWithFormat: @"%d", [score getPoints]] forKey:@"points"];
    [request setPostValue:(allowduplicates ? @"y" : @"n") forKey:@"allowduplicates"];
    [request setPostValue:[PlaytomicEncrypt md5: [NSString stringWithFormat: @"%@%d", [Playtomic getSourceUrl], [score getPoints]]] forKey:@"auth"];
    
    NSDictionary* customdata = [score getCustomData];
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
    
    if(status == 1)
    {
        NSInteger errorcode = [[data valueForKey: @"ErrorCode"] integerValue];
        return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: errorcode]; 
    }
    else
    {
        NSLog(@"failed here %@", response);
        NSInteger errorcode = [[data valueForKey: @"ErrorCode"] integerValue];
        return [[PlaytomicResponse alloc] initWithError: errorcode];
    }
}

- (PlaytomicResponse*) list: (NSString*) table andHighest:(Boolean)highest andMode:(NSString*) mode andPage: (NSInteger) page andPerPage:(NSInteger) perpage andCustomFilter: (NSDictionary*) customfilter
{
    NSString *tablesafe = [table stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSInteger numfilters = customfilter == nil ? 0 : [customfilter count];
    NSString *url = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/leaderboards/list.aspx?swfid=%d&js=y&table=%@&mode=%@&page=%d&perpage=%d&numfilters=%d", [Playtomic getGameGuid], [Playtomic getGameId], tablesafe, mode, page, perpage, numfilters];

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
    
    // score list completed
    NSDictionary* dvars = [data valueForKey: @"Data"];
    NSArray* scores = [dvars valueForKey: @"Scores"];
    NSInteger numscores = [[dvars valueForKey: @"NumScores"] integerValue];  
    NSMutableArray * md = [[NSMutableArray alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    for(id score in scores)
    {
        NSString* username = [score valueForKey: @"Name"];
        NSInteger points = [[score valueForKey: @"Points"] integerValue];
        NSString* relativedate = [score valueForKey: @"RDate"];
        NSDate* date = [df dateFromString: [score valueForKey: @"SDate"]];
        NSMutableDictionary* customdata = [[NSMutableDictionary alloc] init];
        
        NSDictionary* returnedcustomdata = [score valueForKey: @"CustomData"];
        
        for(id key in returnedcustomdata)
        {
            NSString* cvalue = [[returnedcustomdata valueForKey: key] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cvalue = [cvalue stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [customdata setObject: cvalue forKey: key];
        }
        
        [md addObject: [[PlaytomicScore alloc] initWithName:username andPoints:points andDate:date andRelativeDate:relativedate andCustomData:customdata]];
    }
    
    return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: 0 andData: md andNumResults: numscores];
}


@end
