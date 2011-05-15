//
//  MyClass.m
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

#import "MyClass.h"
#import "Playtomic/Playtomic.h"
#import "Playtomic/PlaytomicScore.h"
#import "Playtomic/PlaytomicLevel.h"

@implementation MyClass

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        [[Playtomic alloc] initWithGameId: 0 andGUID: @""]; // Get your credentials from the Playtomic dashboard (add or select game then go to API page)
        [[Playtomic Log] view];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSString *hello = @"Playtomic iOS Test";
    CGPoint location = CGPointMake(10, 20);
    UIFont *font = [UIFont systemFontOfSize:24];
    [[UIColor whiteColor] set];
    [hello drawAtPoint:location withFont:font];
    
    UIButton *play = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    play.frame = CGRectMake(80.0, 100, 200.0, 30.0);
    [play setTitle:@"Log Play" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(logPlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:play];
    
    // custom metrics
    UIButton *custommetric = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetric.frame = CGRectMake(80.0, 150, 200.0, 30.0);
    [custommetric setTitle:@"Log Custom Metric" forState:UIControlStateNormal];
    [custommetric addTarget:self action:@selector(logCustomMetric) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:custommetric];
    
    UIButton *custommetricu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetricu.frame = CGRectMake(300.0, 150, 200.0, 30.0);
    [custommetricu setTitle:@"Log Custom Metric (U)" forState:UIControlStateNormal];
    [custommetricu addTarget:self action:@selector(logCustomMetricU) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:custommetricu];
    
    UIButton *custommetricng = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetricng.frame = CGRectMake(520.0, 150, 200.0, 30.0);
    [custommetricng setTitle:@"Log Custom Metric (NG)" forState:UIControlStateNormal];
    [custommetricng addTarget:self action:@selector(logCustomMetricNG) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:custommetricng];
    
    // level metrics
    UIButton *levelcounter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelcounter.frame = CGRectMake(80.0, 200, 200.0, 30.0);
    [levelcounter setTitle:@"Log Level Counter Metric" forState:UIControlStateNormal];
    [levelcounter addTarget:self action:@selector(logLevelCounter) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelcounter];
    
    UIButton *levelcounteru = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelcounteru.frame = CGRectMake(300.0, 200, 200.0, 30.0);
    [levelcounteru setTitle:@"Log Level Counter Metric (U)" forState:UIControlStateNormal];
    [levelcounteru addTarget:self action:@selector(logLevelCounterU) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelcounteru];
    
    UIButton *levelaverage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelaverage.frame = CGRectMake(80.0, 250, 200.0, 30.0);
    [levelaverage setTitle:@"Log Level Average Metric" forState:UIControlStateNormal];
    [levelaverage addTarget:self action:@selector(logLevelAverage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelaverage];
    
    UIButton *levelaverageu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelaverageu.frame = CGRectMake(300.0, 250, 200.0, 30.0);
    [levelaverageu setTitle:@"Log Level Average Metric (U)" forState:UIControlStateNormal];
    [levelaverageu addTarget:self action:@selector(logLevelAverageU) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelaverageu];
    
    UIButton *levelranged = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelranged.frame = CGRectMake(80.0, 300, 200.0, 30.0);
    [levelranged setTitle:@"Log Level Ranged Metric" forState:UIControlStateNormal];
    [levelranged addTarget:self action:@selector(logLevelRanged) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelranged];
    
    UIButton *levelrangedu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelrangedu.frame = CGRectMake(300.0, 300, 200.0, 30.0);
    [levelrangedu setTitle:@"Log Level Ranged Metric (U)" forState:UIControlStateNormal];
    [levelrangedu addTarget:self action:@selector(logLevelRangedU) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelrangedu];
    
    
    
    // gamevars
    UIButton *gamevars = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gamevars.frame = CGRectMake(80, 400, 200.0, 30.0);
    [gamevars setTitle:@"Load GameVars" forState:UIControlStateNormal];
    [gamevars addTarget:self action:@selector(loadGameVars) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:gamevars];
    
    // geoip
    UIButton *geoip = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    geoip.frame = CGRectMake(300, 400, 200.0, 30.0);
    [geoip setTitle:@"GeoIP" forState:UIControlStateNormal];
    [geoip addTarget:self action:@selector(loadGeoIP) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:geoip];
    
    // leaderboards
    UIButton *leaderboardlist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardlist.frame = CGRectMake(80, 500, 200.0, 30.0);
    [leaderboardlist setTitle:@"Leaderboard List" forState:UIControlStateNormal];
    [leaderboardlist addTarget:self action:@selector(leaderboardList) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leaderboardlist];
    
    UIButton *leaderboardsave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardsave.frame = CGRectMake(300, 500, 200.0, 30.0);
    [leaderboardsave setTitle:@"Leaderboard Save" forState:UIControlStateNormal];
    [leaderboardsave addTarget:self action:@selector(leaderboardSave) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leaderboardsave];

    // level sharing
    UIButton *levellist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levellist.frame = CGRectMake(80, 600, 200.0, 30.0);
    [levellist setTitle:@"Level List" forState:UIControlStateNormal];
    [levellist addTarget:self action:@selector(levelList) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levellist];
    
    UIButton *levelsave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelsave.frame = CGRectMake(300, 600, 200.0, 30.0);
    [levelsave setTitle:@"Level Save" forState:UIControlStateNormal];
    [levelsave addTarget:self action:@selector(levelSave) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelsave];
    
    UIButton *levelload = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelload.frame = CGRectMake(80, 650, 200.0, 30.0);
    [levelload setTitle:@"Level Load" forState:UIControlStateNormal];
    [levelload addTarget:self action:@selector(levelLoad) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelload];
    
    UIButton *levelrate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelrate.frame = CGRectMake(300, 650, 200.0, 30.0);
    [levelrate setTitle:@"Level Rate" forState:UIControlStateNormal];
    [levelrate addTarget:self action:@selector(levelRate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:levelrate];
    
    // data
    UIButton *dataViews = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataViews.frame = CGRectMake(80, 750, 200.0, 30.0);
    [dataViews setTitle:@"Load Views" forState:UIControlStateNormal];
    [dataViews addTarget:self action:@selector(getViews) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dataViews];
    
    UIButton *dataCustom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataCustom.frame = CGRectMake(300, 750, 200.0, 30.0);
    [dataCustom setTitle:@"Load Custom" forState:UIControlStateNormal];
    [dataCustom addTarget:self action:@selector(getCustom) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dataCustom];
}

// logging analytics
- (void) logPlay
{
    NSLog(@"Log play");
    [[Playtomic Log] play];
    [[Playtomic Log] forceSend];
}

- (void) logCustomMetric
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetric: @"custom" andGroup: @"group" andUnique: NO];
    [[Playtomic Log] forceSend];
}

