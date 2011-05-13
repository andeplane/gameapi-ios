//
//  Playtomic.h
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaytomicLog.h"
#import "PlaytomicGameVars.h"
#import "PlaytomicGeoIP.h"
#import "PlaytomicLeaderboards.h"
#import "PlaytomicPlayerLevels.h"

@interface Playtomic : NSObject {
    
    NSInteger gameId;
    NSString *gameGuid;
    NSString *sourceUrl;
    NSString *baseUrl;
    PlaytomicLog *log;
    PlaytomicGameVars *gameVars;
    PlaytomicGeoIP *geoIP;
    PlaytomicLeaderboards *leaderboards;
    PlaytomicPlayerLevels *playerLevels;
}

- (id)initWithGameId: (NSInteger) gameid andGUID:(NSString*) gameguid;
+ (PlaytomicLog*) Log;
+ (PlaytomicGameVars*) GameVars;
+ (PlaytomicGeoIP*) GeoIP;
+ (PlaytomicLeaderboards*) Leaderboards;
+ (PlaytomicPlayerLevels*) PlayerLevels;
+ (NSInteger) getGameId;
+ (NSString*) getGameGuid;
+ (NSString*) getSourceUrl;
+ (NSString*) getBaseUrl;

@end
