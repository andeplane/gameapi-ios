//
//  PlaytomicLevel.h
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlaytomicLevel : NSObject {
    NSString *levelId;
    NSString *playerId;
    NSString *playerName;
    NSString *name;
    NSString *data;
    NSString *thumb;
    NSInteger votes;
    NSInteger plays;
    NSDecimalNumber *rating;
    NSInteger score;
    NSDate *date;
    NSString *relativeDate;
    NSMutableDictionary *customData;
}

-(id)initWithName: (NSString*) pname andPlayerName: (NSString*) pplayername andPlayerId: (NSString*) pplayerid andData: (NSString*) pdata;
-(id)initWithName: (NSString*) pname andPlayerName: (NSString*) pplayername andPlayerId: (NSString*) pplayerid andData: (NSString*) pdata andThumb: (NSString*) pthumb andVotes: (NSInteger) pvotes andPlays: (NSInteger) pplays andRating: (NSDecimalNumber*) rpating andScore: (NSInteger) pscore andDate: (NSDate*) pdate andRelativeDate: (NSString*) prelativedate andCustomData: (NSMutableDictionary*) pcustomdata andLevelId:(NSString*)levelid;
-(NSString*) getLevelId;
-(NSString*) getPlayerId;
-(NSString*) getPlayerName;
-(NSString*) getName;
-(NSString*) getData;
-(NSMutableData*) getThumbnail;
-(NSInteger) getVotes;
-(NSInteger) getPlays;
-(NSDecimalNumber*) getRating;
-(NSInteger) getScore;
-(NSDate*) getDate;
-(NSString*) getRelativeDate;
-(NSMutableDictionary*) getCustomData;
-(NSString*) getThumbnailURL;
-(NSString*) getCustomValue: (NSString*) key;
-(void) addCustomValue: (NSString*) key andValue: (NSString*) value;

@end