- (void) logCustomMetricU
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetric: @"uniquecustom" andGroup: @"group" andUnique: YES];
    [[Playtomic Log] forceSend];
}

- (void) logCustomMetricNG
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetric: @"ungroupedcustom" andGroup: nil andUnique: NO];
    [[Playtomic Log] forceSend];
}

- (void) logLevelCounter
{
    NSLog(@"Log level counter metric");
    [[Playtomic Log] levelCounterMetric:@"counter" andLevel:@"named" andUnique:false];
    [[Playtomic Log] levelCounterMetric:@"counter" andLevelNumber:1 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void) logLevelCounterU
{
    NSLog(@"Log level counter metric (unique)");
    [[Playtomic Log] levelCounterMetric:@"counter" andLevel:@"named" andUnique:true];
    [[Playtomic Log] levelCounterMetric:@"counter" andLevelNumber:1 andUnique:true];
    [[Playtomic Log] forceSend];
}

- (void) logLevelAverage
{
    NSLog(@"Log level average metric");
    [[Playtomic Log] levelAverageMetric:@"average" andLevel:@"named" andValue: 100 andUnique:false];
    [[Playtomic Log] levelAverageMetric:@"average" andLevelNumber:1 andValue: 100 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void) logLevelAverageU
{
    NSLog(@"Log level average metric (unique)");
    [[Playtomic Log] levelAverageMetric:@"average" andLevel:@"named" andValue: 100 andUnique:true];
    [[Playtomic Log] levelAverageMetric:@"average" andLevelNumber:1 andValue: 100 andUnique:true];
    [[Playtomic Log] forceSend];
}

- (void) logLevelRanged
{
    NSLog(@"Log level ranged metric");
    [[Playtomic Log] levelRangedMetric:@"ranged" andLevel:@"named" andTrackValue: 10 andUnique:false];
    [[Playtomic Log] levelRangedMetric:@"ranged" andLevelNumber:1 andTrackValue: 20 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void) logLevelRangedU
{
    NSLog(@"Log level ranged metric (unique)");
    [[Playtomic Log] levelRangedMetric:@"ranged" andLevel:@"named" andTrackValue:30 andUnique:true];
    [[Playtomic Log] levelRangedMetric:@"ranged" andLevelNumber:1 andTrackValue:40 andUnique:true];
    [[Playtomic Log] forceSend];
}

// gamevars
- (void) loadGameVars
{
    NSLog(@"Loading GameVars");
    PlaytomicResponse *gamevars = [[Playtomic GameVars] load];
        
    if([gamevars success])
    {    

        NSLog(@"%@ = %@", @"GameVar1", [gamevars getValue: @"GameVar1"]);
        NSLog(@"%@ = %@", @"GameVar2", [gamevars getValue: @"GameVar2"]);
    }
    else
    {
        NSLog(@"GameVars failed to load because of errorcode #%d", [gamevars errorCode]);
    }
}

// gamevars
- (void) loadGeoIP
{
    NSLog(@"Loading GeoIP");
    
    PlaytomicResponse *lookup = [[Playtomic GeoIP] load];
    
    if([lookup success])
    {    
        
        NSLog(@"Location code: %@, name: %@", [lookup getValue: @"Code"], [lookup getValue: @"Name"]);
    }
    else
    {
        NSLog(@"GeoIP failed to load because of errorcode #%d", [lookup errorCode]);
    }
}

// leaderboards
- (void) leaderboardList
{
    NSLog(@"Leaderboard list");
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] list:@"High scores" andHighest:YES andMode:@"alltime" andPage:1 andPerPage:20 andCustomFilter:nil];
    
    if([response success])
    {
        NSLog(@"%d scores were returned:", [response getNumResults]);
        
        for(PlaytomicScore* score in [response data])
        {
            NSLog(@"%@ scored %d on %@", [score getName], [score getPoints], [score getRelativeDate]);
            
            if([[score getCustomData] count] > 0)
            {
                NSDictionary* data = [score getCustomData];
                
                for(id x in data)
                {
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey: x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Leaderboard list failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void) leaderboardSave
{
    NSLog(@"Leaderboard Save");
    
    PlaytomicScore* score = [[PlaytomicScore alloc] initNewScoreWithName:@"Ben" andPoints: 2000000];
    [score addCustomValue: @"customdata" andValue: @"this is the custom data"];
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] save:@"High scores" andScore:score andHighest:YES andAllowDuplicates:YES];
    
    if([response success])
    {
        NSLog(@"Score saved successfully");
    }
    else
    {
        NSLog(@"Leaderboard save failed to load because of errorcode #%d", [response errorCode]);
    }
}

// player levels
- (void) levelList
{
    NSLog(@"Level list");
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] list:@"popular" andPage:1 andPerPage:10 andIncludeData:NO andIncludeThumbs: NO andCustomFilter:nil];
    
    if([response success])
    {
        NSLog(@"%d levels were returned:", [response getNumResults]);
        
        for(PlaytomicLevel* level in [response data])
        {
            NSLog(@"%@ by %@ on %@ (%@) with %d votes and %d score and %@ rating and %d plays and levelid %@", [level getName], [level getPlayerName], [level getDate], [level getRelativeDate], [level getVotes], [level getScore], [level getRating], [level getPlays], [level getLevelId]);
            
            if([[level getCustomData] count] > 0)
            {
                NSDictionary* data = [level getCustomData];
                
                for(id x in data)
                {
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey: x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Level list failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void) levelSave
{
    NSLog(@"Level save");
    
    PlaytomicLevel* level = [[PlaytomicLevel alloc] initWithName: @"level name4" andPlayerName: @"ben4" andPlayerId: 0 andData: @"r=-152&i0=13,440,140&i1=24,440,140&i2=25,440,140&i3=37,440,140,ie,37,450,150"];
    PlaytomicResponse* response = [[Playtomic PlayerLevels] save: level];
    
    if([response success])
    {
        NSLog(@"Save succeeded: %@", [response getValue: @"levelid"]);
    }
    else
    {
        NSLog(@"Save failed because of errorcode #%d", [response errorCode]);
    }
}

- (void) levelRate
{
    NSLog(@"Level rate");
    
    [[Playtomic PlayerLevels] start: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] start: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] start: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] retry: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] win: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] quit: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic PlayerLevels] flag: @"4d2703f8cf1e8c28140028c6"];
    [[Playtomic Log] forceSend];
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] rate: @"4d2703f8cf1e8c28140028c6" andRating: 8];
    
    if([response success])
    {
        NSLog(@"Rate succeeded");
    }
    else
    {
        NSLog(@"Rate failed because of errorcode #%d", [response errorCode]);
    }
}

