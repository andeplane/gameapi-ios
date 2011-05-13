//
//  PlaytomicLog.m
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "PlaytomicLog.h"
#import "Playtomic.h"

@interface PlaytomicLog ()
@property (nonatomic,copy) NSString *trackUrl;
@property (nonatomic,copy) NSString *sourceUrl;
@property (nonatomic,copy) NSString *baseUrl;
@property (nonatomic,readwrite) Boolean enabled;
@property (nonatomic,retain) NSTimer *playTimer;
@property (nonatomic,retain) NSTimer *firstPing;
@property (nonatomic,readwrite) NSInteger pings;
@property (nonatomic,readwrite) NSInteger plays;
@property (nonatomic,readwrite) NSInteger views;
@property (nonatomic,readwrite) Boolean frozen;
@property (nonatomic,retain) NSMutableArray *queue;
@property (nonatomic,retain) NSMutableArray *customMetrics;
@property (nonatomic,retain) NSMutableArray *levelCounters;
@property (nonatomic,retain) NSMutableArray *levelAverages;
@property (nonatomic,retain) NSMutableArray *levelRangeds;
@end

@implementation PlaytomicLog
@synthesize trackUrl;
@synthesize sourceUrl;
@synthesize baseUrl;
@synthesize enabled;
@synthesize playTimer;
@synthesize firstPing;
@synthesize views;
@synthesize pings;
@synthesize plays;
@synthesize frozen;
@synthesize queue;
@synthesize customMetrics;
@synthesize levelCounters;
@synthesize levelAverages;
@synthesize levelRangeds;

- (id)initWithGameId: (NSInteger) gameid andGUID:(NSString*) gameguid 
{
    self.sourceUrl = [Playtomic getSourceUrl];
    self.baseUrl = [Playtomic getBaseUrl];
    self.trackUrl = [NSString stringWithFormat:@"http://g%@.api.playtomic.com/tracker/q.aspx?swfid=%d&url=%@&q=", gameguid, gameid, sourceUrl];
    self.enabled = YES;
    self.views = [self getCookie: @"views"];
    self.plays = [self getCookie: @"plays"];
    self.pings = 0;
    self.frozen = NO;    
    self.queue = [NSMutableArray array];
    self.customMetrics = [NSMutableArray array];
    self.levelCounters = [NSMutableArray array];
    self.levelAverages = [NSMutableArray array];
    self.levelRangeds = [NSMutableArray array];
    self.firstPing = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(pingServer) userInfo:nil repeats:NO];
    
    //NSLog(@"Initialised PlaytomicLog with\nsource url: %@\nbase url: %@\ntrackurl: %@", self.sourceUrl, self.baseUrl, self.trackUrl);
    return self;
}

- (void) view 
{
    [self send: [NSString stringWithFormat: @"v/%d", self.views + 1] andCommit: YES];
}

- (void) play 
{
    //NSLog(@"[PlaytomicLog play]");
    [self send: [NSString stringWithFormat: @"p/%d", self.plays + 1] andCommit: YES];
}

- (void) pingServer
{
    self.pings++;
    [self send: [NSString stringWithFormat: @"t/%@/%d", (self.pings == 1 ? @"y" : @"n"), self.pings] andCommit: YES];
    
    if(self.pings == 1)
    {
        self.firstPing = nil;
        [self.firstPing dealloc];
        self.playTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(pingServer) userInfo:nil repeats:YES];
    }
}

// custom metrics
- (void) customMetric: (NSString*) name andGroup:(NSString*) group andUnique:(Boolean)unique
{
    if(group == nil)
        group = @"";
    
    if(unique == YES)
    {
        if([self.customMetrics containsObject: name])
        {
            return;
        }
        
        [self.customMetrics addObject: name];
    }
    
    [self send: [NSString stringWithFormat: @"c/%@/%@", [self clean: name], [self clean: group]] andCommit: NO];
}

// links
- (void) link 
{ 
}

- (void) heatmap 
{
}

- (void) funnel 
{
}

// level metrics
- (void) levelCounterMetric:(NSString*) name andLevelNumber:(NSInteger) levelnumber andUnique:(Boolean)unique
{
    [self levelCounterMetric: name andLevel: [NSString stringWithFormat:@"%d",levelnumber] andUnique: unique];
}

