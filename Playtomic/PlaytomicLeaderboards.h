//
//  GameVars.h
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaytomicResponse.h"
#import "PlaytomicScore.h"

@interface PlaytomicLeaderboards : NSObject {
}

- (PlaytomicResponse*) save: (NSString*) table andScore:(PlaytomicScore*) score andHighest: (Boolean)highest andAllowDuplicates: (Boolean)allowduplicates;
- (PlaytomicResponse*) list: (NSString*) table andHighest:(Boolean)highest andMode:(NSString*) mode andPage: (NSInteger) page andPerPage:(NSInteger) perpage andCustomFilter: (NSDictionary*) customfilter;


@end
