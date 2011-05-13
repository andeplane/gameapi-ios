//
//  PlaytomicLink.h
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

#import "PlaytomicData.h"
#import "PlaytomicResponse.h"
#import "Playtomic.h"
#import "JSON/JSON.h"
#import "ASI/ASIHTTPRequest.h"

@implementation PlaytomicData

// general stats
- (PlaytomicResponse*) views
{
    return [self general: @"views" andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) views: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"views" andDay: 0 andMonth: month andYear: year];
}

- (PlaytomicResponse*) views: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"views" andDay: day andMonth: month andYear: year];
}

- (PlaytomicResponse*) plays
{
    return [self general: @"plays" andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) plays: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"plays" andDay: 0 andMonth: month andYear: year];
}

- (PlaytomicResponse*) plays: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"plays" andDay: day andMonth: month andYear: year];
}

- (PlaytomicResponse*) playtime
{
    return [self general: @"playtime" andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) playtime: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"playtime" andDay: 0 andMonth: month andYear: year];
}

- (PlaytomicResponse*) playtime: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self general: @"playtime" andDay: day andMonth: month andYear: year];
}

- (PlaytomicResponse*) general: (NSString*) mode andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    NSString* url = [NSString stringWithFormat: @"http://g%@.api.playtomic.com/data/%@.aspx?swfid=%d&js=m&&day=%d&month=%d&year=%d", [Playtomic getGameGuid], mode, [Playtomic getGameId], day, month, year];
    return [self getData: url];
}

// custom metrics
- (PlaytomicResponse*) customMetric: (NSString*) name
{
    return [self customMetric: name andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) customMetric: (NSString*) name andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self customMetric: name andDay: 0 andMonth: month andYear: year];
}

- (PlaytomicResponse*) customMetric: (NSString*) name andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    NSString* url = [NSString stringWithFormat: @"http://g%@.api.playtomic.com/data/custommetric.aspx?swfid=%d&js=m&&metric=%@&day=%d&month=%d&year=%d", [Playtomic getGameGuid], [Playtomic getGameId], [self clean: name], day, month, year];
    return [self getData: url];
}

// level counters
- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevel: (NSString*) level
{
    return [self levelMetric: @"counter" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevel: (NSString*) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"counter" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevel: (NSString*) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"counter" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevelNumber: (NSInteger) level
{
    return [self levelMetric: @"counter" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevelNumber: (NSInteger) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"counter" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelCounterMetric: (NSString*) name andLevelNumber: (NSInteger) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"counter" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

// level averages
- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevel: (NSString*) level
{
    return [self levelMetric: @"average" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevel: (NSString*) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"average" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevel: (NSString*) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"average" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevelNumber: (NSInteger) level
{
    return [self levelMetric: @"average" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevelNumber: (NSInteger) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"average" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelAverageMetric: (NSString*) name andLevelNumber: (NSInteger) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"average" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

// level rangeds
- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevel: (NSString*) level
{
    return [self levelMetric: @"ranged" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevel: (NSString*) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"ranged" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevel: (NSString*) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"ranged" andName: name andLevel: level andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevelNumber: (NSInteger) level
{
    return [self levelMetric: @"ranged" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevelNumber: (NSInteger) level andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"ranged" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelRangedMetric: (NSString*) name andLevelNumber: (NSInteger) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    return [self levelMetric: @"ranged" andName: name andLevel: [NSString stringWithFormat: @"%d", level] andDay: 0 andMonth: 0 andYear: 0];
}

- (PlaytomicResponse*) levelMetric: (NSString*) type andName: (NSString*) name andLevel: (NSString*) level andDay: (NSInteger) day andMonth: (NSInteger) month andYear: (NSInteger) year
{
    NSString* url = [NSString stringWithFormat: @"http://g%@.api.playtomic.com/data/levelmetric%@.aspx?swfid=%d&js=m&metric=%@&level=%@&day=%d&month=%d&year=%d", [Playtomic getGameGuid], type, [Playtomic getGameId], [self clean: name], [self clean: level], day, month, year];
    return [self getData: url];
}

// get data
- (PlaytomicResponse*) getData: (NSString*) url
{    
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
        [md setObject: [dvars valueForKey: key] forKey: key];
    }
    
    return [[PlaytomicResponse alloc] initWithSuccess: true andErrorCode: 0 andDict: md];
}

- (NSString*) clean: (NSString*) string
{    
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"\\"];
    string = [string stringByReplacingOccurrencesOfString:@"~" withString:@"-"];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}

@end
