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

@implementation MyClass

@synthesize levelid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Get your credentials from the Playtomic dashboard 
        // (add or select game then go to API page)
        //
        [[Playtomic alloc] initWithGameId:4603 andGUID:@"9f3f3b43cb234025" andAPIKey:@"548435a4e71445b49f939fd33d5185"]; 
        [[Playtomic Log] view];
    }    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    int top = 100;
    int const col1 = 20;
    int const col2 = 240;
    
    NSString *hello = @"Playtomic iOS Test";
    CGPoint location = CGPointMake(10, 20);
    UIFont *font = [UIFont systemFontOfSize:24];
    [[UIColor whiteColor] set];
    [hello drawAtPoint:location withFont:font];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:rect];
    scroll.showsVerticalScrollIndicator = YES;
    scroll.showsHorizontalScrollIndicator = YES;
    [self addSubview:scroll];
    
    UIButton *play = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    play.frame = CGRectMake(col1, top, 200.0, 30.0);
    [play setTitle:@"Log Play" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(logPlay) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:play];
    
    top += 50;
    
    // custom metrics
    UIButton *custommetric = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetric.frame = CGRectMake(col1, top, 200.0, 30.0);
    [custommetric setTitle:@"Log Custom Metric" forState:UIControlStateNormal];
    [custommetric addTarget:self action:@selector(logCustomMetric) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:custommetric];
    
    UIButton *custommetricu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetricu.frame = CGRectMake(col2, top, 200.0, 30.0);
    [custommetricu setTitle:@"Log Custom Metric (U)" forState:UIControlStateNormal];
    [custommetricu addTarget:self action:@selector(logCustomMetricU) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:custommetricu];
    
    top += 50;
    
    UIButton *custommetricng = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    custommetricng.frame = CGRectMake(col1, top, 200.0, 30.0);
    [custommetricng setTitle:@"Log Custom Metric (NG)" forState:UIControlStateNormal];
    [custommetricng addTarget:self action:@selector(logCustomMetricNG) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:custommetricng];
    
    top += 100;
    
    // level metrics
    UIButton *levelcounter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelcounter.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levelcounter setTitle:@"Log Level Counter Metric" forState:UIControlStateNormal];
    [levelcounter addTarget:self action:@selector(logLevelCounter) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelcounter];
    
    UIButton *levelcounteru = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelcounteru.frame = CGRectMake(col2, top, 250.0, 30.0);
    [levelcounteru setTitle:@"Log Level Counter Metric (U)" forState:UIControlStateNormal];
    [levelcounteru addTarget:self action:@selector(logLevelCounterU) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelcounteru];

    top += 50;
    
    UIButton *levelaverage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelaverage.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levelaverage setTitle:@"Log Level Average Metric" forState:UIControlStateNormal];
    [levelaverage addTarget:self action:@selector(logLevelAverage) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelaverage];
    
    UIButton *levelaverageu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelaverageu.frame = CGRectMake(col2, top, 250.0, 30.0);
    [levelaverageu setTitle:@"Log Level Average Metric (U)" forState:UIControlStateNormal];
    [levelaverageu addTarget:self action:@selector(logLevelAverageU) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelaverageu];
    
    top += 50;
    
    UIButton *levelranged = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelranged.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levelranged setTitle:@"Log Level Ranged Metric" forState:UIControlStateNormal];
    [levelranged addTarget:self action:@selector(logLevelRanged) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelranged];
    
    UIButton *levelrangedu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelrangedu.frame = CGRectMake(col2, top, 250.0, 30.0);
    [levelrangedu setTitle:@"Log Level Ranged Metric (U)" forState:UIControlStateNormal];
    [levelrangedu addTarget:self action:@selector(logLevelRangedU) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelrangedu];    
    
    top += 100;
    
    // gamevars
    UIButton *gamevars = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gamevars.frame = CGRectMake(col1, top, 200.0, 30.0);
    [gamevars setTitle:@"Load GameVars" forState:UIControlStateNormal];
    [gamevars addTarget:self action:@selector(loadGameVars) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:gamevars];

    UIButton *gamevarsasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gamevarsasync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [gamevarsasync setTitle:@"Load GameVars Async" forState:UIControlStateNormal];
    [gamevarsasync addTarget:self action:@selector(loadGameVarsAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:gamevarsasync];

    top += 100;
    
    // geoip
    UIButton *geoip = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    geoip.frame = CGRectMake(col1, top, 200.0, 30.0);
    [geoip setTitle:@"GeoIP" forState:UIControlStateNormal];
    [geoip addTarget:self action:@selector(loadGeoIP) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:geoip];

    UIButton *geoipasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    geoipasync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [geoipasync setTitle:@"GeoIP Async" forState:UIControlStateNormal];
    [geoipasync addTarget:self action:@selector(loadGeoIPAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:geoipasync];

    top += 100;
    
    // leaderboards
    UIButton *leaderboardlist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardlist.frame = CGRectMake(col1, top, 200.0, 30.0);
    [leaderboardlist setTitle:@"Leaderboard List" forState:UIControlStateNormal];
    [leaderboardlist addTarget:self action:@selector(leaderboardList) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardlist];
    
    UIButton *leaderboardsave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardsave.frame = CGRectMake(col2, top, 200.0, 30.0);
    [leaderboardsave setTitle:@"Leaderboard Save" forState:UIControlStateNormal];
    [leaderboardsave addTarget:self action:@selector(leaderboardSave) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardsave];
    
    top += 50;
    
    UIButton *leaderboardlistAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardlistAsync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [leaderboardlistAsync setTitle:@"Leaderboard List Async" forState:UIControlStateNormal];
    [leaderboardlistAsync addTarget:self action:@selector(leaderboardListAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardlistAsync];

    UIButton *leaderboardsaveasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardsaveasync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [leaderboardsaveasync setTitle:@"Leaderboard Save Async" forState:UIControlStateNormal];
    [leaderboardsaveasync addTarget:self action:@selector(leaderboardSaveAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardsaveasync];

    top += 50;
    
    UIButton *leaderboardsaveandlist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardsaveandlist.frame = CGRectMake(col1, top, 300.0, 30.0);
    [leaderboardsaveandlist setTitle:@"Leaderboard Save and List" forState:UIControlStateNormal];
    [leaderboardsaveandlist addTarget:self action:@selector(leaderboardSaveAndList) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardsaveandlist];

    top += 50;
    
    UIButton *leaderboardsaveandlistasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leaderboardsaveandlistasync.frame = CGRectMake(col1, top, 300.0, 30.0);
    [leaderboardsaveandlistasync setTitle:@"Leaderboard Save and List Async" forState:UIControlStateNormal];
    [leaderboardsaveandlistasync addTarget:self action:@selector(leaderboardSaveAndListAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:leaderboardsaveandlistasync];
    
    top += 100;
    
    // level sharing
    UIButton *levellist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levellist.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levellist setTitle:@"Level List" forState:UIControlStateNormal];
    [levellist addTarget:self action:@selector(levelList) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levellist];
    
    UIButton *levelsave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelsave.frame = CGRectMake(col2, top, 200.0, 30.0);
    [levelsave setTitle:@"Level Save" forState:UIControlStateNormal];
    [levelsave addTarget:self action:@selector(levelSave) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelsave];
    
    top += 50;
    
    UIButton *levellistasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levellistasync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levellistasync setTitle:@"Level List Async" forState:UIControlStateNormal];
    [levellistasync addTarget:self action:@selector(levelListAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levellistasync];
    
    UIButton *levelsaveasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelsaveasync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [levelsaveasync setTitle:@"Level Save Async" forState:UIControlStateNormal];
    [levelsaveasync addTarget:self action:@selector(levelSaveAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelsaveasync];
    
    top += 50;

    UIButton *levelload = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelload.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levelload setTitle:@"Level Load" forState:UIControlStateNormal];
    [levelload addTarget:self action:@selector(levelLoad) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelload];
    
    UIButton *levelrate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelrate.frame = CGRectMake(col2, top, 200.0, 30.0);
    [levelrate setTitle:@"Level Rate" forState:UIControlStateNormal];
    [levelrate addTarget:self action:@selector(levelRate) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelrate];
    
    top += 50;
    
    UIButton *levelloadasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelloadasync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [levelloadasync setTitle:@"Level Load Async" forState:UIControlStateNormal];
    [levelloadasync addTarget:self action:@selector(levelLoadAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelloadasync];
    
    UIButton *levelrateasync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelrateasync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [levelrateasync setTitle:@"Level Rate Async" forState:UIControlStateNormal];
    [levelrateasync addTarget:self action:@selector(levelRateAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:levelrateasync];

    top += 100;
    
    // data
    UIButton *dataViews = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataViews.frame = CGRectMake(col1, top, 200.0, 30.0);
    [dataViews setTitle:@"Load Views" forState:UIControlStateNormal];
    [dataViews addTarget:self action:@selector(getViews) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:dataViews];
    
    UIButton *dataCustom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataCustom.frame = CGRectMake(col2, top, 200.0, 30.0);
    [dataCustom setTitle:@"Load Custom" forState:UIControlStateNormal];
    [dataCustom addTarget:self action:@selector(getCustom) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:dataCustom];

    top +=50;
    
    UIButton *dataViewsAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataViewsAsync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [dataViewsAsync setTitle:@"Load Views Async" forState:UIControlStateNormal];
    [dataViewsAsync addTarget:self action:@selector(getViewsAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:dataViewsAsync];
    
    UIButton *dataCustomAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataCustomAsync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [dataCustomAsync setTitle:@"Load Custom Async" forState:UIControlStateNormal];
    [dataCustomAsync addTarget:self action:@selector(getCustomAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:dataCustomAsync];
   
    top += 50;

    UIButton *playsAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playsAsync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [playsAsync setTitle:@"Load Plays Async" forState:UIControlStateNormal];
    [playsAsync addTarget:self action:@selector(getPlaysAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:playsAsync];
    
    UIButton *playtimeAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playtimeAsync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [playtimeAsync setTitle:@"Load Playtime Async" forState:UIControlStateNormal];
    [playtimeAsync addTarget:self action:@selector(getPlaytimeAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:playtimeAsync];
    
    top += 50;

    UIButton *countersAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    countersAsync.frame = CGRectMake(col1, top, 200.0, 30.0);
    [countersAsync setTitle:@"Load Counters Async" forState:UIControlStateNormal];
    [countersAsync addTarget:self action:@selector(getCounterMetricAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:countersAsync];
    
    top += 100;
    
    UIButton *freeze = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    freeze.frame = CGRectMake(col1, top, 200.0, 30.0);
    [freeze setTitle:@"Freeze" forState:UIControlStateNormal];
    [freeze addTarget:self action:@selector(freeze) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:freeze];

    top += 50;
    
    UIButton *unfreeze = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    unfreeze.frame = CGRectMake(col1, top, 200.0, 30.0);
    [unfreeze setTitle:@"Unfreeze" forState:UIControlStateNormal];
    [unfreeze addTarget:self action:@selector(unfreeze) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:unfreeze];
    
    top += 100;
    
    UIButton *createPrivate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createPrivate.frame = CGRectMake(col1, top, 200.0, 30.0);
    [createPrivate setTitle:@"Create Private Leaderboard" forState:UIControlStateNormal];
    [createPrivate addTarget:self action:@selector(leaderboardCreatePrivate) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:createPrivate];
    
    UIButton *createPrivateAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createPrivateAsync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [createPrivateAsync setTitle:@"Create Private Leaderboard (Async)" forState:UIControlStateNormal];
    [createPrivateAsync addTarget:self action:@selector(leaderboardCreatePrivateAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:createPrivateAsync];
    
    top += 50;
    
    UIButton *loadPrivate= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadPrivate.frame = CGRectMake(col1, top, 200.0, 30.0);
    [loadPrivate setTitle:@"Load Private Leaderboard" forState:UIControlStateNormal];
    [loadPrivate addTarget:self action:@selector(leaderboardLoadPrivate) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:loadPrivate];
    
    UIButton *loadPrivateAsync = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadPrivateAsync.frame = CGRectMake(col2, top, 200.0, 30.0);
    [loadPrivateAsync setTitle:@"Load Private Leaderboard (Async)" forState:UIControlStateNormal];
    [loadPrivateAsync addTarget:self action:@selector(leaderboardLoadPrivateAsync) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:loadPrivateAsync];
    
    top += 150;
    
    scroll.contentSize = CGSizeMake(800, top);
    
    [scroll release];
}

// logging analytics
- (void)logPlay
{
    NSLog(@"Log play");
    [[Playtomic Log] play];
    [[Playtomic Log] forceSend];
}

- (void)logCustomMetric
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetricName:@"custom" andGroup:@"group" andUnique:NO];
    //[[Playtomic Log] forceSend];
}

- (void)logCustomMetricU
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetricName:@"uniquecustom" andGroup:@"group" andUnique:YES];
    [[Playtomic Log] forceSend];
}

- (void)logCustomMetricNG
{
    NSLog(@"Log custom metric");
    [[Playtomic Log] customMetricName:@"ungroupedcustom" andGroup:nil andUnique:NO];
    [[Playtomic Log] forceSend];
}

- (void)logLevelCounter
{
    NSLog(@"Log level counter metric");
    [[Playtomic Log] levelCounterMetricName:@"counter" andLevel:@"named" andUnique:false];
    [[Playtomic Log] levelCounterMetricName:@"counter" andLevelNumber:1 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void)logLevelCounterU
{
    NSLog(@"Log level counter metric (unique)");
    [[Playtomic Log] levelCounterMetricName:@"counter" andLevel:@"named" andUnique:true];
    [[Playtomic Log] levelCounterMetricName:@"counter" andLevelNumber:1 andUnique:true];
    [[Playtomic Log] forceSend];
}

- (void)logLevelAverage
{
    NSLog(@"Log level average metric");
    [[Playtomic Log] levelAverageMetricName:@"average" andLevel:@"named" andValue:100 andUnique:false];
    [[Playtomic Log] levelAverageMetricName:@"average" andLevelNumber:1 andValue:100 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void)logLevelAverageU
{
    NSLog(@"Log level average metric (unique)");
    [[Playtomic Log] levelAverageMetricName:@"average" andLevel:@"named" andValue:100 andUnique:true];
    [[Playtomic Log] levelAverageMetricName:@"average" andLevelNumber:1 andValue:100 andUnique:true];
    [[Playtomic Log] forceSend];
}

- (void)logLevelRanged
{
    NSLog(@"Log level ranged metric");
    [[Playtomic Log] levelRangedMetricName:@"ranged" andLevel:@"named" andTrackValue:10 andUnique:false];
    [[Playtomic Log] levelRangedMetricName:@"ranged" andLevelNumber:1 andTrackValue:20 andUnique:false];
    [[Playtomic Log] forceSend]; 
}

- (void)logLevelRangedU
{
    NSLog(@"Log level ranged metric (unique)");
    [[Playtomic Log] levelRangedMetricName:@"ranged" andLevel:@"named" andTrackValue:30 andUnique:true];
    [[Playtomic Log] levelRangedMetricName:@"ranged" andLevelNumber:1 andTrackValue:40 andUnique:true];
    [[Playtomic Log] forceSend];
}

// gamevars
- (void)loadGameVars
{
    NSLog(@"Loading GameVars");
    PlaytomicResponse *gamevars = [[Playtomic GameVars] load];
        
    if([gamevars success])
    {    
        NSLog(@"%@ = %@", @"GameVar1", [gamevars getValueForName:@"GameVar1"]);
        NSLog(@"%@ = %@", @"GameVar2", [gamevars getValueForName:@"GameVar2"]);
    }
    else
    {
        NSLog(@"GameVars failed to load because of errorcode #%d", [gamevars errorCode]);
    }
}

- (void)loadGameVarsAsync
{
    NSLog(@"Loading GameVarsAsync");
    [[Playtomic GameVars] loadAsync:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestLoadGameVarsFinished:(PlaytomicResponse*)response
{    
    if([response success])
    {            
        NSLog(@"%@ = %@", @"GameVar1", [response getValueForName:@"GameVar1"]);
        NSLog(@"%@ = %@", @"GameVar2", [response getValueForName:@"GameVar2"]);
    }
    else
    {
        NSLog(@"GameVarsAsync failed to load because of errorcode #%d", [response errorCode]);
    }
}

// gamevars
- (void)loadGeoIP
{
    NSLog(@"Loading GeoIP");
    
    PlaytomicResponse *lookup = [[Playtomic GeoIP] load];
    
    if([lookup success])
    {            
        NSLog(@"Location code: %@, name: %@"
              , [lookup getValueForName:@"Code"]
              , [lookup getValueForName:@"Name"]);
    }
    else
    {
        NSLog(@"GeoIP failed to load because of errorcode #%d", [lookup errorCode]);
    }
}

- (void)loadGeoIPAsync
{
    NSLog(@"Loading GeoIPAsync");
    
    [[Playtomic GeoIP] loadAsync:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestLoadGeoIPFinished:(PlaytomicResponse*)response
{
    if([response success])
    {   
        NSLog(@"Location code: %@, name: %@"
              , [response getValueForName:@"Code"]
              , [response getValueForName:@"Name"]);
    }
    else
    {
        NSLog(@"GeoIPAsync failed to load because of errorcode #%d", [response errorCode]);
    }
}

// leaderboards
- (void)leaderboardList
{
    NSLog(@"Leaderboard list");
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] listTable:@"High scores" 
                                                           andHighest:YES 
                                                              andMode:@"alltime" 
                                                              andPage:1 
                                                           andPerPage:20 
                                                      andCustomFilter:nil];
    
    if([response success])
    {
        NSLog(@"%d scores were returned:", [response getNumResults]);
        
        for(PlaytomicScore* score in [response data])
        {
            NSLog(@"%@ scored %d on %@"
                  , [score getName]
                  , [score getPoints]
                  , [score getRelativeDate]);
            
            if([[score getCustomData] count] > 0)
            {
                NSDictionary* data = [score getCustomData];
                
                for(id x in data)
                {
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Leaderboard list failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardListAsync
{
    NSLog(@"Leaderboard listAsync");
    
    [[Playtomic Leaderboards] listAsyncTable:@"High scores" 
                                  andHighest:YES 
                                     andMode:@"alltime" 
                                     andPage:1 
                                  andPerPage:20 
                             andCustomFilter:nil 
                                 andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestListLeaderboardFinished:(PlaytomicResponse*)response
{   
    if([response success])
    {
        NSLog(@"%d scores were returned:", [response getNumResults]);
        
        for(PlaytomicScore* score in [response data])
        {
            NSLog(@"%@ scored %d on %@"
                  , [score getName]
                  , [score getPoints]
                  , [score getRelativeDate]);
            
            if([[score getCustomData] count] > 0)
            {
                NSDictionary* data = [score getCustomData];
                
                for(id x in data)
                {
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Leaderboard listAsync failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardSave
{
    NSLog(@"Leaderboard Save");
    
    PlaytomicScore* score = [[[PlaytomicScore alloc] initNewScoreWithName:@"Ben" andPoints:2000000] autorelease];
    [score addCustomValue:@"customdata" andValue:@"this is the custom data"];
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] saveTable:@"High scores" 
                                                             andScore:score 
                                                           andHighest:YES 
                                                   andAllowDuplicates:YES];
    
    if([response success])
    {
        NSLog(@"Score saved successfully");
    }
    else
    {
        NSLog(@"Leaderboard save failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardCreatePrivate
{
    NSLog(@"Leaderboard create private");
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] createPrivateLeaderboardName:@"Private test" andHighest:YES];
    
    if([response success])
    {
        NSLog(@"private leaderboard created");
    }
    else
    {
        NSLog(@"failed to create the private leaderboard because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardLoadPrivate
{
    NSLog(@"Leaderboard create private");
    
    PlaytomicResponse* response = [[Playtomic Leaderboards] loadPrivateLeaderboardTableId:@"4ebd35f04d81231060639972"];
    
    if([response success])
    {
        NSLog(@"private leaderboard loaded");
    }
    else
    {
        NSLog(@"failed to load the private leaderboard because of errorcode #%d", [response errorCode]);
    }
}


- (void)leaderboardCreatePrivateAsync
{
    NSLog(@"Leaderboard create private Async");
    
    [[Playtomic Leaderboards] createPrivateLeaderboardAsyncName:@"Private test" andHighest:YES andDelegate:self];
    
}

- (void)requestCreateprivateLeaderboardFinish:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"private leaderboard created Async");
    }
    else
    {
        NSLog(@"failed to create the private leaderboard because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardLoadPrivateAsync
{
    NSLog(@"Leaderboard load private Async");
    
   [[Playtomic Leaderboards] loadPrivateLeaderboardTableAsyncId:@"4ebd35f04d81231060639972" andDelegate:self];
    
}

- (void)requestLoadprivateLeaderboardFinish:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"private leaderboard loaded async");
    }
    else
    {
        NSLog(@"failed to load the private leaderboard because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardSaveAsync
{
    NSLog(@"Leaderboard SaveAsync");
    
    PlaytomicScore* score = [[[PlaytomicScore alloc] initNewScoreWithName:@"Ben" andPoints:2000000] autorelease];
    [score addCustomValue:@"customdata" andValue:@"this is the custom data"];
    
    
    [[Playtomic Leaderboards] saveAsyncTable:@"High scores" 
                                    andScore:score 
                                  andHighest:YES 
                          andAllowDuplicates:YES 
                                 andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestSaveLeaderboardFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"Score saved successfully");
    }
    else
    {
        NSLog(@"Leaderboard save failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)leaderboardSaveAndList
{
    NSLog(@"Leaderboard SaveAndListAsync");
    
    PlaytomicScore* score = [[[PlaytomicScore alloc] initNewScoreWithName:@"Ben" andPoints:2000000] autorelease];
    [score addCustomValue:@"customdata" andValue:@"this is the custom data"];
        
    PlaytomicResponse *response = [[Playtomic Leaderboards] saveAndListTable:@"High scores" 
                                                                    andScore:score 
                                                                  andHighest:YES 
                                                          andAllowDuplicates:YES 
                                                                     andMode:@"alltime" 
                                                                  andPerPage:20 
                                                             andCustomFilter:nil];
    if([response success])
    {
        NSLog(@"Score saved successfully");
    }
    else
    {
        NSLog(@"Leaderboard saveAndListAsync failed to load because of errorcode #%d", [response errorCode]);
    }
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Leaderboard saveAndListAsync failed to load because of errorcode #%d", [response errorCode]);
    }    
}

- (void)leaderboardSaveAndListAsync
{
    NSLog(@"Leaderboard SaveAndListAsync");
    
    PlaytomicScore* score = [[[PlaytomicScore alloc] initNewScoreWithName:@"Ben" andPoints:2000000] autorelease];
    [score addCustomValue:@"customdata" andValue:@"this is the custom data"];
    
    [[Playtomic Leaderboards] saveAndListAsyncTable:@"High scores" 
                                           andScore:score 
                                         andHighest:YES 
                                 andAllowDuplicates:YES 
                                            andMode:@"alltime" 
                                         andPerPage:20 
                                    andCustomFilter:nil 
                                        andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestSaveAndListLeaderboardFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"Score saved successfully");
    }
    else
    {
        NSLog(@"Leaderboard saveAndListAsync failed to load because of errorcode #%d", [response errorCode]);
    }
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Leaderboard saveAndListAsync failed to load because of errorcode #%d", [response errorCode]);
    }    
}

// player levels
- (void)levelList
{
    NSLog(@"Level list");
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] listMode:@"popular" andPage:1 andPerPage:10 andIncludeData:NO andIncludeThumbs:NO andCustomFilter:nil];
    
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Level list failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelListAsync
{
    NSLog(@"Level list asyncronous");
    
    [[Playtomic PlayerLevels] listAsyncMode:@"popular" andPage:1 andPerPage:10 andIncludeData:NO andIncludeThumbs:NO andCustomFilter:nil andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestListPlayerLevelsFinished:(PlaytomicResponse*)response
{
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
        }
    }
    else
    {
        NSLog(@"Level list asyncronous failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelSave
{
    NSLog(@"Level save");
    
    PlaytomicLevel* level = [[[PlaytomicLevel alloc] initWithName:[NSString stringWithFormat:@"level name %d", arc4random() % 100]
                                                   andPlayerName:@"ben4" 
                                                     andPlayerId:0 
                                                         andData:@"r=-152&i0=13,440,140&i1=24,440,140&i2=25,440,140&i3=37,440,140,ie,37,450,150"] autorelease];
    PlaytomicResponse* response = [[Playtomic PlayerLevels] saveLevel:level];
    
    if([response success])
    {
        self.levelid = [response getValueForName:@"LevelId"];
        NSLog(@"Save succeeded: %@", self.levelid);
    }
    else
    {
        NSLog(@"Save failed because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelSaveAsync
{
    NSLog(@"Level save asyncronous");
    
    PlaytomicLevel* level = [[[PlaytomicLevel alloc] initWithName:[NSString stringWithFormat:@"level name %d", arc4random() % 100] 
                                                   andPlayerName:@"ben4" 
                                                     andPlayerId:0 
                                                         andData:@"r=-152&i0=13,440,140&i1=24,440,140&i2=25,440,140&i3=37,440,140,ie,37,450,150"] autorelease];
    [[Playtomic PlayerLevels] saveAsyncLevel:level andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestSavePlayerLevelsFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        self.levelid = [response getValueForName:@"LevelId"];
        NSLog(@"Save asyncronous succeeded: %@", levelid);
    }
    else
    {
        NSLog(@"Save asyncronous failed because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelRate
{
    NSLog(@"Level rate");
    
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] retryLevel:self.levelid];
    [[Playtomic PlayerLevels] winLevel:self.levelid];
    [[Playtomic PlayerLevels] quitLevel:self.levelid];
    [[Playtomic PlayerLevels] flagLevel:self.levelid];
    [[Playtomic Log] forceSend];
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] rateLevelid:self.levelid andRating:8];
    
    if([response success])
    {
        NSLog(@"Rate succeeded");
    }
    else
    {
        NSLog(@"Rate failed because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelRateAsync
{
    NSLog(@"Level rate asyncronous");
    
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] startLevel:self.levelid];
    [[Playtomic PlayerLevels] retryLevel:self.levelid];
    [[Playtomic PlayerLevels] winLevel:self.levelid];
    [[Playtomic PlayerLevels] quitLevel:self.levelid];
    [[Playtomic PlayerLevels] flagLevel:self.levelid];
    [[Playtomic Log] forceSend];
    
    [[Playtomic PlayerLevels] rateAsyncLevelid:self.levelid andRating:8 andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestRatePlayerLevelsFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"Rate asyncronous succeeded");
    }
    else
    {
        NSLog(@"Rate asyncronous failed because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelLoad
{
    NSLog(@"Level load syncronous");
    
    PlaytomicResponse* response = [[Playtomic PlayerLevels] loadLevelid:self.levelid];
    
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
                }
            }
            
            NSLog(@" with data %@", [level getData]);
        }
    }
    else
    {
        NSLog(@"Level failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)levelLoadAsync
{
    NSLog(@"Level load asynchronous");
    
    [[Playtomic PlayerLevels] loadAsyncLevelid:self.levelid andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestLoadPlayerLevelsFinished:(PlaytomicResponse*)response
{
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
                    NSLog(@" with custom data %@ = %@", x, [data objectForKey:x]);
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
- (void)getViews
{
    NSLog(@"get views");
    
    PlaytomicResponse* response = [[Playtomic Data] views];
    
    if([response success])
    {
        NSLog(@"view data was returned: %@", [response getValueForName:@"Value"]);
    }
    else
    {
        NSLog(@"view data failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)getViewsAsync
{
    NSLog(@"get views asynchronous");
    
    [[Playtomic Data] viewsAsync:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestViewsDataFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"view data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"view data failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)getCustom
{
    NSLog(@"get custom");
    
    PlaytomicResponse* response = [[Playtomic Data] customMetricName:@"hi"];
    
    if([response success])
    {
        NSLog(@"custom data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"custom data failed to load because of errorcode #%d", [response errorCode]);
    }
}

- (void)getCustomAsync
{
    NSLog(@"get custom asynchronous");
    
    [[Playtomic Data] customMetricAsyncName:@"hi" andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//

- (void)requestCustomMetricDataFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"custom data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"custom data failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)getPlaysAsync
{
    NSLog(@"get plays asynchronous");
    
    [[Playtomic Data] playsAsync:self];
}

// PlaytomicDelegate protocol implementation
//

- (void)requestPlaysDataFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"play data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"play data failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)getPlaytimeAsync
{
    NSLog(@"get playtime asynchronous");
    
    [[Playtomic Data] playtimeAsync:self];
}

// PlaytomicDelegate protocol implementation
//
- (void)requestPlaytimeDataFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"playtime data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"playtime data failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)getCounterMetricAsync
{
    NSLog(@"get counter metric asynchronous");
    
    [[Playtomic Data] levelCounterMetricAsyncName:@"hi" andLevel:@"level 1" andDelegate:self];
}

// PlaytomicDelegate protocol implementation
//

- (void)requestLevelMetricCounterDataFinished:(PlaytomicResponse*)response
{
    if([response success])
    {
        NSLog(@"counter data was returned: %@", [response getValueForName:@"Value"]);        
    }
    else
    {
        NSLog(@"counter data failed to load asynchronous because of errorcode #%d", [response errorCode]);
    }
}

- (void)freeze
{
    [[Playtomic Log] freeze];
}

- (void)unfreeze
{
    [[Playtomic Log] unfreeze];
}

- (void)dealloc
{
    self.levelid = nil;
    [super dealloc];
}

@end
