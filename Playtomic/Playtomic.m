//
//  Playtomic.m
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "Playtomic.h"
#import "PlaytomicLog.h"
#import "PlaytomicGameVars.h"
#import "PlaytomicGeoIP.h"
#import "PlaytomicLeaderboards.h"

@interface Playtomic ()
@property (nonatomic,readwrite) NSInteger gameId;
@property (nonatomic,copy) NSString *gameGuid;
@property (nonatomic,copy) NSString *sourceUrl;
@property (nonatomic,copy) NSString *baseUrl;
@property (assign) PlaytomicLog *log;
@property (assign) PlaytomicGameVars *gameVars;
@property (assign) PlaytomicGeoIP *geoIP;
@property (assign) PlaytomicLeaderboards *leaderboards;
@property (assign) PlaytomicPlayerLevels *playerLevels;
@end

@implementation Playtomic

@synthesize gameId;
@synthesize gameGuid;
@synthesize sourceUrl;
@synthesize baseUrl;
@synthesize log;
@synthesize gameVars;
@synthesize geoIP;
@synthesize leaderboards;
@synthesize playerLevels;

static Playtomic *instance = nil;

+ (void)initialize
{
    if (instance == nil)
    {
        instance = [[self alloc] init];
    }
}

+ (PlaytomicLog*)Log
{
	return instance.log;
}

+ (PlaytomicGameVars*)GameVars
{
	return instance.gameVars;
}

+ (PlaytomicGeoIP*)GeoIP
{
    return instance.geoIP;
}

+ (PlaytomicLeaderboards*)Leaderboards
{
    return instance.leaderboards;
}

+ (PlaytomicPlayerLevels*)PlayerLevels
{
    return instance.playerLevels;
}

+ (NSInteger) getGameId
{
    return instance.gameId;
}

+ (NSString*) getGameGuid
{
    return instance.gameGuid;
}

+ (NSString*) getSourceUrl
{
    return instance.sourceUrl;
}

+ (NSString*) getBaseUrl
{
    return instance.baseUrl;
}

- (id)initWithGameId: (NSInteger) gameid andGUID:(NSString*) gameguid
{
    instance.gameId = gameid;
    instance.gameGuid = gameguid;
    instance.sourceUrl = [NSString stringWithFormat:@"http://ios.com/%@/%@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
    instance.baseUrl = @"ios.com";

    instance.log = [[PlaytomicLog alloc] initWithGameId : gameid andGUID:  gameguid];
    instance.gameVars = [[PlaytomicGameVars alloc] init];
    instance.geoIP = [[PlaytomicGeoIP alloc] init];
    instance.leaderboards = [[PlaytomicLeaderboards alloc] init];
    instance.playerLevels = [[PlaytomicPlayerLevels alloc] init];
    return instance;    
}

@end
