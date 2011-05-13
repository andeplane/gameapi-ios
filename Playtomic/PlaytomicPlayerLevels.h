//
//  PlaytomicPlayerLevels.h
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaytomicLevel.h"


@interface PlaytomicPlayerLevels : NSObject {
    
}

-(PlaytomicResponse*) load:(NSString*) levelid;
-(PlaytomicResponse*) rate:(NSString*) levelid andRating: (NSInteger) rating;
-(PlaytomicResponse*) list:(NSString*) mode andPage:(NSInteger) page andPerPage:(NSInteger) perpage andIncludeData: (Boolean) includedata andIncludeThumbs: (Boolean) includethumbs andCustomFilter: (NSDictionary*) customfilter;
-(PlaytomicResponse*) listWithDateRange:(NSString*) mode andPage:(NSInteger) page andPerPage:(NSInteger) perpage andIncludeData: (Boolean) data andIncludeThumbs: (Boolean) includethumbs andCustomFilter: (NSDictionary*) customfilter andDateMin: (NSDate*) datemin andDateMax: (NSDate*) datemax;
-(PlaytomicResponse*) save:(PlaytomicLevel*) level;
@end
