//
//  PlaytomicLog.h
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaytomicLogRequest.h"

@interface PlaytomicLog : NSObject {
    NSString *trackUrl;
    NSString *sourceUrl;
    NSString *baseUrl;
    Boolean enabled;
    NSTimer *playTimer;
    NSTimer *firstPing;
    NSInteger pings;
    NSInteger views;
    NSInteger plays;
    Boolean frozen;
    NSMutableArray *queue;
    NSMutableArray *customMetrics;
    NSMutableArray *levelCounters;
    NSMutableArray *levelAverages;
    NSMutableArray *levelRangeds;
}

- (id) initWithGameId: (NSInteger) gameid andGUID:(NSString*) gameguid;
- (void) view;
- (void) play;
- (void) pingServer;
- (void) customMetric: (NSString*) name andGroup: (NSString*) group andUnique: (Boolean) unique;
- (void) levelCounterMetric: (NSString*) name andLevel: (NSString*) level andUnique: (Boolean) unique;
- (void) levelCounterMetric: (NSString*) name andLevelNumber: (NSInteger) levelnumber andUnique: (Boolean) unique;
- (void) levelRangedMetric: (NSString*) name andLevel: (NSString*) level andTrackValue: (NSUInteger) trackvalue andUnique: (Boolean) unique;
- (void) levelRangedMetric: (NSString*) name andLevelNumber: (NSInteger) levelnumber andTrackValue: (NSUInteger) trackvalue andUnique: (Boolean) unique;
- (void) levelAverageMetric: (NSString*) name andLevel: (NSString*) level andValue: (NSUInteger) value andUnique: (Boolean) unique;
- (void) levelAverageMetric: (NSString*) name andLevelNumber: (NSInteger) levelnumber andValue: (NSUInteger) value andUnique: (Boolean) unique;
- (void) link;
- (void) heatmap;
- (void) funnel;
- (void) playerLevelStart;
- (void) playerLevelWin;
- (void) playerLevelQuit;
- (void) playerLevelFlag;
- (void) freeze;
- (void) unfreeze;
- (void) forceSend;
- (void) send:(NSString*) event andCommit: (Boolean) commit;
- (NSString*) clean: (NSString*) string;
- (NSInteger) getCookie: (NSString*) name;
- (void) saveCookie;
- (void) increaseViews;
- (void) increasePlays;

@end