- (void) levelLoad
{
    NSLog(@"Level load");
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] load: @"4d260dfecf1e8c17940074c1"];
    
    if([response success])
    {
        NSLog(@"%d level was returned:", [response getNumResults]);
        
        for(PlaytomicLevel* level in [response data])
        {
            NSLog(@"%@ by %@ on %@ (%@) with %d votes and %d score and %@ rating and %d plays and levelid %@", [level getName], [level getPlayerName], [level getDate], [level getRelativeDate], [level getVotes], [level getScore], [level getRating], [level getPlays], [level getLevelId]);
            
            if([[level getCustomData] count] > 0)
            {
                NSDictionary* data = [level getCustomData];
                
                for(id x in data)
                {
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey: x]);
                }
            }
            
            NSLog(@" with data %@", [level getData]);
        }
    }
    else
    {
        NSLog(@"Level failed to load because of errorcode #%d", [response errorCode]);
    }
}

// data
- (void) getViews
{
    NSLog(@"get views");
    
    PlaytomicResponse* response = [[Playtomic Data] views];
    
    if([response success])
    {
        NSLog(@"data was returned: %@", [response getValue: @"Value"]);

    }
    else
    {
        NSLog(@"data failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void) getCustom
{
    NSLog(@"get custom");
    
    PlaytomicResponse* response = [[Playtomic Data] customMetric: @"hi"];
    
    if([response success])
    {
        NSLog(@"data was returned: %@", [response getValue: @"Value"]);
        
    }
    else
    {
        NSLog(@"data failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
