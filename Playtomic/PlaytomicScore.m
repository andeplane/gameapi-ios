//
//  PlayerScore.m
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "PlaytomicScore.h"


@interface PlaytomicScore ()
@property (nonatomic,copy) NSString *name;
@property (nonatomic,readwrite) NSInteger points;
@property (nonatomic,copy) NSDate *date;
@property (nonatomic,copy) NSString *relativeDate;
@property (nonatomic,retain) NSMutableDictionary *customData;
@end

@implementation PlaytomicScore

@synthesize name;
@synthesize points;
@synthesize date;
@synthesize relativeDate;
@synthesize customData;

-(id) initNewScoreWithName:(NSString *)pname andPoints:(NSInteger)ppoints
{
    self.name = pname;
    self.points = ppoints;
    self.customData = [[NSMutableDictionary alloc] init];
    return self; 
}

-(id) initWithName:(NSString*) pname andPoints: (NSInteger) ppoints andDate: (NSDate*) pdate andRelativeDate:(NSString*)relativedate andCustomData: (NSMutableDictionary*) customdata
{
    self.name = pname;
    self.points = ppoints;
    self.date = pdate;
    self.relativeDate = relativedate;
    self.customData = customdata;
    return self;
}

-(NSString*) getName
{
    return self.name;
}

-(NSInteger) getPoints
{
    return self.points;
}

-(NSDate*) getDate
{
    return self.date;
}

-(NSString*) getRelativeDate
{
    return self.relativeDate;
}

-(NSMutableDictionary*) getCustomData
{
    return self.customData;
}

-(NSString*) getCustomValue: (NSString*) key
{
    return [self.customData valueForKey: key];
}

-(void) addCustomValue: (NSString*) key andValue: (NSString*) value
{
    [self.customData setObject: value forKey: key];
}

@end