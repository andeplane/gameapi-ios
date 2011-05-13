//
//  PlaytomicRequest.h
//  Playtomic
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlaytomicLogRequest : NSObject {
    NSString *data;
    NSString *trackUrl;
}

- (id) initWithTrackUrl: (NSString*) url;
- (void) send;
- (void) queue: (NSString*) event;
- (void) massQueue: (NSMutableArray*) eventqueue;

@end