- (void) levelCounterMetric:(NSString*) name andLevel:(NSString*) level andUnique:(Boolean)unique
{
    NSString *nameclean = [self clean: name];
    NSString *levelclean = [self clean: level];
    
    if(unique == YES)
    {
        NSString *key = [NSString stringWithFormat: @"%@.%@", nameclean, levelclean];
                         
        if([self.levelCounters containsObject: key])
        {
            return;
        }
        
        [self.levelCounters addObject: key];
    }
    
    [self send: [NSString stringWithFormat: @"lc/%@/%@", nameclean, levelclean] andCommit: NO];
}

- (void) levelRangedMetric:(NSString*) name andLevelNumber:(NSInteger) levelnumber andTrackValue:(NSUInteger) trackvalue andUnique:(Boolean)unique
{
    [self levelRangedMetric: name andLevel: [NSString stringWithFormat:@"%d",levelnumber] andTrackValue: trackvalue andUnique: unique];
}

- (void) levelRangedMetric:(NSString*) name andLevel:(NSString*) level andTrackValue:(NSUInteger) trackvalue andUnique:(Boolean)unique
{
    NSString *nameclean = [self clean: name];
    NSString *levelclean = [self clean: level];
    
    if(unique == YES)
    {
        NSString *key = [NSString stringWithFormat: @"%@.%@.%d", nameclean, levelclean, trackvalue];
        
        if([self.levelRangeds containsObject: key])
        {
            return;
        }
        
        [self.levelRangeds addObject: key];
    }
    
    [self send: [NSString stringWithFormat: @"lr/%@/%@/%d", nameclean, levelclean, trackvalue] andCommit: NO];
}

- (void) levelAverageMetric:(NSString*) name andLevelNumber:(NSInteger) levelnumber andValue:(NSUInteger) value andUnique:(Boolean)unique
{
    [self levelAverageMetric: name andLevel: [NSString stringWithFormat:@"%d",levelnumber] andValue: value andUnique: unique];
}

- (void) levelAverageMetric:(NSString*) name andLevel:(NSString*) level andValue:(NSUInteger) value andUnique:(Boolean)unique
{
    NSString *nameclean = [self clean: name];
    NSString *levelclean = [self clean: level];
    
    if(unique == YES)
    {
        NSString *key = [NSString stringWithFormat: @"%@.%@", nameclean, levelclean];
        
        if([self.levelAverages containsObject: key])
        {
            return;
        }
        
        [self.levelAverages addObject: key];
    }
    
    [self send: [NSString stringWithFormat: @"la/%@/%@/%d", nameclean, levelclean, value] andCommit: NO]; 
}



// player levels
- (void) playerLevelStart 
{
}

- (void) playerLevelWin 
{
}

- (void) playerLevelQuit 
{
}

- (void) playerLevelFlag 
{
}

// misc
- (void) freeze 
{
    self.frozen = YES;
}

- (void) unfreeze 
{
    self.frozen = NO;
    [self forceSend];
}

- (void) forceSend 
{
    //NSLog(@"[PlaytomicLog forceSend]");
    
    if([self.queue count] > 0)
    {
        //NSLog(@" - sending %d events", [self.queue count]);
        PlaytomicLogRequest *request = [[PlaytomicLogRequest alloc] initWithTrackUrl: self.trackUrl];
        [request massQueue: self.queue];
    }
}
     
- (void) send: (NSString*) event andCommit:(Boolean) commit
{
    //NSLog(@"[PlaytomicLog send]");
    [self.queue addObject: event];
    
    if(self.frozen == YES || commit == NO)
    {
        //NSLog(@"- frozen, or not committing");
        return;
    }
    
    //NSLog(@"- sending");
    PlaytomicLogRequest *request = [[PlaytomicLogRequest alloc] initWithTrackUrl: self.trackUrl];
    [request massQueue: self.queue];
    [self.queue removeAllObjects];
}

- (NSString*) clean: (NSString*) string
{    
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"\\"];
    string = [string stringByReplacingOccurrencesOfString:@"~" withString:@"-"];
    return string;
}

- (NSInteger) getCookie: (NSString*) name
{
    return 0;
}

- (void) saveCookie 
{
}

- (void) increaseViews
{
    views++;
    
}

- (void) increasePlays
{
    plays++;
}


@end