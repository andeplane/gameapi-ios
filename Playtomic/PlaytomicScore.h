//
//  PlayerScore.h
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlaytomicScore : NSObject {
    NSString *name;
    NSInteger points;
    NSDate *date;
    NSString *relativeDate;
    NSMutableDictionary *customData;
}

-(id) initWithName:(NSString*) pname andPoints: (NSInteger) ppoints andDate: (NSDate*) pdate andRelativeDate:(NSString*)relativedate andCustomData: (NSMutableDictionary*) customdata;
-(id) initNewScoreWithName:(NSString*) pname andPoints: (NSInteger) ppoints;
-(NSString*) getName;
-(NSInteger) getPoints;
-(NSDate*) getDate;
-(NSString*) getRelativeDate;
-(NSMutableDictionary*) getCustomData;
-(NSString*) getCustomValue: (NSString*) key;
-(void) addCustomValue: (NSString*) key andValue: (NSString*) value;

@end
